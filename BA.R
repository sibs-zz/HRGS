rm(list=ls())
#loads BGLR & Data
library(BGLR)
args=commandArgs(T)
##BA###################################################################
DT <- read.table(args[1],header = T)
GT <- read.table(args[2],header = F, row.names = 1)

sss = 2839
bbb = round(sss/5)

n<-nrow(GT)  
p<-ncol(GT)  

X<-GT[1:n,1:p]
tst<-sample(1:sss,size=bbb,replace=FALSE)
y = DT
#y$danzhuchanliang[tst]<-NA

## Centering and standarization
for(i in 1:p)
{ 
  X[,i]<-(X[,i]-mean(X[,i]))/sd(X[,i]) 
}
#select = sample(1:p, size = floor(p / 12))
#X1 = X[,select]
X1 <- X[, seq(1, ncol(X), by = 19)]


nIter=500;
burnIn=100;
thin=3;
saveAt='';
S0=NULL;
weights=NULL;
R2=0.5;

ETA<-list(list(X=X1,model='BayesA'))
fit_BA=BGLR(y=y$danzhuchanliang,ETA=ETA,nIter=nIter,burnIn=burnIn,thin=thin,saveAt=saveAt,df0=5,S0=S0,weights=weights,R2=R2,verbose=F)
#cor(fit_BA$yHat[tst],DT$danzhuchanliang[tst])
write.table(fit_BA$yHat,"2_danzhuchanliang.txt",row.names = T,quote = F)
