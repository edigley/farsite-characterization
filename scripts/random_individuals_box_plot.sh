#!/bin/bash

inputFile=${1} 
outputFile=${2}


rScript=~/git/spif/scripts/random_individuals_box_plot.R

R --slave --no-save --no-restore --no-environ --silent --args ${inputFile} ${outputFile} < ${rScript} 

exit 0;
