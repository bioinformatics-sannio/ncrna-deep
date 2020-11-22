
# downloaded 371619 sequences from Rfam database splitted in train, val and test sets
#load("train_test_val_41_Rfam_families.RDa",verbose = T)
load("train_test_val_sets_177_families.RDa",verbose = T)

cat("Train: ",length(x_train),"\n")
cat("Val: ",length(x_val),"\n")
cat("Test: ",length(x_test),"\n")
cat("total:",length(x_train)+length(x_val)+length(x_test))

cat("Keep only commonclasses among sets")

commonclasses = unique(intersect(names(x_test),names(x_train)))
commonclasses = unique(intersect(names(x_val),commonclasses))

x_test = x_test[names(x_test) %in% commonclasses]
x_train = x_train[names(x_train) %in% commonclasses]
x_val = x_val[names(x_val) %in% commonclasses]

initialtot = length(x_train)+length(x_val)+length(x_test)

cat("Train: ",length(x_train),"\n")
cat("Val: ",length(x_val),"\n")
cat("Test: ",length(x_test),"\n")
cat("total:",initialtot)
cat("total classes:",length(commonclasses))

cat("Remove sequences with letters different from canonical A T C and G\n")
ca=vcountPattern('A',x_train)
ct=vcountPattern('T',x_train)
cc=vcountPattern('C',x_train)
cg=vcountPattern('G',x_train)
w=ca+ct+cc+cg
x_train=x_train[w==width(x_train)]
ca=vcountPattern('A',x_val)
ct=vcountPattern('T',x_val)
cc=vcountPattern('C',x_val)
cg=vcountPattern('G',x_val)
w=ca+ct+cc+cg
x_val=x_val[w==width(x_val)]
ca=vcountPattern('A',x_test)
ct=vcountPattern('T',x_test)
cc=vcountPattern('C',x_test)
cg=vcountPattern('G',x_test)
w=ca+ct+cc+cg
x_test=x_test[w==width(x_test)]


cat("Train: ",length(x_train),"\n")
cat("Val: ",length(x_val),"\n")
cat("Test: ",length(x_test),"\n")
cat("removed %:",1-(length(x_train)+length(x_val)+length(x_test))/initialtot)
cat("total classes:",length(unique(c(names(x_train),names(x_val),names(x_test)))))

# test whether seq length predict seq family

w = c(width(x_train),width(x_val),width(x_test))
q = c(names(x_train),names(x_val),names(x_test))
sdata = data.frame(length=w,family=as.factor(q))

plot(density(w))

library(caret)
require(C50)

dp = createDataPartition(sdata$family,times=10)
acc = c()
kappa = c()
f1byclass=c()
baccbyclass=c()
for(i in names(dp)) {
  dtrain = sdata[dp[[i]],]
  dtest = sdata[dp[[i]],]
  c5 <- C5.0(family ~ length, data=dtrain,trials=100)
  pc=predict(c5,dtest)
  tt = table(pc,dtest$family)
  #cat(dim(tt))
  cm = confusionMatrix(tt)
  acc=c(acc,cm$overall["Accuracy"])
  kappa=c(kappa,cm$overall["Kappa"])
  
  f1byclass = cbind(f1byclass,cm$byClass[,"F1"])
  baccbyclass = cbind(baccbyclass,cm$byClass[,"Balanced Accuracy"])
}

error <- qt(0.975,df=length(acc)-1)*sd(acc)/sqrt(length(acc))
cat("overall accuracy:")
cat(mean(acc),error)

error <- qt(0.975,df=length(kappa)-1)*sd(kappa)/sqrt(length(kappa))
cat("overall kappa:")
cat(mean(kappa),error)

meanBaccbyclass = apply(baccbyclass,1,mean,na.rm = T)
meanBaccbyclass = meanBaccbyclass[!is.nan(meanBaccbyclass)]
range(meanBaccbyclass)

meanf1byclass = apply(f1byclass,1,mean,na.rm = T)
meanf1byclass = meanf1byclass[!is.nan(meanf1byclass)]
range(meanf1byclass)
fakeclass = names(meanf1byclass[meanf1byclass>0.8])
fakeclass = substr(fakeclass,8,nchar(fakeclass))
fakeclass

x_test = x_test[!names(x_test) %in% fakeclass]
x_train = x_train[!names(x_train) %in% fakeclass]
x_val = x_val[!names(x_val) %in% fakeclass]

cat("Train: ",length(x_train),"\n")
cat("Val: ",length(x_val),"\n")
cat("Test: ",length(x_test),"\n")
cat("total seq:",length(x_train)+length(x_val)+length(x_test))
cat("removed %:",1-(length(x_train)+length(x_val)+length(x_test))/initialtot)
cat("total classes:",length(unique(c(names(x_train),names(x_val),names(x_test)))))


cat("Remove long seq > 200 to exclude long non coding RNA\n")
minlen = 0
maxlen = 200
x_train=x_train[width(x_train)<=maxlen & width(x_train)>=minlen]
x_val=x_val[width(x_val)<=maxlen & width(x_val)>=minlen]
x_test=x_test[width(x_test)<=maxlen & width(x_test)>=minlen]

cat("Train: ",length(x_train),"\n")
cat("Val: ",length(x_val),"\n")
cat("Test: ",length(x_test),"\n")
cat("total seq:",length(x_train)+length(x_val)+length(x_test))
cat("removed %:",1-(length(x_train)+length(x_val)+length(x_test))/initialtot)
cat("total classes:",length(unique(c(names(x_train),names(x_val),names(x_test)))))


cat("Exclude classes with less that 400 samples\n")
# the final set is of 168278 sequences distributed among 30 different Rfam classes 

x=table(names(x_train))
classi = names(x[x>=400])

cat("Number of classes to keep: ",length(classi),"\n")


x_test = x_test[names(x_test) %in% classi]
x_train = x_train[names(x_train) %in% classi]
x_val = x_val[names(x_val) %in% classi]


cat("Train: ",length(x_train),"\n")
cat("Val: ",length(x_val),"\n")
cat("Test: ",length(x_test),"\n")
cat("total seq:",length(x_train)+length(x_val)+length(x_test))
cat("removed %:",1-(length(x_train)+length(x_val)+length(x_test))/initialtot)
cat("total classes:",length(unique(c(names(x_train),names(x_val),names(x_test)))))


# figure distribution among different Rfam classes
require(ggplot2)
tcls=table(c(names(x_train),names(x_val),names(x_test)))
df = data.frame(Class=names(tcls),Samples=as.numeric(tcls))
ggplot(data=df, aes(x=Class, y=Samples)) + xlab("") + ylab("# of samples")+
  geom_bar(stat="identity", width=0.5)+theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=16))
ggsave("class-distribution.pdf",height = 6 , width = 15)

df = data.frame(Class=c(names(x_train),names(x_val),names(x_test)),
                Len=c(width(x_train),width(x_val),width(x_test)))

ggplot(data=df, aes(x=Class, y=Len)) + xlab("") + ylab("Seq len")+
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=1,notch=TRUE)+ theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=16))
ggsave("class-len-distribution.pdf",height = 6 , width = 15)


cat("Balancing of training/validation sets\n")
minsize = min(table(names(x_train)))
minsize = minsize*3
x_train_new = DNAStringSet()
x_val_new = DNAStringSet()
for (i in classi) {
  a = x_train[names(x_train) %in% i]
  a = a[sample(1:length(a),minsize,replace = T)]
  x_train_new = c(x_train_new,a)
  a = x_val[names(x_val) %in% i]
  if (minsize<=length(a)) {
    a = a[sample(1:length(a),minsize,replace = F)]
  }
  x_val_new = c(x_val_new,a)
}
cat("Train: ",length(x_train_new),"\n")
cat("Val: ",length(x_val_new),"\n")

ttot = length(x_train) + length(x_test)+length(x_val)
cat(length(x_train)/ttot,length(x_test)/ttot,length(x_val)/ttot)

writeXStringSet(x_train_new,"x_train.fasta")
writeXStringSet(x_val_new,"x_val.fasta")
writeXStringSet(x_test,"x_test.fasta")

