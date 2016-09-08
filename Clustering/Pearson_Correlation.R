#Code used to perform Pearson Correlation fo cluster analysis
#Erin Sparks
#May 2015

data <- read.csv("Clusters_Summary.csv")

head(data)

cor (data$Cluster, data$Kmeans_38_AtGen, use = "everything", method = c("pearson"))

cor (data$Cluster, data$Kmeans_38_RootCellTypes, use = "everything", method = c("pearson"))
