function opt=testingOptSet(trainingOpt)
if nargin>=1 %we can generate testingOpt from trainingOpt
	opt.loadFeatureOrNot = trainingOpt.loadFeatureOrNot;
    opt.usedDatasetFeaPath = trainingOpt.usedDatasetFeaPath;
    opt.usedFeature = trainingOpt.usedFeature;
    opt.dimReduceOpt=trainingOpt.dimReduceOpt;
else
	opt.loadFeatureOrNot = true;
	opt.usedDatasetFeaPath = '.\waveData.mat';%where you put your feature mat file, the same file as the featureExtractOptSet put in opt.featurePath
	opt.usedFeature = 'MFCC';
	opt.dimReduceOpt = dimReduceOptSet;
end

opt.loadModelOrNot = false;
% opt.usedModel = 'HMM';
opt.modelPath='';

opt.printResultOrNot = true;
opt.outFileName.resultAccuracy = 'AccuracyAll.csv';
opt.outFileName.resultConfusion = 'ConfusionAll.csv';
