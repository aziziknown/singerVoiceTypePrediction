function result=TestVoiceTypeOneModelLoadData(X,y,model,opt)
% load data and call TestVoiceTypeOneModel
% X: testing data in cell array, each entry contains a sequence of features 
% y: cell array string
% model: trained by model = TrainVoiceTypeOneModel
% opt = trainingOptSet();
%% load data
if (isfield(opt,'loadFeatureOrNot') && opt.loadFeatureOrNot==true)
	fprintf('loading waveData...');
	load(opt.usedDatasetFeaPath,'waveData');
	%load feature
	X = loadFeatureWaveData(waveData,opt.usedFeature);
	%set groundtruth label
	w=[waveData.soundSegment];
	y = {w.mode}';
	result.singer = w(1).singer;
end
if isempty(X) || isempty(y)
    msg = 'there is no feature and groundturth data';
    fprintf('%s\n',msg);
    error('MATLAB:TestVoiceTypeOneModelLoadData:noData', msg);		
end
%% load model
if (isfield(opt,'loadModelOrNot') && opt.loadModelOrNot==true)
	load(opt.modelPath,'model');
end
if isempty(model)
    msg = 'there is no model data';
    fprintf('%s\n',msg);
    error('MATLAB:TestVoiceTypeOneModelLoadData:noModel', msg);		
end

%% testing
[result.yhat,result.posterior] = TestVoiceTypeOneModel(X,model);
[result.confusion,result.confusionInPercent]= calculateConfusionMatrix(y,result.yhat,model.support);
% assign results
result.time = clock;
result.model = {model};
result.categories = model.support;
result.avgAccuracy = sum(diag(result.confusion))/sum(result.confusion(:));
result.avgConfusion=result.confusion;
result.avgConfusionInPercent=result.confusionInPercent;