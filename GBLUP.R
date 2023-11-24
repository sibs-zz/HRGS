########args[1]表型
########args[2]基因型
library(sommer)
args=commandArgs(T)
DT = read.table(args[1],header = T,row.names = 1)
GT = read.table(args[2],row.names = 1,header = F)
GT = as.matrix(GT)
A = A.mat(GT)
DT$id <- DT$idd
y.trn <- DT
#vv <- sample(rownames(DT),round(nrow(DT)/5))
#y.trn[vv,str(args[3])] <- NA
mix1 <- mmer(danzhuchanliang~1,
             random=~vs(id,Gu=A),
             rcov=~units,
             data=DT, verbose = FALSE)
#mix1$U$`u:id`$danzhuchanliang <- as.data.frame(mix1$U$`u:id`$danzhuchanliang)
#cor(mix1$U$`u:id`$danzhuchanliang[vv,],DT[vv,"danzhuchanliang"], use="complete")i

ab = as.data.frame(mix1$U$`u:id`$danzhuchanliang)
#ab$"out" = ab$"mix2$U$`u:id`$danzhuchanliang"
write.table(ab,"1_danzhuchanliang.txt",row.names = T,quote = F)

