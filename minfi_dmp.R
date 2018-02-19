require("minfi", quietly = TRUE)

options(warn = -1)
options("download.file.method"="wget")

args <- commandArgs(trailingOnly = TRUE)

input1 = args[1]
input2 = args[2]
output = args[3]

GRset <- get(load(input1))

pheno <- read.csv(input2)

beta <- getBeta(GRset)

pData  <- pData(GRset)

dmp <- dmpFinder(beta, pheno$Phenotype, type = "continuous")

write.table(dmp, output)
