#K-means Clustering to Look at Different Expression Analyses. 
#Erin Sparks 
#May, 2015

#Cluster the subset of root cell type-specific RNAseq data (Li & Yamada, 2015). Into 38 groups based on in/out-clustering.
clusters1 <- read.csv ("Microarray_CellTypes.csv")

d <- dist(as.matrix(clusters1))

#Kmeans Clustering
km <- kmeans(d,38)
x<- km$cluster

head(x)

write.csv(x, "K-means_38_CellTypes.csv")


#Cluster the subset of AtGenExpress data.  Into 38 groups based on in/out-clustering.
clusters2 <- read.csv ("AtGenExpress.csv")

d <- dist(as.matrix(clusters2))

#Kmeans Clustering
km <- kmeans(d,38)
x<- km$cluster

head(x)

write.csv(x, "K-means_38_AtGenExp.csv")



#Cluster the subset of AtGenExpress data.  Into 38 groups based on in/out-clustering.
clusters3 <- read.csv ("AtGENexpress_Avg_All.csv")

d <- dist(as.matrix(clusters3))

#Kmeans Clustering
km <- kmeans(d,38)
x<- km$cluster

head(x)


write.csv(x, "AtGenExp.csv")

