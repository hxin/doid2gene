library(dplyr)
library(readr)
library(org.Hs.eg.db)

agr_annotation <- "https://fms.alliancegenome.org/download/DISEASE-ALLIANCE_HUMAN.tsv.gz"

# Download and read disease data
message("Downloading disease data from...")
download.file(agr_annotation, "disease.tsv.gz")
message("Reading disease data...")
disease <- read_tsv(gzfile("disease.tsv.gz"), comment = "#")

# Map DOID to entrez using org.Hs.eg.db
message("Mapping gene symbol to entrez using org.Hs.eg.db...")
disease$entrez <- mapIds(org.Hs.eg.db, 
                         keys = disease$DBObjectSymbol, 
                         column = "ENTREZID", 
                         keytype = "SYMBOL", 
                         multiVals = "first")

# Filter, select, arrange, and distinct
message("Formating output...")
doid2gene <- disease %>% 
  filter(!is.na(entrez)) %>%
  dplyr::select(DOID, DOtermName, entrez) %>%
  arrange(DOID, entrez) %>%
  distinct()

# Write to file
write.table(doid2gene, "flatfile_doid2gene_agr.csv", sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)
message("annotation file generated: ", file.path( getwd(), "flatfile_doid2gene_agr.csv"))

