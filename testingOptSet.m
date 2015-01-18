function opt=testingOptSet(trainingOpt)
if nargin>=1
	opt.loadFeatureOrNot = trainingOpt.loadFeatureOrNot;
    opt.usedDatasetFeaPath = trainingOpt.usedDatasetFeaPath;
    opt.usedFeature = trainingOpt.usedFeature;
    opt.dimReduceOpt=trainingOpt.dimReduceOpt;
else
	opt.loadFeatureOrNot = true;
	opt.usedDatasetFeaPath = '.\waveData.mat';
% 	opt.usedDatasetFeaPath = 'D:\Dropbox\2others_tmp\jang\singerVoiceTypePrediction\waveData.mat';
	opt.usedFeature = 'MFCC';
	opt.dimReduceOpt = dimReduceOptSet;
end

opt.loadModelOrNot = false;
% opt.usedModel = 'HMM';
opt.modelPath='';

opt.printResultOrNot = true;
opt.outFileName.resultAccuracy = 'AccuracyAll.csv';
opt.outFileName.resultConfusion = 'ConfusionAll.csv';
