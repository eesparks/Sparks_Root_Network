#Script to make a Box Plots for Fluorescent Quantification
#Erin Sparks
#April 2015

library("ggplot2")
library("scales")
library("reshape2")
library("grid")

setwd("~/Desktop/")

SHR <-read.csv("SHR_Fluor_Quant_New2.csv")
head(SHR)

SHR$Genotype=factor(SHR$Genotype, levels=unique(SHR$Genotype))


ggplot(SHR, aes (Genotype, Raw.Int.Den.10.5)) + scale_fill_identity(SHR$Color) + geom_boxplot(aes(fill= SHR$Color), fatten=2, lwd=1.5, outlier.size=4) + geom_jitter(position = position_jitter(width=.08), size=4) + theme(axis.text.x = element_text(size=30, colour="black", hjust=1, vjust=0.5, angle = 90), axis.text.y = element_text(size=30, colour="black"), axis.text=element_text(size=30), axis.title = element_text(size=30), axis.title.y= element_text(vjust=2.5), axis.title.x= element_text(vjust=-1.4),legend.key.size = unit(1.5, "cm"), plot.margin = unit(c(1,1,2,1), "cm"), strip.background=element_rect(fill=SHR$Type, size = 3), axis.ticks.length = unit(.5,"cm")) + ylab("Raw Integrated Density (10^5)") + xlab("") 
