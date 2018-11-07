## TP5


# Download & load required packages ####

#source("http://bioconductor.org/biocLite.R")
#biocLite()
#biocLite("NOISeq")
#biocLite("RColorBrewer")
library(NOISeq)
library(RColorBrewer)


# Import STAR/StringTie raw counts ####

setwd("/home/diego/Dropbox/Projects/GenEvoPop/TP5/DE")

mycounts <- as.matrix(read.csv("/home/estudiante/TP5/StringTie/gene_count_matrix.csv",
                              header= TRUE, sep= ",", row.names= "gene_id"))

head(mycounts)

myfactors <- data.frame(condition= c("disomic", "disomic", "disomic",
                                     "trisomic", "trisomic", "trisomic"))

mydata <- readData(data= mycounts, factors= myfactors) # generate NOISeq dataset

myTMM <- tmm(assayData(mydata)$exprs, long= 1000, lc= 0, k= 0.5) # save a normalized count table


## DE Analysis: Disomic vs Trisomic ####

disomic.VS.trisomic <- noiseqbio(mydata, k= 0.5, norm= "tmm",
                                 factor= "condition", conditions= c("disomic", "trisomic"),
                                 plot= FALSE, filter= 1)

head(degenes(disomic.VS.trisomic, q= 0.8, M= NULL)) # show all DE genes for q= 0.8, for up/down-regultaed M= "up" / M= "down" 

DE.plot(disomic.VS.trisomic, q= 0.8, graphic= "expr", log.scale= TRUE) # expression values plot for the features


## DE heatmap ####

DE_subset <- subset(myTMM,
                    row.names(myTMM) %in% rownames(degenes(disomic.VS.trisomic, q= 0.8, M= NULL)))

hmcol <- colorRampPalette(brewer.pal(9, "YlOrRd"))(423) # colour selection, see "?brewer.pal" for more color schemes

heatmap(DE_subset, Colv= NA, col= hmcol, cexRow= 0.5, cexCol= 1) # use RStudio built-in tool for saving the heatmap


# Export results table ####

write.table(rownames(degenes(disomic.VS.trisomic, q= 0.8, M= NULL)),
            "disomic.VS.trisomic.list",
            quote= FALSE, sep= "\t", row.names= FALSE, col.names= FALSE)



