library(ggplot2)
library("tidyr")

cmd_args = commandArgs(TRUE)

inputFile <- cmd_args[1]
outputFile <- cmd_args[2]

#header <- c("p0", "p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10", "p11", "p12", "p13", "p14", "p15", "p16", "p17", "p18", "p19", "p20") # "runtime", "maxRSS", "outputs", "cpu", "csw", "exit", "error")
header <- paste("p",0:20,sep="")
#dat=read.csv("contacts.csv", skip=16, nrows=5, header=TRUE)
individuals <- read.table(inputFile, skip=1, col.names=header )
individuals$individual <- 1:nrow(individuals)
individuals <- subset(individuals, select=c("individual", "p0", "p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8"))
colnames(individuals) <- c("individual", "1h", "10h", "100h", "herb", "1000h", "ws", "wd", "th", "hh")
params <- c("1h", "10h", "100h", "herb", "1000h", "ws", "wd", "th", "hh")
#individuals <- gather(individuals, param, value, p0:p8, factor_key=TRUE)
individuals <- gather(individuals, param, value, params, factor_key=TRUE)
fmsColor <- "red";
windColor <- "green";
weatherColor <- "#e69f00"

png(outputFile, width=16, height=9, units='in', res=300)

bp <- ggplot(individuals, aes(x=param, y=value, fill=param)) + geom_boxplot()
bp + scale_fill_manual(values=c(fmsColor, fmsColor, fmsColor, fmsColor, "grey", windColor, windColor, weatherColor, weatherColor))

dev.off()


