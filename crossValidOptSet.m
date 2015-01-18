function opt=crossValidOptSet
% return a default options for crossvaliation
%----------------
% opt.trainingOpt = trainingOptSet;
opt= trainingOptSet;

opt.CVIndPath = '.\CV.mat';
opt.loadCV = true;
opt.numFold = 5;
opt.printResultOrNot = true;
opt.outputRoot='./result/'; %where to store the results
% opt.outFileName.resultAccuracy = [opt.outputRoot filesep 'AccuracyAll.csv'];
% opt.outFileName.resultConfusion = [opt.outputRoot filesep 'ConfusionAll.csv'];
opt.outFileName.resultAccuracy = 'AccuracyAll.csv';
opt.outFileName.resultConfusion = 'ConfusionAll.csv';
