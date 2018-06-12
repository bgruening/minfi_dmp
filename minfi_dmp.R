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

set <- get(load(input1))

beta <- getBeta(set)

pheno <- read.table(input2,skip=1)

type <- input3

qCutoff <- as.numeric(input4)

shrinkVar <- input5

dmp <- dmpFinder(beta, pheno$V2, type = type, qCutoff = qCutoff, shrinkVar = shrinkVar)

export.bed(dmp,output1)
