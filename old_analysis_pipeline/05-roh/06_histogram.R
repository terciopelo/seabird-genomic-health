#Read the document containing ROH lengths
roh <- read.delim("roh_lengths.txt")

#Generate a summary
summary(roh$Lengths)

#Plot a histogram
hist(roh$Lengths,breaks=500,xlim=c(0,500),
     ylab="Frequency",xlab="Length (KB)",
     main="ROH ditribution by length")
