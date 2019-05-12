# Farsite 

The Fire Area Simulator, FARSITE (Finney 1998), is a fire growth model originally developed for planning and management of prescribed natural fires. 
Its use has since expanded to suppression efforts for wildfires, evaluating fuel treatments (Finney 2001, Stephens 1998, Stratton 2004, van Wagtendonk 1996), and reconstructing past fires (Duncan and Schmalzer 2004). 
Developed in the Western United States, the model has been validated on fires in Yosemite, Sequoia, and Glacier National Parks (Finney 1993, Finney and Ryan 1995). 
While the use of this software is growing in the Southwestern United States, the Midwestern United States, and Florida, as well as in other countries, it has not received much attention in the Eastern United States.

FARSITE requires a minimum of five raster layers to generate simulations. 
These layers are: 
- elevation, 
- aspect, 
- slope, 
- fuel model, and 
- canopy cover. 

The landscape data (elevation, slope, and aspect) are used for making adiabatic adjustments for temperature and humidity as well as computing slope effects on fire spread and solar radiation effects on fuel moisture. 
We created these files from a 30-m digital elevation model (DEM) for the Cliffield Mountain quadrangle.

Simulation vs. Actual Burn

## Input Parameters as a Genetic Individual

## How to generate random individuals:

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/edigley/farsite-characterization/master?filepath=binder%2Frandom_individuals.ipynb)

~~~~
wget https://github.com/edigley/farsite-characterization/archive/master.zip -O farsite-characterization-master.zip
unzip farsite-characterization-master.zip
mv farsite-characterization-master farsite-characterization
FARSITE_CHARACTERIZATION_DIR=$(pwd)/farsite-characterization/
~~~~

~~~~
cd farsite-characterization
nOfIndividuals=1000
individuals=farsite_individuals_${nOfIndividuals}.txt
individualsBoxPlot=farsite_individuals_${nOfIndividuals}.png
scripts/generate_random_individuals.sh ${nOfIndividuals} ${individuals}
scripts/random_individuals_box_plot.sh ${individuals} ${individualsBoxPlot}
~~~~

## How to prepare real wildfire scenarios to run the predictions:

~~~~
wget https://github.com/edigley/fire-scenarios/archive/master.zip -O fire-scenarios-master.zip
unzip fire-scenarios-master.zip
mv fire-scenarios-master fire-scenarios
FIRE_SCENARIOS_DIR=$(pwd)/fire-scenarios/
~~~~

~~~~
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
sed -i "s#<ignition_file>#${scenario}_central_polygon_2.shp#g"              ${playpen}/scenario_${scenario}.ini
sed -i "s#<farsite_path>#${FARSITE_DIR}#g"                                  ${playpen}/scenario_${scenario}.ini
cp    $(pwd)/fire-scenarios/${scenario}/input/pob_0.txt ${playpen}/input/
cp    $(pwd)/farsite-characterization/${individuals}    ${playpen}/
~~~~

## How to run a single individual:

~~~~
wget https://github.com/edigley/farsite/archive/master.zip -O farsite-master.zip
unzip farsite-master.zip
mv farsite-master farsite
FARSITE_DIR=$(pwd)/farsite/
~~~~

~~~~
wget https://github.com/edigley/spif/archive/master.zip -O spif-master.zip
unzip spif-master.zip
mv spif-master spif
SPIF_DIR=$(pwd)/spif/
~~~~

~~~~
# farsite individual parameters specified directly: gen ind 1h 10h 100h herb 1000h  ws  wd   th  hh  adj
${SPIF_DIR}/fireSimulator86400 ${scenarioFile} run    0   0  7   3    6   54    87  17  267  43  64  1.7
~~~~

~~~~
# to run only the first individual from the generated file
${SPIF_DIR}/fireSimulator86400 ${scenarioFile} ${individuals} run 0
~~~~

## How to run a group of individuals:

~~~~
cd ${playpen}
for i in `seq 0 999`; do time ${SPIF_DIR}/fireSimulator86400 ${scenarioFile} ${individuals} run ${i} >> ${outputFile} 2>&1; done
${FARSITE_CHARACTERIZATION_DIR}/scripts/concatenate_all_individuals_results.sh . ${runtimeOutput}
${FARSITE_CHARACTERIZATION_DIR}/scripts/random_individuals_histogram.sh ${runtimeOutput} ${runtimeHistogram}
tempFile=`mktemp`
${FARSITE_CHARACTERIZATION_DIR}/scripts/generate_summary_for_scenario_specification.sh ${scenarioFile} ${tempFile}
tail -n +2 ${runtimeOutput} >> ${tempFile}
sed -i 's/.000000//g' ${tempFile}
cp ${tempFile} ${runtimeOutput}
wc -l ${runtimeOutput}
mkdir timed_outputs && mv timed_output_0_* timed_outputs/
~~~~

## Multivariate Adaptive Regression Spline (MARS) models:

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/edigley/spif/master?filepath=notebooks%2Fmars_models.ipynb)

