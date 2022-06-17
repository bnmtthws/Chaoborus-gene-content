## 20220617
## produce plots of BLASTp results from candidate Drosophila proteins 
## using the trimmed Chaoborous transcriptome as a database

## load libraries
library(ggplot2)
library(readxl)
library(cowplot)

## load BLAST summary results
geneContent <- read_xlsx('targetedGene_query_trimmed.xlsx')  

## plot identity of BLAST hit (x-axis) and length of hit divided by length of query (y-axis)
id_by_length <- ggplot(data=geneContent,aes(x=ident,y=length/queryLength)) + geom_point(aes(colour=class)) + 
  xlab('Percent identity') + ylab('BLAST hit length / query length') 

## generate histograms of percent identity and of length of hit divided by length of query
id_hist <- ggplot(data=geneContent,aes(x=ident)) + geom_histogram(binwidth=5) + xlab('Percent identity of BLAST hit')
length_hist <- ggplot(data=geneContent,aes(x=length/queryLength)) + geom_histogram(binwidth=.05) + xlab('BLAST hit length / query length')

## generate multi-panel plot
id_grid <- plot_grid(id_hist,length_hist)
all_grid <- plot_grid(id_grid,id_by_length,ncol=1)
