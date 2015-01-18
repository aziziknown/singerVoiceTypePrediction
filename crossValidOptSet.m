function opt=crossValidOptSet
% return a default options for crossvaliation
%----------------
% opt.trainingOpt = trainingOptSet;
opt= trainingOptSet;

opt.CVIndPath = '.\CV.mat';
% opt.CVIndPath = 'D:\Dropbox\Digimax\sing_voice\recordings\filntu\CV3sec.mat';
% opt.CVIndPath = 'D:\Dropbox\Digimax\sing_voice\recordings\known\tutor\CV3sec.mat';
opt.loadCV = true;
opt.numFold = 5;
opt.printResultOrNot = true;
opt.outputRoot='.';
% opt.outputRoot = 'C:\Users\known\Documents\Dropbox\Digimax\sing_voice\recordings\phonation_dataset\result\';
% opt.outFileName.resultAccuracy = [opt.outputRoot filesep 'AccuracyAll.csv'];
% opt.outFileName.resultConfusion = [opt.outputRoot filesep 'ConfusionAll.csv'];
opt.outFileName.resultAccuracy = 'AccuracyAll.csv';
opt.outFileName.resultConfusion = 'ConfusionAll.csv';
