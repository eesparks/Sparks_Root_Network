#Script used to generate a heatmap of shared targets based on TF motif similarity
#Erin Sparks
#Oct, 2014

#install.packages("gplots")
#install.packages("RColorBrewer")

library(gplots)
library(RColorBrewer)

Shared_Target <- read.csv ("Shared_Target_Matrix2.csv")

#assign a variable for row names
rnames <- Shared_Target[,1]

#Transform into a matrix
mat_data <- data.matrix(Shared_Target[,2:ncol(Shared_Target)])

#Assign column maes saved from before
rownames(mat_data) <- rnames

#Set color palette to go from red through yellow to green.  n indicates number of iterations, the higher this number the smoother the transition between colors.
my_palette <- colorRampPalette(c("red","yellow","green"))(n=299)

#create a png 
png("../heatmap.png",
    width = 7*300,
    height = 7*300,
    res = 300,
    pointsize = 8)

#Plotting the heatmap
heatmap.2(mat_data,
          main = "Shared Targets",
          density.info="none",
          trace="none",
          margins = c(12,9),
          col=my_palette,
          Rowv = FALSE,
          Colv = FALSE,
          dendrogram = "none",
          keysize = 0.5)

dev.off()
