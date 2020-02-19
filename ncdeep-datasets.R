require(Biostrings)


#load("/storage/gluster/vol1/SHARED/HOMEFOLDERS/noviello/Deep_learning_2019/train_test_val_sets_200_sequences.RDa")
#load("/storage/gluster/vol1/SHARED/HOMEFOLDERS/noviello/Deep_learning_2019/train_test_val_sets_200_sequences_Undersampling.RDa")
load("/storage/gluster/vol1/SHARED/HOMEFOLDERS/noviello/Deep_learning_2019/train_test_val_sets_All_sequences_41_families.RDa")

length(x_train)
length(x_val)
length(x_test)
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
length(x_train)
length(x_val)
length(x_test)

length(x_train)
table(names(x_train))
minlen = 50
maxlen = 150
x_train=x_train[width(x_train)<=maxlen & width(x_train)>=minlen]
x_val=x_val[width(x_val)<=maxlen & width(x_val)>=minlen]
x_test=x_test[width(x_test)<=maxlen & width(x_test)>=minlen]

length(x_train)
x=table(names(x_train))
classi = names(x[x>=400])
length(classi)

cc = intersect(unique(names(x_val)),unique(names(x_test)))
classi = intersect(cc,classi)
length(classi)


x_train = x_train[names(x_train) %in% classi]
length(x_train)
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
table(names(x_train_new))
length(x_train_new)
writeXStringSet(x_train_new,"x_train.fasta")
table(names(x_val_new))
length(x_val_new)
writeXStringSet(x_val_new,"x_val.fasta")

length(x_test)
x_test = x_test[names(x_test) %in% classi]
length(x_test)
table(names(x_test))
writeXStringSet(x_test,"x_test.fasta")

