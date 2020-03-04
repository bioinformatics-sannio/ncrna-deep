require(Biostrings)

# downloaded 199110 sequences from Rfam database splitted in train, val and test sets
load("train_test_val_41_Rfam_families.RDa",verbose = T)

cat("Train: ",length(x_train),"\n")
cat("Val: ",length(x_val),"\n")
cat("Test: ",length(x_test),"\n")

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

cat("Remove outliers\n")
minlen = 50
maxlen = 150
x_train=x_train[width(x_train)<=maxlen & width(x_train)>=minlen]
x_val=x_val[width(x_val)<=maxlen & width(x_val)>=minlen]
x_test=x_test[width(x_test)<=maxlen & width(x_test)>=minlen]

cat("Train: ",length(x_train),"\n")
cat("Val: ",length(x_val),"\n")
cat("Test: ",length(x_test),"\n")


cat("Exclude classes with less that 400 samples\n")
# the final set is of 168278 sequences distributed among 30 different Rfam classes 

x=table(names(x_train))
classi = names(x[x>=400])

cat("Number of classes: ",length(classi),"\n")

cat("Remove classes not in val and test set\n")
cc = intersect(unique(names(x_val)),unique(names(x_test)))
classi = intersect(cc,classi)
cat("Number of classes: ",length(classi),"\n")


x_train = x_train[names(x_train) %in% classi]
x_val = x_val[names(x_val) %in% classi]
x_test = x_test[names(x_test) %in% classi]

cat("Train: ",length(x_train),"\n")
cat("Val: ",length(x_val),"\n")
cat("Test: ",length(x_test),"\n")


# figure distribution among 30 different Rfam classes
require(ggplot2)
tcls=table(c(names(x_train),names(x_val),names(x_test)))
df = data.frame(Class=names(tcls),Samples=as.numeric(tcls))
ggplot(data=df, aes(x=Class, y=Samples)) + xlab("") + ylab("# of samples")+
  geom_bar(stat="identity", width=0.5)+theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=16))
ggsave("class-distribution.pdf",height = 6 , width = 10)

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

writeXStringSet(x_train_new,"x_train.fasta")
writeXStringSet(x_val_new,"x_val.fasta")

x_test = x_test[names(x_test) %in% classi]
writeXStringSet(x_test,"x_test.fasta")

