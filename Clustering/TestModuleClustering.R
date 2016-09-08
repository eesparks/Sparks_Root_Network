#
# Test module finding algorithm in R
#

el<-read.table('data/TableS2_Interactions.csv',sep=',',as.is=T)
g1 <- graph.edgelist(as.matrix(el))
is.directed(g1)
# > is.directed(g1)
# [1] TRUE

# try some module finding
g1m.lp<-label.propagation.community(g1)

#bipartite graph module finding

el1<-el;el1[,1]<-paste(el[,1],'_b',sep='');el1[,2]<-paste(el[,2],'_e',sep='')
g2<-graph.edgelist(as.matrix(el1),directed = FALSE)
is.directed(g2)
g2m.lp<-label.propagation.community(g2)
g2m.wt<-walktrap.community(g2)
g2m.eb<-edge.betweenness.community(g2)

# get the gene to module assignment.
getcom<-function(test){
  # test is the membership assignment
  names(test)<-V(g2)$name
  test.mat<-cbind(test,names(test))
  getname<-function(x){strsplit(x,'_')[[1]][1]}
  allname<-unique(unlist(lapply(test.mat[,2],getname)))
  test.mat1<-cbind(test.mat,lapply(test.mat[,2],getname))
  outmat<-data.frame(name=allname,group="",stringsAsFactors = F)
  rownames(outmat)<-outmat[,1]
  for(each in allname)
  {
    k<-unname(unlist(test.mat1[test.mat1[,3]==each,1]))
    k<-sort(unique(k))
    print(k);print(length(k));print(paste(k,collapse=';'))
    if(length(k)==1){outmat[each,2]<-k}
    else{outmat[each,2]<-paste(k,collapse=';')}
  }
  return(outmat)
}

g2m.lp.mat<-getcom(g2m.lp$membership)
g2m.wt.mat<-getcom(g2m.wt$membership)
g2m.eb.mat<-getcom(g2m.eb$membership)

norder<-V(g1)$name
bipartie.mat<-data.frame(lp_module=g2m.lp.mat[norder,2],
                         wt_module=g2m.wt.mat[norder,2],
                         eb_module=g2m.eb.mat[norder,2])
rownames(bipartie.mat)<-norder


g1.outsim.iw<-similarity.invlogweighted(g1,mode='out')
g1.insim.iw<-similarity.invlogweighted(g1,mode='in')
# name the similarity
colnames(g1.outsim.iw)<-c(1:ncol(g1.outsim.iw))
rownames(g1.outsim.iw)<-c(1:ncol(g1.outsim.iw))

colnames(g1.insim.iw)<-c(1:ncol(g1.insim.iw))
rownames(g1.insim.iw)<-c(1:ncol(g1.insim.iw))


# work on indegree similarity clustering

# for nodes with extremem high similarity, 
# apply simple regularization to reduce their effects 
# on the final clustering results.
simmed<-quantile(g1.insim.iw,0.95)
g1.insim.iw[g1.insim.iw>simmed]=simmed
g1.indsim.iw<- (max(g1.insim.iw)-g1.insim.iw)/max(g1.insim.iw)
diag(g1.indsim.iw)<-0

fkmean.in<-fanny(g1.indsim.iw, k = 20, diss=TRUE, memb.exp=1.1)
table(fkmean.in$clustering)

# work on out degree similarity clustering
simmed<-quantile(g1.outsim.iw,0.95)
g1.outsim.iw[g1.outsim.iw>simmed]=simmed
g1.outdsim.iw<- (max(g1.outsim.iw)-g1.outsim.iw)/max(g1.outsim.iw)
diag(g1.outdsim.iw)<-0

fkmean.out<-fanny(g1.outdsim.iw, k = 20, diss=TRUE, memb.exp=1.1)
table(fkmean.out$clustering)

names(fkmean.in$clustering)<-V(g1)$name
names(fkmean.out$clustering)<-V(g1)$name

# make output table.
output<-cbind(fkmean.in$clustering,fkmean.out$clustering, 
              paste(fkmean.in$clustering,fkmean.out$clustering,sep='_'))
output<-data.frame(output,id=rownames(output))
output<-data.frame(output,in_degree=degree(g1,mode='in'),
                   out_degree=degree(g1,mode='out'),
                   lp.module=g1m.lp$membership)
output<-cbind(output,bipartie.mat[rownames(output),])


colnames(output)[1:3]<-c('in_cluster','out_cluster','cluster_id')
write.table(output,'results/NodeClustering.InOut.csv',sep=',')

# get some annotation, downloaded from TAIR.
#
annot<-read.table('data/gene_aliases_20140331.txt',
                  sep='\t',as.is=T,header=T)

annot<-annot[!duplicated(annot[,1]),]
annot<-annot[grep('AT[0-9]G[0-9]+',annot[,1]),]
rownames(annot)<-annot[,1]
colnames(annot)[1]<-'id'
output1<-merge(output, annot, by='id', all.x=T)
write.table(output1,'results/NodeClustering.InOut.Annotation.csv',
            sep=',',row.names=FALSE)

# > table(output1[,'cluster.id'])
# 
# 1_1 1_10 1_13  1_2  1_3  1_4  1_7  2_1 2_10 2_11 2_12 2_13 2_14 2_15 
# 2    1    1   23    1    2    1   57    4    6    2    6    5    6 
# 2_16 2_17  2_2  2_3  2_4  2_5  2_6  2_7  2_8  2_9  3_1 3_17  3_2  3_3 
# 3    1   55    5    5    7    6    4   14    9    3    1   10    1 
# 3_6  4_1 4_14  4_2  4_3  4_4  5_1  5_2  5_3  5_9 
# 1    2    1   11    1    1    1    5    1    2 


# get most similar nodes
sort(g1.outsim.iw[1,],decreasing = T)[1:5]

# get two examples: neighbor of vertex 1 and 4
x1<-V(g1)[nei(4)]$name
x2<-V(g1)[nei(1)]$name

length(intersect(V(g1)[nei(1)]$name,V(g1)[nei(4)]$name))

# check the weight
test<-intersect(V(g1)[nei(1)],V(g1)[nei(4)])
sum(V(g1)$weight[test])
# > sum(V(g1)$weight[test])
# [1] 3.910217


g1.sim.iw<-g1.outsim.iw+g1.insim.iw
# make some regularization to remove highly similar nodes
# 
simmed<-quantile(g1.sim.iw,0.95)
g1.sim.iw[g1.sim.iw>simmed]=simmed

g1.dsim.iw<- (max(g1.sim.iw)-g1.sim.iw)/max(g1.sim.iw)
diag(g1.dsim.iw)<-0
colnames(g1.dsim.iw)<-V(g1)$name
rownames(g1.dsim.iw)<-V(g1)$name

heatmap(g1.dsim.iw)

fkmean<-fanny(g1.dsim.iw, k = 20, diss=TRUE, memb.exp=1.1)

table(fkmean$clustering)

# > table(fkmean$clustering)
# 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 
# 96 15  8 11  8  4  6  6 27  4 10  8 10 10  6 15  4 12  6  1 

write.table(fkmean$clustering,'results/NodeClustering.csv',sep=',')

heatmap(g1.outsim.iw)
heatmap(g1.insim.iw)
