#Package installation
install.packages("ggplot2")
install.packages("vegan")

#パッケージ起動
library("ggplot2")	
library("vegan")

#Data import
nmds <- read.csv("nmds.csv", header = TRUE, na.strings = "NA")
data = nmds[,2:ncol(nmds)]

#Rarefied read
raremax <- min(rowSums(data))
rared <- rrarefy(data, raremax)


#nMDS analysis
mat_rared<-as.matrix(rared)

NMDS <- metaMDS(comm=mat_rared, distance="horn")
data.scores = as.data.frame(scores(NMDS)$sites)

data.scores$Type = nmds$Type


#making figure
ggplot(data.scores, aes(x = NMDS1, y = NMDS2)) + geom_point(size = 6, aes(colour = Type))+ scale_color_brewer(palette = "Set1")+ theme(axis.text.y = element_text(colour = "black", size = 18, face = "bold"), axis.text.x = element_text(colour = "black", face = "bold", size = 18), legend.text = element_text(size = 18, face ="bold", colour ="black"), legend.position = "right", axis.title.y = element_text(face = "bold", size = 18), axis.title.x = element_text(face = "bold", size = 18, colour = "black"), legend.title = element_text(size = 18, colour = "black", face = "bold"), panel.background = element_blank(), panel.border = element_rect(colour = "black", fill = NA, size = 1.2), legend.key=element_blank()) +stat_ellipse(aes(fill = Type, colour = Type), geom = "polygon", alpha = 0.2)+ labs(x = "NMDS1", colour = "Type", y = "NMDS2")

#Analysis of similarity test
ano = anosim(mat_rared, nmds$Type, distance = "horn", permutations = 9999)

