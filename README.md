# doid2gene

# R Script for Mapping DOID to Entrez Gene IDs
Overview
This R script downloads HDO annotation from [alliancegenome](https://www.alliancegenome.org/), 
maps gene symbol to entrez Gene IDs using the org.Hs.eg.db package, and writes the mapped data to a CSV file(actually tab separated).

require R library
```R
library(dplyr)
library(readr)
library(org.Hs.eg.db)
```

example code
```R
Rscript update_AGR.R
```