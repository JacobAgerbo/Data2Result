#!/usr/bin/env Rscript
#### LULU PIPELINE ####
#library(devtools)
#install_github("tobiasgf/lulu")  

library(lulu)
## Import data
otutab <- read.csv("ASVs_counts.tsv",sep='\t',header=TRUE,as.is=TRUE, row.names = 1)
matchlist <- read.table("match_list.txt", header=FALSE,as.is=TRUE, stringsAsFactors=FALSE)
tax <- read.csv("ASVs_taxonomy.tsv",sep='\t',header=TRUE,as.is=TRUE, row.names = 1)



curated_result <- lulu(otutab, matchlist)



### Compared output
curated_result$curated_count

percentage.removed <- round((as.numeric(length(rownames(otutab)))-curated_result$curated_count)/as.numeric(length(rownames(otutab)))*100,digits = 2)



Curated <- curated_result$curated_table

tax_curated <- tax[match(rownames(Curated),rownames(tax)),]


write.table(tax_curated, "Curated_Tax.csv", sep = ',', row.names = TRUE)                            
write.table(curated_result$curated_table, "Curated_Table.txt", sep = ',', row.names = TRUE)                            
                            
