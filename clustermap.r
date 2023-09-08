#Package installation
install.packages("heatmap3")

library("heatmap3")

#Data import
tax <- read.csv("taxonomy.csv", header = TRUE, na.strings = "NA")\
data = tax[,2:ncol(tax)]
rownames(clus) <- tax$Type

#Cluster map
heatmap3(clus, col=greenred(100), scale="none", cexRow=0.8,cexCol = 0.8, margins = c(12,6), main="")

