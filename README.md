# Farsite Characterization

# Input Parameters as a Genetic Individual

## How to generate random individuals:

~~~~
git clone https://github.com/edigley/farsite-characterization.git
cd farsite-characterization
nOfIndividuals=1000
individuals=farsite_individuals_${nOfIndividuals}.txt
individualsBoxPlot=farsite_individuals_${nOfIndividuals}.png
scripts/generate_random_individuals.sh ${nOfIndividuals} ${individuals}
scripts/random_individuals_box_plot.sh ${individuals} ${individualsBoxPlot}
~~~~


## Multivariate Adaptive Regression Spline (MARS) models:

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/edigley/spif/master?filepath=notebooks%2Fmars_models.ipynb)

