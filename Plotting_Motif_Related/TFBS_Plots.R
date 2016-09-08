#Script to make a graphical map of TF binding sites on a given promoter.
#Erin Sparks
#April 2015

setwd("~/Desktop/")

library("ggplot2")

#Plot for the SHR promoter
SHR <-read.csv("SHR_Motifs.csv")
head(SHR)

p <- ggplot(SHR, aes(Motif.Start.Position.Relative.to.ATG,FIMO.Score)) +theme_grey()

#Horizontal lines represent DHS root data from (Sullivan et al., 2014).  Vertical line represents the TSS from TAIR.

p +geom_segment(aes(x=101, y=-10, xend = 250, yend=-10)) + geom_segment(aes(x=1501, y=-10, xend=1650, yend=-10)) + geom_point(col=SHR$Y1H.Validated, size=SHR$Size) + xlim (2500,0) + geom_segment(aes(x=85, y=-12, xend=85, yend=-8))


#Plot for the SCR promoter
SCR <-read.csv("SCR_Motifs.csv")
head(SCR)

p <- ggplot(SCR, aes(Motif.Start.Position.Relative.to.ATG,FIMO.Score)) 

p +geom_segment(aes(x=1400, y=-10, xend = 1549, yend=-10)) + geom_segment(aes(x=1980, y=-10, xend=2129, yend=-10)) + geom_point(col=SCR$Y1H.Validated, size=SCR$Size) + xlim(2000,0) + geom_segment(aes(x=392, y=-12, xend=392, yend=-8))




