library(ggplot2)
library("tidyr")

cmd_args = commandArgs(TRUE)

inputFile <- cmd_args[1]
outputFile <- cmd_args[2]

ds <- read.table(inputFile, header=T)
ds <- subset(ds, runtime < 3600, select=c("individual", "runtime"));

# if is there a third argument then use it as xLim. Otherwise, uses the greatest runTime in the dataset
xLim <- ifelse(!is.na(cmd_args[3]), strtoi(cmd_args[3]), max(ds$runtime)+1)

png(outputFile, width=16, height=9, units='in', res=300)

ggplot(data=ds, aes(ds$runtime)) +
    geom_histogram( breaks=seq(0, xLim, by=30), col="red", aes(fill=..count..)) +
    scale_fill_gradient("Count", low = "green", high = "red", labels="") +
    #xlim(0, 40) +
    #ylim(0, 300) + 
    #xlim(0, 60) +
    #ylim(0, 3000) + 
    xlim(0, xLim) +
    theme(legend.position="none")

dev.off()
