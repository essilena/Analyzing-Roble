# Load trees from IMG

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ggtree")
BiocManager::install("ggstance")
BiocManager::install("ggplot2")

library(ggtree)
library(ggplot2)
library(ggstance)
library(reshape2)
library(RColorBrewer)

#setwd("~/Microbiota")

Guanica <- read.newick("Radialtree13821_newick _Guanica/newick_with_counts.txt", comment.char = "#")
Cabo_Rojo <- read.newick("Radialtree14095_newick _CAbo_Rojo/newick_with_counts.txt", comment.char = "#")
Maricao <- read.newick("Radialtree14182_newick _Maricao/newick_with_counts.txt", comment.char = "#")
Guayama<- read.newick("Radialtree60484_newick_Guayama/newick_with_counts.txt", comment.char = "#")


tip_length_Guanica <-  length(Guanica$tip.label)
tip_length_Cabo_Rojo <-  length(Cabo_Rojo$tip.label)
tip_length_Maricao <-  length(Maricao$tip.label)
tip_length_Guayama <-  length(Guayama$tip.label)

Guanica$node.label

bar_data_Guanica <- log10(Guanica$edge.length[1:tip_length_Guanica])             
bar_data_Cabo_Rojo <- log10(Cabo_Rojo$edge.length[1:tip_length_Cabo_Rojo])
bar_data_Maricao <- log10(Maricao$edge.length[1:tip_length_Maricao])
bar_data_Guayama <- log10(Guayama$edge.length[1:tip_length_Guayama])



bar_data <- cbind(bar_data_Guanica, 
                  bar_data_Cabo_Rojo, 
                  bar_data_Maricao, 
                  bar_data_Guayama)
rownames(bar_data) <- Guanica$tip.label
colnames(bar_data) <- c("Gn", "CR", "M", "Gy")


p = ggtree(Guanica, branch.length="none")

gheatmap(p, bar_data) + ggtitle("Your Title Here")


bar_data_all <- cbind(bar_data, apply(bar_data, 1, sd))

p2 = ggtree(Guanica, layout = "circular", branch.length="none")
gheatmap(p2, bar_data)


ggplot(Cabo_Rojo, aes(bar_data_Cabo_Rojo,family, col=tip_length_Cabo_Rojo[1:5, ])) +
  geom_point() +
  stat_smooth() 

orden <- c(order(bar_data[ , 1], decreasing = TRUE)[1:5],79)

                                                  
orden2 <- order(bar_data[ ,2], decreasing = TRUE)[1:5]
df <- bar_data[orden,]

boxplot((df),
        xlim=c(0, ncol(df) + 3),
        col=brewer.pal(nrow(df), "Paired"),
        ylab="Log10(counts)",
        legend.text=rownames(df),
        args.legend=list(
          x=ncol(bar_data) + 5,
          y=max(colSums(df)),
          bty = "n"), main = "hola")
          

barplot((df),
        xlim=c(0, ncol(df) + 3),
        col=brewer.pal(nrow(df), "Paired"),
        ylab="Log10(counts)",
        legend.text=rownames(df),
        args.legend=list(
          x=ncol(bar_data) + 5,
          y=max(colSums(df)),
          bty = "n"), main = "Family of Bacterias Presents in Each Sample")

ggplot(aes(orden, df) +
  facet_wrap(bar_data[df]))
       