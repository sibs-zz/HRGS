rm(list=ls())
library(BGLR)
args=commandArgs(T)
DT <- read.table(args[1],header = T)
GT <- read.table(args[2],header = F , row.names = 1)

sss = 2839
bbb = round(sss/5)




GT = data.matrix(GT)
y = DT
tst<-sample(1:sss,size=bbb,replace=FALSE)
#y$danzhuchanliang[tst]<-NA
#data(wheat)
#set.seed(12345)
#varB=0.5*(1/sum(apply(X=wheat.X,MARGIN=2,FUN=var)))
#b0=rnorm(n=1279,sd=sqrt(varB))
#signal=wheat.X%*%b0
#error=rnorm(599,sd=sqrt(0.5))
#y=100+signal+error

nIter=500;
burnIn=100;
thin=3;
saveAt='';
S0=NULL;
weights=NULL;
R2=0.5;

K=GT%*%t(GT)

ETA=list(list(K=K,model='RKHS'))

fit_RKHS=BGLR(y=y$danzhuchanliang,ETA=ETA,nIter=nIter,burnIn=burnIn,thin=thin,saveAt=saveAt,df0=5,S0=S0,weights=weights,R2=R2,verbose=F)
#plot(fit_RKHS$yHat,y)
#cor(fit_RKHS$yHat,y)
#cor(fit_RKHS$yHat[tst],DT$danzhuchanliang[tst])
write.table(fit_RKHS$yHat,"7_danzhuchanliang.txt",row.names = T,quote = F)
