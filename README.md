# singerVoiceTypePrediction
A simple code for clssify singer's voice type, via HMM,GMM. 
Various dimension reduction methods can be also used before training.

### Tested Environment (not required)
Matlab 7.11 R2011b, on Win7 32 bit

### Required Toolboxes
1. utitlity toolbox http://mirlab.org/jang/matlab/toolbox/utility
2. sap toolbox http://mirlab.org/jang/matlab/toolbox/sap
3. machinLearning toolbox http://mirlab.org/jang/matlab/toolbox/machineLearning
4. voicebox toolbox http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html
5. pmtk toolbox https://github.com/probml/pmtk3

### Example dataset
* the singing phonation mode dataset http://www.doc.gold.ac.uk/~mas02pp/phonation_modes/

### Setup: 
1. change the ```toolboxPath.root``` in ```vtpInit.m``` to the root path of your downloaded toolboxes. 
2. change the path settings:```datasetDir```,```featurePath``` in ```featureExtractOptSet.m```, and ```usedDatasetFeaPath``` in ```trainingOptSet.m``` and ```testingOptSet.m```. 

### Usage:
1. run the script files ```go*.m```, according to your purpose.
  * goFeatureExtract: run feature extraction and save the extracted feature in ```opt.featurePath``` (specified in ```featureExtractOptSet.m```)
  * goCV: run cross validation task, the results will be write in the path you specified in ```opt.outFileName``` in ```crossValidOptSet.m```
  * goTraining: run only training
  * goTesting: run only testing
  * goAll:run all the above with all possible combination of parameters
  * goTTest: script for run t-test
