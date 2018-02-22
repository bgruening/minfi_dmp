require("minfi", quietly = TRUE)

options(warn = -1)
options("download.file.method"="wget")

args <- commandArgs(trailingOnly = TRUE)

input1 = args[1]
input2 = args[2]
input3 = args[3]
input4 = args[4]
input5 = args[5]
output1 = args[6]

GRset <- get(load(input1))

pheno <- read.csv(input2)

type <- input3

qCutoff <- as.numeric(input4)

shrinkVar <- input5

beta <- getBeta(GRset)

pData  <- pData(GRset)

dmp <- dmpFinder(beta, pheno$Phenotype, type = type, qCutoff = qCutoff, shrinkVar = shrinkVar)

write.table(dmp, output1)
