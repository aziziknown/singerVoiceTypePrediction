function result = crossValidation(X,y,opt)
% run cross validation 
% X: cell array of feature vectors
% y: ground truth labels
% opt: options, from crossValidOptSet();
%% load feature, goundtruth
if (isfield(opt,'loadFeatureOrNot') && opt.loadFeatureOrNot==true)
	fprintf('loading waveData...');
	load(opt.usedDatasetFeaPath,'waveData');
	%load feature
	X = loadFeatureWaveData(waveData,opt.usedFeature);
	%set groundtruth label
	w=[waveData.soundSegment];
% 	y = cellfun(@(X,Y) [X '_' Y],{w.singer},{w.mode},'UniformOutput',false)';
	y = {w.mode}';
%     y = {waveData.mode}';
	opt.loadFeatureOrNot=false;
	result.singer = w(1).singer;
end
if isempty(X) || isempty(y)
    msg = 'there is no feature or groundturth data';
    fprintf('%s\n',msg);
    error('MATLAB:crossValidation:noData', msg);		
end
%% load previous computed CrossValidation ind
if opt.loadCV
    if exist(opt.CVIndPath,'file')
        load(opt.CVIndPath,'CV');
    end
end
% if there is no previous computed CV, compute new one
if ~exist('CV','var')
	CV=crossValidInd(y,opt.numFold);
	if exist(opt.CVIndPath,'file')
		save(opt.CVIndPath, '-append', 'CV');
	else
		save(opt.CVIndPath, 'CV');
	end
end
%% run cross validation
for i = 1:CV.numFold
    fprintf('fold: %d/%d\n', i,CV.numFold);
    Xtrain = X(CV.trainfolds{i});
    ytrain = y(CV.trainfolds{i});
    Xtest = X(CV.testfolds{i});
    ytest = y(CV.testfolds{i});			
    [Xtrain, ytrain] = shuffleRows(Xtrain, ytrain);
    model{i} = TrainVoiceTypeOneModel(Xtrain,ytrain,opt);
    if isa(model{i},'MException')
        result = model{i};
        return;
    end
    [fold(i).yhat,fold(i).posterior] = TestVoiceTypeOneModel(Xtest,model{i});
    [fold(i).confusion,fold(i).confusionInPercent]= calculateConfusionMatrix(ytest,fold(i).yhat,model{i}.support); 
end
%% assign results
result.time = clock;
result.model = model;
result.fold = fold;
result.categories = model{1}.support;
result.avgAccuracy = mean(arrayfun(@(X) sum(diag(X.confusion))/sum(X.confusion(:)),result.fold));
result.stdAccuracy = std(arrayfun(@(X) sum(diag(X.confusion))/sum(X.confusion(:)),result.fold));
result.avgConfusion=mean(cat(3,result.fold.confusion),3);
result.stdConfusion=std(cat(3,result.fold.confusion),0,3);
result.avgConfusionInPercent=mean(cat(3,result.fold.confusionInPercent),3);
result.stdConfusionInPercent=std(cat(3,result.fold.confusionInPercent),0,3);
%% printing results
printResult(opt,result);