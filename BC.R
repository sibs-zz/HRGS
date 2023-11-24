rm(list=ls())
library(BGLR)
args=commandArgs(T)

DT <- read.table(args[1],header = T)
GT <- read.table(args[2],header = F , row.names = 1)

#rownames(DT)<-paste(1:2839,"M",sep="")
sss = 2839
bbb = round(sss/5)



n<-nrow(GT)  
p<-ncol(GT)   


X<-GT[1:n,1:p]
y = DT
tst<-sample(1:sss,size=bbb,replace=FALSE)
#y$danzhuchanliang[tst]<-NA
## Centering and standarization
for(i in 1:p)
{ 
  X[,i]<-(X[,i]-mean(X[,i]))/sd(X[,i]) 
}
#select = sample(1:p, size = floor(p / 12))
#X1 = X[,select]
X1 <- X[, seq(1, ncol(X), by = 19)]
# Simulation
#b0<-rep(0,p)
#whichQTL<-sample(1:p,size=nQTL,replace=FALSE)
#b0[whichQTL]<-rnorm(length(whichQTL),
#                            sd=sqrt(1/length(whichQTL)))
#signal<-as.vector(X%*%b0)
#error<-rnorm(n=n,sd=sqrt(0.5))
#y<-signal +error 


nIter=5000;
burnIn=2500;
thin=3;
saveAt='';
S0=NULL;
weights=NULL;
R2=0.5;
ETA<-list(list(X=X1,model='BayesC'))

fit_BC=BGLR(y=y$danzhuchanliang,ETA=ETA,nIter=nIter,burnIn=burnIn,thin=thin,saveAt=saveAt,df0=5,S0=S0,weights=weights,R2=R2,verbose=F)
#plot(fit_BC$yHat,y)
#cor(fit_BC$yHat,y)
#cor(fit_BC$yHat[tst],DT$danzhuchanliang[tst])
write.table(fit_BC$yHat,"4_danzhuchanliang.txt",row.names = T,quote = F)
