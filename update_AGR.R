library(dplyr)
library(readr)
library(org.Hs.eg.db)

# Download and read disease data
download.file("https://fms.alliancegenome.org/download/DISEASE-ALLIANCE_HUMAN.tsv.gz", "disease.tsv.gz")
disease <- read_tsv(gzfile("disease.tsv.gz"), comment = "#")

# Map DOID to entrez using org.Hs.eg.db
disease$entrez <- mapIds(org.Hs.eg.db, 
                         keys = disease$DBObjectSymbol, 
                         column = "ENTREZID", 
                         keytype = "SYMBOL", 
                         multiVals = "first")

# Filter, select, arrange, and distinct
doid2gene <- disease %>% 
  filter(!is.na(entrez)) %>% 
  select(DOID, DOtermName, entrez) %>% 
  arrange(DOID, entrez) %>%
  distinct()

# Write to file
write.table(doid2gene, "flatfile_doid2gene_agr.csv", sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)

