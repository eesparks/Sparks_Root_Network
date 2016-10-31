#Script to make bar graphs of qRT-PCR data
#Erin Sparks
#September 2015

library("ggplot2")
library("scales")
library("reshape2")
library("grid")
library("devtools")
library("easyGgplot2")

setwd("~/Desktop/TARGET/qRT-PCR_Results/")

SCR <-read.csv("SCR_qRTPCR.csv")
head(SCR)

SCR$X=factor(SCR$X, levels=unique(SCR$X))

p <- ggplot(SCR, aes(X,SCR$Ratio))

p +ylim (0,3) + geom_bar(stat="identity", fill=SCR$Color, colour="black") + geom_errorbar (ymin=SCR$Ratio - SCR$StDev, ymax= SCR$Ratio + SCR$StDev, width=0.2) + geom_hline(yintercept=1, size=2) +theme(axis.text.x = element_text(size=20, color="black", hjust=1, vjust=0.5, angle = 90), axis.text.y = element_text(size=20, color="black"), axis.text=element_text(size=17), axis.title = element_text(size=20), axis.title.y= element_text(vjust=2.5), axis.title.x= element_text(vjust=-1.4), plot.margin = unit(c(1,1,2,1), "cm"), axis.ticks.length = unit(.5,"cm")) + ylab("Efficiency Corrected Ratio") + xlab("")


SHR <-read.csv("SHR_qRTPCR.csv")
head(SHR)

SHR$X=factor(SHR$X, levels=unique(SHR$X))

q <- ggplot(SHR, aes(X,SHR$Ratio))

q + geom_bar(stat="identity", fill=SHR$Color, colour="black") + geom_errorbar (ymin=SHR$Ratio - SHR$StDev, ymax= SHR$Ratio + SHR$StDev, width=0.2)+ geom_hline(yintercept=1, size=2) +theme(axis.text.x = element_text(size=20, color="black", hjust=1, vjust=0.5, angle = 90), axis.text.y = element_text(size=20, color="black"), axis.text=element_text(size=17), axis.title = element_text(size=20), axis.title.y= element_text(vjust=2.5), axis.title.x= element_text(vjust=-1.4), plot.margin = unit(c(1,1,2,1), "cm"), axis.ticks.length = unit(.5,"cm")) + ylab("Efficiency Corrected Ratio") + xlab("")  + ylim(0,13)


CRF8 <-read.csv("CRF8_qRTPCR.csv")
head(CRF8)

CRF8$X=factor(CRF8$X, levels=unique(CRF8$X))

p <- ggplot(CRF8, aes(X,CRF8$Ratio))

p +ylim (0,50) + geom_bar(stat="identity", fill=CRF8$Color, colour="black") + geom_errorbar (ymin=CRF8$Ratio - CRF8$StDev, ymax= CRF8$Ratio + CRF8$StDev, width=0.2) + geom_hline(yintercept=1, size=2) +theme(axis.text.x = element_text(size=20, color="black", hjust=1, vjust=0.5, angle = 90), axis.text.y = element_text(size=20, color="black"), axis.text=element_text(size=17), axis.title = element_text(size=20), axis.title.y= element_text(vjust=2.5), axis.title.x= element_text(vjust=-1.4), plot.margin = unit(c(1,1,2,1), "cm"), axis.ticks.length = unit(.5,"cm")) + ylab("Efficiency Corrected Ratio") + xlab("")


#TARGET1 <-read.csv("TARGET_MYB36.csv")
#head(TARGET1)

#TARGET2 <-read.csv("TARGET_SCR.csv")
#head(TARGET2)

#TARGET3 <-read.csv("TARGET_SHR.csv")
#head(TARGET3)

#TARGET1$TF=factor(TARGET1$TF, levels=unique(TARGET1$TF))

#TARGET2$TF=factor(TARGET2$TF, levels=unique(TARGET2$TF))

#TARGET3$TF=factor(TARGET3$TF, levels=unique(TARGET3$TF))

#p <- ggplot(TARGET1, aes(TF,TARGET1$ECQ)) + geom_point(stat="identity",colour="black", size = 5) + geom_hline(yintercept=1, size=2) +theme(axis.text.x = element_text(size=20, color="black"), axis.text.y = element_text(size=20, color="black"), axis.text=element_text(size=17), axis.title = element_text(size=20), axis.title.y= element_text(vjust=2.5), axis.title.x= element_text(vjust=-1.4), plot.margin = unit(c(1,1,2,1), "cm"), axis.ticks.length = unit(.5,"cm"), strip.background=element_blank(), strip.text.x=element_blank()) + ylab("Efficiency Corrected Ratio") + xlab("")

#q <- ggplot(TARGET2, aes(TF,TARGET2$ECQ)) + geom_point(stat="identity",colour="red", size = 5) + geom_hline(yintercept=1, size=2) + facet_wrap(~TF, scales="free") +theme(axis.text.x = element_text(size=20, color="black"), axis.text.y = element_text(size=20, color="black"), axis.text=element_text(size=17), axis.title = element_text(size=20), axis.title.y= element_text(vjust=2.5), axis.title.x= element_text(vjust=-1.4), plot.margin = unit(c(1,1,2,1), "cm"), axis.ticks.length = unit(.5,"cm"), strip.background=element_blank(), strip.text.x=element_blank()) + ylab("Efficiency Corrected Ratio") + xlab("")

#r <- ggplot(TARGET3, aes(TF,TARGET3$ECQ)) + geom_point(stat="identity",colour=, size = 5) + geom_hline(yintercept=1, size=2)+ facet_wrap(~TF, scales="free") +theme(axis.text.x = element_text(size=20, color="black"), axis.text.y = element_text(size=20, color="black"), axis.text=element_text(size=17), axis.title = element_text(size=20), axis.title.y= element_text(vjust=2.5), axis.title.x= element_text(vjust=-1.4), plot.margin = unit(c(1,1,2,1), "cm"), axis.ticks.length = unit(.5,"cm"), strip.background=element_blank(), strip.text.x=element_blank()) + ylab("Efficiency Corrected Ratio") + xlab("")


p
q
r

ggplot2.multiplot(p,q,r, cols=1)




Target <- read.csv("TARGET_All.csv")
head(Target)

Target$TF=factor(Target$TF, levels=unique(Target$TF))

a <- ggplot(Target, aes(TF,ECQ)) + geom_point(stat="identity", aes(shape = Target), size=6) + geom_hline(yintercept=1, size=2) + facet_wrap(~Color, scales="free") +theme(axis.text.x = element_text(size=20, color="black",hjust=1, vjust=0.5,angle = 90), axis.text.y = element_text(size=20, color="black"), axis.text=element_text(size=17), axis.title = element_text(size=20), axis.title.y= element_text(vjust=2.5), axis.title.x= element_text(vjust=-1.4), plot.margin = unit(c(1,1,2,1), "cm"), axis.ticks.length = unit(.5,"cm"), strip.background=element_blank(), strip.text.x=element_blank(), legend.key.size=unit(1, "cm"), legend.position="bottom",legend.title = element_text(size=20),legend.text = element_text(size=20)) + ylab("Efficiency Corrected Ratio") + xlab("")





RM2 <- read.csv("RM2_Sum-DREB2A.csv")
head (RM2)

RM2$Cell_Type=factor(RM2$Cell_Type, levels=unique(RM2$Cell_Type))

p <- ggplot(RM2, aes(Cell_Type,Expression, fill=Relationship))

p + geom_bar(stat="identity", position = "dodge", width=0.8) + scale_fill_manual(values=c("green", "red")) +theme(axis.text.x = element_text(size=20, color="black",hjust=1, vjust=0.5,angle = 90), axis.text.y = element_text(size=20, color="black"), axis.text=element_text(size=17), axis.title = element_text(size=20), axis.title.y= element_text(vjust=2.5), axis.title.x= element_text(vjust=-1.4), plot.margin = unit(c(1,1,2,1), "cm"), axis.ticks.length = unit(.5,"cm"), strip.background=element_blank(), strip.text.x=element_blank(), legend.key.size=unit(1, "cm"), legend.position="bottom",legend.title = element_text(size=20),legend.text = element_text(size=20)) + ylab("Sum Mean Normalized Expression") + xlab("")
