#!/bin/bash

inputDir=${1} 
outputFile=${2}

tmpFile=`mktemp`

(cat ${inputDir}/timed_output_0_*.txt | egrep -v "Command exited with non-zero status 124" | egrep -v "Command terminated by signal 9" | paste -d "" - - | sort -g -k 1 -k 2  > ${tmpFile})

echo "#generation individual p_1h p_10h p_100h p_herb p_1000h p_ws p_wd p_th p_hh                   p_adj1   p_adj2   p_adj3   p_adj4   p_adj5   p_adj6   p_adj7 p_adj8   p_adj9  p_adj10  p_adj11  p_adj12 runtime maxRSS outputs cpu csw exit error" > ${outputFile}
#echo "generation individual p0 p1  p2        p3        p4        p5        p6        p7        p8       p9      p10      p11      p12      p13      p14      p15   p16      p17      p18      p19      p20 runtime maxRSS outputs cpu csw exit error"  >> ${outputFile}
echo "generation individual p0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 runtime maxRSS outputs cpu csw exit error"  >> ${outputFile}

cat ${tmpFile} >> ${outputFile}

exit 0;

