require("minfi", quietly = TRUE)

options(warn = -1)
options("download.file.method"="wget")

args <- commandArgs(trailingOnly = TRUE)

input1 = args[1]
input2 = args[2]
input3 = args[3]
input4 = args[4]
input5 = args[5]
input6 = args[6]
output1 = args[7]

set <- get(load(input1))

genomeranges <- as.data.frame(ranges(set))

tab <- read.table(input6)

tab <- tab[,-(11:14),drop=FALSE] 

colnames(tab) <- c("seqname","source","feature","start","end","score","strand",	"frame","attributes", "names")

tab$source <- NULL

tab$frame <- NULL

tab$attributes <- NULL

beta <- getBeta(set)

pheno <- read.table(input2,skip=1)

type <- input3

qCutoff <- as.numeric(input4)

shrinkVar <- input5

dmp <- dmpFinder(beta, pheno$V2, type = type, qCutoff = qCutoff, shrinkVar = shrinkVar)

dmp$names <- rownames(dmp)

data <- merge(dmp, tab, by="names",sort = TRUE)

data <- data[c("seqname","start","end","names","score","strand", "feature","intercept", "f", "pval","qval")]

write.table(data, file= output1, quote = FALSE,col.names = FALSE, row.names = FALSE, sep = "\t")
