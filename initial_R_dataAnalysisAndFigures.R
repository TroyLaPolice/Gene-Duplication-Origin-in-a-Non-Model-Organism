# *****************************************************
#   Load Packages and Data
# *****************************************************

#Load Packages

library(plyr)
library(dplyr)
library(ggplot2)

#MAKE SURE TO SET WORKING DIRECTORY 

#Read in File

duplicated_genes <- read.table("duplicated_genes.csv", sep = ",", header = T, stringsAsFactors = F)

head(duplicated_genes)
colnames(duplicated_genes) <- c("Busco id", "Status", "Scaffold", "Start", "End", "Score", "Length")

# *****************************************************
#   Count the number of duplicates on each Scaffold
# *****************************************************

#This counts the number of duplicates on each Scaffold

scaffold_count <- count(duplicated_genes, Scaffold)

write.csv(scaffold_count, "scaffold_count.csv")

#This makes a density plot of the number of duplicates per scaffold

scaffold_count_dens <- ggplot(scaffold_count, aes(x=Scaffold, fill=' ')) + 
  geom_density(alpha=1) +
  ylab("Density") + xlab("Contig") +
  theme(axis.title = element_text(size=20), axis.text = element_text(size = 14),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        legend.title = element_text(size = 16), legend.text = element_text(size = 14))

#This prints the density plot

scaffold_count_dens
