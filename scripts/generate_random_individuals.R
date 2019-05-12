#time R --slave --no-save --no-restore --no-environ --silent --args 1200 /tmp/farsite_individuals.txt < ~/git/spif/scripts/generate_random_individuals.R
library(msm)

cmd_args = commandArgs(TRUE)

nOfIndividuals <- strtoi(cmd_args[1])
outputFile <- cmd_args[2]

print(nOfIndividuals)
print(outputFile)

n=nOfIndividuals
individuals <- data.frame( 
    p0 =  runif(n, min=2, max=15),   #    1h
    p1 =  runif(n, min=2, max=15),   #   10h
    p2 =  runif(n, min=2, max=15),   #  100h
    p3 =  runif(n, min=20, max=70),  #  herb
    p4 =  runif(n, min=60, max=100), # 1000h
    p5 = rtnorm(n, mean=12.83, sd=6.25, 0, 150), # ws
    p6 =  runif(n, min=0, max=360),  # wd
    p7 =  runif(n, min=30, max=50),  # th
    p8 =  runif(n, min=30, max=100), # hh
    p9 =  runif(n, min=0, max=2),
    p10 = 0,
    p11 = 0,
    p12 = 0,
    p13 = 0,
    p14 = 0,
    p15 = 0,
    p16 = 0,
    p17 = 0,
    p18 = 0,
    p19 = 0,
    p20 = 0
)

# format the first 9 values (p0 to p8) as integer and the following (p9 to p20) as decimals
#formattedDataset=cbind(format(subset(individuals,select=paste("p", 0:8, sep="")), format="d", digits=0), format(subset(individuals,select=paste("p", 9:20, sep="")), format="d", digits=6))
integerValues <- format(subset(individuals, select=paste("p",  0:8, sep="")), format="d", digits=0, scientific = FALSE)
decimalValues <- format(subset(individuals, select=paste("p", 9:20, sep="")), format="d", digits=2, scientific = FALSE)
formattedDataset <- cbind(integerValues, decimalValues)

#write.table(format(individuals, format="d", digits=0, scientific = F), outputFile, col.names=F, row.names=F, quote=F, scientific = F)
write.table(formattedDataset, outputFile, col.names=F, row.names=F, quote=F)


# Max number of diferent individuals
# 5 * 5 * 6 * 66 * 100 * 360 * 21 * 71 = 531.392.400.000
# Max number of random individuals
# 5 * 5 * 6 * 66 *  40 *  60 * 21 * 71 =  35.426.160.000

# 4.865588 7.000158 12.372364 27.468633 86.184210 33.517023  29.422250 22.652297 79.956589 1.931928 0.990046 1.959003 1.962761 1.784674 310.8500 150300.0 0.000000 0.000000  0  19   0
# [---------------FMS-----------------]           [---------WND------] [--------WTR------] [-------------------ADJ--------------------] [---------------------------------] []  []  []
#      0        1        2        3          4         5          6         7          8        9       10       11       12      13        14      15        16      17    18  19  20
#     1h      10h      100h     herb       1000h      ws         wd        th         hh                                                 runtime  maxRSS    error   errorC   x oId gen
#      3        4        5        6          7         8          9        10         11       12       13       14       15      16


# Old values used for generated individuals in 2018
# p0 =  runif(n, min=2, max=6),    #    1h
# p1 =  runif(n, min=6, max=10),   #   10h
# p2 =  runif(n, min=10, max=15),  #  100h
# p3 =  runif(n, min=15, max=80),  #  herb
# p4 =  runif(n, min=80, max=100), # 1000h
# p5 = rtnorm(n, mean=12.83, sd=6.25, 0, 150),  # ws
# p6 = rtnorm(n, mean=56.60, sd=13.04, 0, 360), # wd
# p7 =  runif(n, min=30, max=50),  # th
# p8 =  runif(n, min=30, max=100), # hh
# p9 =  runif(n, min=0, max=2),
