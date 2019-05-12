# Farsite Characterization

# Input Parameters as a Genetic Individual

## How to generate random individuals:

~~~~
git clone https://github.com/edigley/farsite-characterization.
# wget https://github.com/edigley/farsite-characterization/archive/master.zip -O farsite-characterization.zip
# unzip farsite-characterization.zip
cd farsite-characterization
nOfIndividuals=1000
individuals=farsite_individuals_${nOfIndividuals}.txt
individualsBoxPlot=farsite_individuals_${nOfIndividuals}.png
scripts/generate_random_individuals.sh ${nOfIndividuals} ${individuals}
scripts/random_individuals_box_plot.sh ${individuals} ${individualsBoxPlot}
~~~~

## How to prepare real scenarios to run the predictions:

~~~~
wget https://github.com/edigley/fire-scenarios/archive/master.zip -O fire-scenarios-master.zip
unzip fire-scenarios-master.zip
mv fire-scenarios-master fire-scenarios

scenario=jonquera # arkadia | jonquera | ashley | hinckley | top_ten_case_{01,10}
playpen=playpen
scenarioFile=scenario_${scenario}.ini
outputFile=scenario_${scenario}.out
individuals=farsite_individuals_${nOfIndividuals}.txt
runtimeOutput=farsite_individuals_runtime_${scenario}.txt
runtimeHistogram=farsite_individuals_runtime_${scenario}_histogram.png
mkdir -p ${playpen}/input ${playpen}/output ${playpen}/trace
ln -s $(pwd)/fire-scenarios/${scenario}/landscape/  ${playpen}/
ln -s $(pwd)/fire-scenarios/${scenario}/perimetres/ ${playpen}/
ln -s $(pwd)/fire-scenarios/${scenario}/aux_files/  ${playpen}/
ln -s $(pwd)/fire-scenarios/${scenario}/bases/      ${playpen}/
ln -s $(pwd)/fire-scenarios/${scenario}/scripts/    ${playpen}/
cp    $(pwd)/fire-scenarios/${scenario}/scenario_template_for_histogram.ini ${playpen}/scenario_${scenario}.ini
sed -i "s/${scenario}_central_point/${scenario}_central_polygon_2/g" ${playpen}/scenario_${scenario}.ini
cp    $(pwd)/fire-scenarios/${scenario}/input/pob_0.txt ${playpen}/input/
~~~~

## Multivariate Adaptive Regression Spline (MARS) models:

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/edigley/spif/master?filepath=notebooks%2Fmars_models.ipynb)

