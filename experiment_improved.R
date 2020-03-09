library(tensorflow)
library(keras)
library(PRROC)
library(reticulate)
library(caret)

calculate.mcc <- function(ct, nbcat=nrow(ct)) {
  if(nrow(ct) != ncol(ct)) { stop("the confusion table should be square!") }
  if(!(sum(ct)==sum(diag(ct))) &&  (length(which(apply(ct, 1, sum) == 0)) == (nbcat-1) & ((length(which(apply(ct, 2, sum) == 0)) != (nbcat-1)) | (length(which(apply(ct, 2, sum) == 0)) == (nbcat-1)))) || (length(which(apply(ct, 2, sum) == 0)) == (nbcat-1) & ((length(which(apply(ct, 1, sum) == 0)) != (nbcat-1)) | (length(which(apply(ct, 1, sum) == 0)) == (nbcat-1)) & sum(diag(ct)) == 0))) { ct <- ct + matrix(1, ncol=nbcat, nrow=nbcat) } ### add element to categories if nbcat-1 predictive categories do not contain elements. Not in case where all are correct!
  
  if(sum(ct, na.rm=TRUE) <= 0) { return(NA) }
  
  myx <- matrix(TRUE, nrow=nrow(ct), ncol=ncol(ct))
  diag(myx) <- FALSE
  if(sum(ct[myx]) == 0) { return(1) }
  myperf <- 0
  for(k in 1:nbcat) {
    for(m in 1:nbcat) {
      for(l in 1:nbcat) {
        myperf <- myperf + ((ct[k, k] * ct[m, l]) - (ct[l, k] * ct[k, m]))
      }
    }
  }
  aa <- 0
  for(k in 1:nbcat) {
    cc <- 0
    for(l in 1:nbcat) { cc <- cc + ct[l, k] }
    dd <- 0
    for(f in 1:nbcat) {
      for(g in 1:nbcat) { if(f != k) { dd <- dd + ct[g, f] } }
    }
    aa <- aa + (cc * dd)
  }
  bb <- 0
  for(k in 1:nbcat) {
    cc <- 0
    for(l in 1:nbcat) { cc <- cc + ct[k, l] }
    dd <- 0
    for(f in 1:nbcat) {
      for(g in 1:nbcat) { if(f != k) { dd <- dd + ct[f, g] } }
    }
    bb <- bb + (cc * dd)
  }
  
  myperf <- myperf / (sqrt(aa) * sqrt(bb))
  return(myperf)
}

encodings <- c("1mer","2mer","3mer","Morton","Snake","Hilbert")

Result <- matrix(0,nrow = 6,ncol = 5)
rownames(Result) <- encodings
colnames(Result) <- c("Accuracy","Recall","Precision","F1-score","MCC")

for(e in encodings){
  
  np <-import("numpy")
  
  train <- np$load(paste0("dataset_nRC_train_",e,"_new_seq.npy"))
  pos1 <- sample(1:dim(train)[1],replace = F)
  x_train <- to_categorical(train[pos1,])
  y_train <- np$load("dataset_nRC_train_labels.npy")  
  y_train <- y_train[pos1]
  
  test <- np$load(paste0("dataset_nRC_test_",e,"_new_seq.npy"))
  pos2 <- sample(1:dim(test)[1],replace = F)
  x_test <- to_categorical(test[pos2,])
  y_test <- np$load("dataset_nRC_test_labels.npy") 
  y_test <- y_test[pos2] 
  
  dim1 <- dim(x_train[1,,])[1]
  dim2 <- dim(x_train[1,,])[2]
  
  if(e %in% c("1mer","2mer","3mer")){

    model<- keras::keras_model_sequential() %>%
      
      layer_conv_1d(filters = 128, kernel_size = 10,
                    input_shape = c(dim1,dim2),padding = "same") %>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      layer_max_pooling_1d(pool_size = 2)%>%
      layer_conv_1d(filters = 128, kernel_size = 10,padding = "same") %>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      layer_max_pooling_1d(pool_size = 4)%>%
      layer_gaussian_noise(0.3) %>%
      
      layer_conv_1d(filters = 256, kernel_size = 10,padding = "same") %>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      layer_max_pooling_1d(pool_size = 2)%>%
      layer_conv_1d(filters = 256, kernel_size = 10,padding = "same")%>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      layer_max_pooling_1d(pool_size = 4)%>%
      layer_gaussian_noise(0.3) %>%
      
      layer_conv_1d(filters = 256, kernel_size = 10,padding = "same")%>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      layer_max_pooling_1d(pool_size = 4)%>%
      layer_gaussian_noise(0.3) %>%
      layer_dropout(0.2) %>%
      
      layer_flatten() %>%
      
      layer_dense(units = 128) %>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      
      layer_dense(units = 64) %>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      
      layer_dense(units = 13, activation = "softmax")
  } else {
    
    dim3 <- dim(x_train[1,,,])[3]
    
    model <- keras::keras_model_sequential() %>%
      
      layer_conv_2d(filters = 128, kernel_size = c(3,3),
                    kernel_regularizer =  regularizer_l2(0.003),
                    input_shape = c(dim1,dim2,dim3),padding = "same") %>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      layer_conv_2d(filters = 128, kernel_size = c(3,3),padding = "same") %>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      layer_max_pooling_2d(pool_size = c(2,2))%>%
      layer_gaussian_noise(0.3) %>%

      layer_conv_2d(filters = 256, kernel_size = c(3,3),padding = "same") %>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      layer_conv_2d(filters = 256, kernel_size = c(3,3),padding = "same")%>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      layer_max_pooling_2d(pool_size = c(2,2))%>%
      layer_gaussian_noise(0.3) %>%

      layer_conv_2d(filters = 256, kernel_size = c(3,3),padding = "same")%>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      layer_max_pooling_2d(pool_size = c(2,2))%>%
      layer_gaussian_noise(0.3) %>%
      layer_dropout(0.2) %>%

      layer_flatten() %>%
      
      layer_dense(units = 128) %>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      
      layer_dense(units = 64) %>%
      layer_batch_normalization()%>%
      layer_activation_leaky_relu(alpha = 0.5)%>%
      
      layer_dense(units = 13, activation = "softmax")
    
  }
  
  model %>% keras::compile(
    optimizer = optimizer_adam(lr = .0005,amsgrad = TRUE),
    loss = "categorical_crossentropy",
    metrics = "accuracy")
  
  y_train <- to_categorical(as.numeric(as.factor(y_train)) - 1)
  
  model %>% keras::fit(x_train, y_train, epochs = 25)
  model %>% keras::evaluate(x_test,to_categorical(as.numeric(as.factor(y_test)) - 1))
  
  predict_class <- model %>% keras::predict_classes(x_test)
  y_test <- as.factor(as.numeric(as.factor(y_test)) - 1)
  predict_class <- as.factor(predict_class)
  
  cm <- caret::confusionMatrix(predict_class,y_test,mode="everything")
  
  Result[e,1] <- cm$overall[1]
  Result[e,3] <- colMeans(cm$byClass)[5]
  Result[e,2] <- colMeans(cm$byClass)[6]
  Result[e,4] <- colMeans(cm$byClass)[7]
  Result[e,5] <- mcc(cm$table)

}

