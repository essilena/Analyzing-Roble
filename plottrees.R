# Load trees from IMG

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree")
BiocManager::install("ggstance")
BiocManager::install("ggplot2")

library(ggtree)
library(ggplot2)
library(ggstance)

setwd("~/Microbiota")

Guanica <- read.newick("Radialtree13821_newick _Guanica/newick_with_counts.txt", comment.char = "#")
Cabo_Rojo <- read.newick("Radialtree14095_newick _CAbo_Rojo/newick_with_counts.txt", comment.char = "#")
Maricao <- read.newick("Radialtree14182_newick _Maricao/newick_with_counts.txt", comment.char = "#")
Guayama<- read.newick("Radialtree60484_newick_Guayama/newick_with_counts.txt", comment.char = "#")



tip_length_Guanica <-  length(Guanica$tip.label)
tip_length_Cabo_Rojo <-  length(Cabo_Rojo$tip.label)
tip_length_Maricao <-  length(Maricao$tip.label)
tip_length_Guayama <-  length(Guayama$tip.label)


bar_data_Guanica <- log(Guanica$edge.length[1:tip_length_Guanica])             
bar_data_Cabo_Rojo <- log(Cabo_Rojo$edge.length[1:tip_length_Cabo_Rojo])
bar_data_Maricao <- log(Maricao$edge.length[1:tip_length_Maricao])
bar_data_Guayama <- log(Guayama$edge.length[1:tip_length_Guayama])



bar_data <- cbind(log(Guanica$edge.length[1:tip_length_Guanica]), log(Cabo_Rojo$edge.length[1:tip_length_Cabo_Rojo]), bar_data_Maricao <- log(Maricao$edge.length[1:tip_length_Maricao]), bar_data_Guayama <- log(Guayama$edge.length[1:tip_length_Guayama]))
rownames(bar_data) <- Guanica$tip.label
colnames(bar_data) <- c("Guanica", "Cabo_Rojo", "Maricao", "Guayama")


p = ggtree(Guanica, branch.length="none")

gheatmap(p, bar_data)


bar_data_all <- cbind(bar_data, apply(bar_data, 1, sd))

