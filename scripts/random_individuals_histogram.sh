#!/bin/bash

inputFile=${1} 
outputFile=${2}
xLim=${3}

rScript=scripts/random_individuals_histogram.R

R --slave --no-save --no-restore --no-environ --silent --args ${inputFile} ${outputFile} ${xLim} < ${rScript} 

exit 0;
