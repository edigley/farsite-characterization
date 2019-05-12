#!/bin/bash

nOfIndividuals=${1} 
outputFile=${2}

rScript=~/git/spif/scripts/generate_random_individuals.R

R --slave --no-save --no-restore --no-environ --silent --args ${nOfIndividuals} ${outputFile} < ${rScript} 

sed -i "1s/^/${nOfIndividuals} 0 18\n/" ${outputFile} 

exit 0;
