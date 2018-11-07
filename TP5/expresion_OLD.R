## TP5


# Download and load required packages ####
#source("http://bioconductor.org/biocLite.R")
#biocLite()
#biocLite("NOISeq")
library(NOISeq)

setwd("/home/diego/Dropbox/Projects/GenEvoPop/TP5/DE")


# Import STAR/StringTie counts ####
mycounts = as.matrix(read.csv("/home/diego/Dropbox/Projects/GenEvoPop/TP5/StringTie/gene_count_matrix.csv",
                                 header = TRUE, sep=",", row.names="gene_id"))
head(mycounts) #columns ordered by tratments first, species second

myfactors = data.frame(condition = c("disomic", "disomic", "disomic", "trisomic", "trisomic", "trisomic"))

mydata <- readData(data = mycounts, factors = myfactors)
myTMM = tmm(assayData(mydata)$exprs, long = 1000, lc = 0, k=0.5)


## Disomic vs Trisomic ####
disomic.VS.trisomic = noiseqbio(mydata, k = 0.5, norm = "tmm",
                            factor = "condition", conditions = c("disomic", "trisomic"),
                            plot = FALSE, filter = 1)

head(degenes(disomic.VS.trisomic, q = 0.8, M = NULL))
DE.plot(disomic.VS.trisomic, q = 0.8, graphic = "expr", log.scale = TRUE)

rownames(degenes(disomic.VS.trisomic, q = 0.8, M = NULL))

## DE heatmap ####
DE_subset <- subset(myTMM, row.names(myTMM) %in% rownames(degenes(disomic.VS.trisomic, q = 0.8, M = NULL)))

library(RColorBrewer)
hmcol <- colorRampPalette(brewer.pal(9, "YlOrRd"))(423)
heatmap(DE_subset, Colv=NA, col=hmcol, cexRow=0.5, cexCol=1)


# Export results table ####

write.table(rownames(degenes(disomic.VS.trisomic, q = 0.8, M = NULL)),
            "disomic.VS.trisomic.list",
            quote = FALSE, sep="\t", row.names = FALSE, col.names = FALSE)





library(RColorBrewer)
hmcol <- colorRampPalette(brewer.pal(9, "YlOrRd"))(288) # See "?brewer.pal" for more color schemes
H<-function(d) hclust(d, method="ward.D2")
heatmap(myTMM, Colv=NA, col=hmcol, cexRow=0.5, cexCol=1, hclustfun = H)




# Vamos a utilizar el set de datos reducido de la siguiente publicación (muy conocida)
# que suele usarse para probar paquetes relacionados con RNA-Seq:
# J.C. Marioni, C.E. Mason, S.M. Mane, M. Stephens, and Y. Gilad.
# RNA-seq: an assessment of technical reproducibility and comparison with gene expression arrays.
# Genome Research, 18: 1509 - 517, 2008.

data(Marioni)

# En el experimento de Marioni, se secuenciaron muestras de hígado y riñon de un humano (masculino) dentro
# de las 6 horas post mortem.
# Hay 5 réplicas (técnicas) por téjido, y se utilizaron 2 flowcells de Illumina para secuenciar.
# El set de datos es reducido porque solo vamos a usar los cromosomas I a V.



# preparar la información:

myfactors2 = data.frame(
  Tissue = c("Kidney", "Liver", "Kidney", "Liver", "Liver", "Kidney", "Liver",
             "Kidney", "Liver", "Kidney"),
  Run = c("R1", "R1", "R1", "R1", "R1", "R1", "R1",
          "R2", "R2", "R2"),
  TissueRun = c("Kidney_R1", "Liver_R1", "Kidney_R1", "Liver_R1", "Liver_R1", "Kidney_R1", "Liver_R1",
                "Kidney_R2", "Liver_R2", "Kidney_R2"))

mydata <- readData(data = mycounts, length = mylength, gc = mygc, biotype = mybiotypes, chromosome = mychroms, factors = myfactors)


# calcular expresión diferencial con determinados parámetros:

mynoiseq = noiseq(mydata, k = 0.5, norm = "rpkm", factor = "Tissue", lc = 1, replicates = "technical")


# ¿qué cantidad de genes tienen expresión diferencial en la comparación "tejido"?
# Explorar distintos valores de significación

head(rownames(degenes(mynoiseq, q = 0.8, M = NULL)))

head(rownames(degenes(mynoiseq, q = 0.9, M = NULL)))

head(rownames(degenes(mynoiseq, q = 0.95, M = NULL)))

head(rownames(degenes(mynoiseq, q = 0.99, M = NULL)))

# visualizaciones

DE.plot(mynoiseq, q = 0.8, graphic = "expr", log.scale = TRUE)
DE.plot(mynoiseq, q = 0.99, graphic = "expr", log.scale = TRUE, col.sel = "blue")


DE_q99 <- rownames(degenes(mynoiseq, q = 0.99, M = NULL))
DE_q99_counts <- subset(mycounts, rownames(mycounts) %in% DE_q99)
DE_q99_counts.matrix <- data.matrix(DE_q99_counts)

library(RColorBrewer)
hmcol <- colorRampPalette(brewer.pal(9, "YlOrRd"))(480) # See "?brewer.pal" for more color schemes

heatmap(DE_q99_counts.matrix, col=hmcol)


# explorar otro tipo de normalización y otras comparaciones

mynoiseq.tmm = noiseq(mydata, k = 0.5, norm = "tmm", factor = "TissueRun", conditions = c("Kidney_1", "Liver_1"), lc = 0, replicates = "technical")



