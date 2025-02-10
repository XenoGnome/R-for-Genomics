if (!requireNamespace("devtools", quietly=TRUE))
  install.packages("devtools")
devtools::install_github("YuLab-SMU/ggmsa")

available_msa()
#> files currently available:
#> .fasta
#> XStringSet objects from 'Biostrings' package:
#> DNAStringSet RNAStringSet AAStringSet BStringSet DNAMultipleAlignment RNAMultipleAlignment AAMultipleAlignment
#> bin objects:
#> DNAbin AAbin

protein_sequences <- system.file("extdata", "sample.fasta", package = "ggmsa")
miRNA_sequences <- system.file("extdata", "seedSample.fa", package = "ggmsa")
nt_sequences <- system.file("extdata", "LeaderRepeat_All.fa", package = "ggmsa")






library(ggmsa)
protein_sequences <- system.file("extdata", "sample.fasta", package = "ggmsa")
ggmsa(protein_sequences, start = 221, end = 280, char_width = 0.5, seq_name = T) + geom_seqlogo() + geom_msaBar()

head(protein_sequences)
