#This script was used to make a dendrogram of the TF similarity based on the same binding motifs.  The order defined by this clustering will define the order for a heatmap for shared Y1H targets.
#Erin Sparks
#Oct, 2014


motifs <- read.csv("Shared_Motif_Matrix.csv")
d <- dist(as.matrix(df))
hc <- hclust(d, method = "ward", members = NULL)
#plot(hc, hang = -1)

#install.packages('ape')
#library(ape)

#plot(as.phylo(hc), cex = 0.9, label.offset = 1)

#library(ggdendro)

#ggdendrogram(hc)

hcd = as.dendrogram(hc)

plot(hcd, labels = NULL, axes = FALSE, frame.plot = FALSE, ann = FALSE, main = "TF Motif Clusters", sub = NULL, xlab = NULL, ylab = NULL)

