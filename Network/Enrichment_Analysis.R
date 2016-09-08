#Generate a Random Graph for Analysis of Binding Interactions

#Exerpt from Fuxman-Bass et al., Molecular Cell 2013:
#Edge pairs were chosen at random from the network and interaction partners were swapped.
#Switching allowed only when neither of the edges was already present.
#Number of edge switches was equal to 10% of the possible number of pairs 
#0.1X[number of edges^2 - number of edges]
#I have 488 interactions that could have been identified based on the presence of a binding site.
#This means I have to have 23,765.6 edge switches, but this doesn't make sense... I only have 110 TFs and 77 targets.  Shouldn't it just be 0.1X(110*77)?  Then I would do 84.7 edge switches.
#Actually, Martinez et al., 2008 is suggesting that you do between 100 and 200 times the number of edges, which is way more than 23K.
#Random networks were at least 60% different from the original.
#20,000 random networks

setwd("~/Desktop/Papers in Progress//Network_Paper//Resubmission//  Second_resubmission/Randomized_Data/")

#First read in the data
dat <- read.csv("Motif_Enrichment.csv")
head (dat)

#First figure out how to randomly switch an interaction
library("dplyr")
#This function allows me to sample random rows from within the data
#Let's make this random duo of samples into a new object
rand <- sample_n(dat, 2)
rand
#Need to figure out how to swap then replace the data...
#First use a 3rd variable to assign Row1,Column2
b <- rand[1,2]
#Then switch the value from Row2,Column2 into [1,2]
rand[1,2] = rand[2,2]
#Reassign the value from [1,2], stored in 'b', into [2,2]
rand[2,2] = b
rand

#Now add this back into the original dataset

dat[which (dat$number == rand [1,3]),] = rand[1,]
dat[which (dat$number == rand [2,3]),] = rand[2,]


#put all of this into a for-loop
setwd("~/Desktop/Randomized_Data/")
for (ii in 1:19994){
  for (i in 1:23766) {
    rand <- sample_n(dat, 2)
    b <- rand[1,2]
    rand[1,2] = rand[2,2]
    rand[2,2] = b
    dat[which (dat$number == rand [1,3]),] = rand[1,]
    dat[which (dat$number == rand [2,3]),] = rand[2,]
    fn <- paste(ii, "Random.csv", sep="")
    write.table(dat, file=fn, row.names=FALSE)
  }
}




#Randomize data for only the directly determined motifs
#229 Interactions from Direct Motifs - So 5300 switches.
dat2 <- read.csv("Motif_Enrichment_DIrect.csv")
head (dat2)


for (ii in 1:60){
  for (i in 1:5300) {
    rand <- sample_n(dat2, 2)
    b <- rand[1,2]
    rand[1,2] = rand[2,2]
    rand[2,2] = b
    dat2[which (dat2$number == rand [1,3]),] = rand[1,]
    dat2[which (dat2$number == rand [2,3]),] = rand[2,]
    fn <- paste(ii, "Random_Direct.csv", sep="")
    write.table(dat2, file=fn, row.names=FALSE)
  }
}

