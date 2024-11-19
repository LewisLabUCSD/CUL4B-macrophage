# merge RNA-seq counts for samples and generate metadata table

stringsAsFactors=FALSE
library(stringr)

# path to directory containing individual sample count files (*.fastq.sort.count.txt)
path <- "../../countFiles"

##Read files names
files <- list.files(path)
files <- grep("count.txt",files,value = T)

##Manipulate names
splitNames <- str_split_fixed(files, "_",6)
trimNames <- paste(splitNames[,3], splitNames[,4], splitNames[,5], sep="_")
sampleTable <- data.frame(tReplicate = trimNames, #distinguishes technical replicates
                          fileName = files,
                          bReplicate = splitNames[,3]) #distinguishes biological replictes
##Add columns to sample table 
timePoint <- rep(c(6,24), each=16)
condition <- rep(c("Uninfected", "MRSA", "PAO1", "PAO1ΔtoxA"), each=4, times=2)
sampleTable <- cbind(sampleTable, cbind(timePoint, condition))

##Read in count files 
cov <- list()
for (i in 1:nrow(sampleTable)) {
  filepath <- file.path(path, files[i])
  sampleName <- sampleTable$tReplicate[i]
  cov[[sampleName]] <- read.table(filepath,sep = "\t", header=F, stringsAsFactors=FALSE)
  colnames(cov[[sampleName]]) <- c("ENSEMBL_GeneID", sampleName)
}

##Construct one data frame from list of data.frames using reduce function
df <-Reduce(function(x,y) merge(x = x, y = y, by ="ENSEMBL_GeneID"), cov)

##Save count Matrix and sampleTable information
write.csv(df,file="../data/DEG_RNA/countMatrix.csv",row.names = FALSE) #countMatrix as csv
saveRDS(df[-c(1:5),], "../data/DEG_RNA/countMatrix.rds")


# remove file names from sampleTable before saving
sampleTable <- sampleTable[c("tReplicate", "bReplicate", "condition", "timePoint")]
saveRDS(sampleTable, "../data/DEG_RNA/sampleTable.rds")
#write.table(df,paste(path, myoutname,".txt",sep=""), sep="\t", quote= F, row.names = F)


