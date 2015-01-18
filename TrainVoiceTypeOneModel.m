function model = TrainVoiceTypeOneModel(Xtrain,ytrain,opt)
% Xtrain: training data in cell array, each entry contains a sequence of features 
% ytrain: cell array string
% opt = trainingOptSet();
%% load feature,goundtruth
if (isfield(opt,'loadFeatureOrNot') && opt.loadFeatureOrNot==true)
	fprintf('loading waveData...');
	load(opt.usedDatasetFeaPath,'waveData');
	%load feature
	Xtrain = loadFeatureWaveData(waveData,opt.usedFeature);
	%set groundtruth label
	w=[waveData.soundSegment];
	ytrain = {w.mode}';
end
if isempty(Xtrain) || isempty(ytrain)
    msg = 'there is no feature or groundturth data';
    fprintf('%s\n',msg);
    error('MATLAB:TrainVoiceTypeOneModel:noData', msg);		
end
%% do dimension reduction
if isfield(opt,'dimReduceOpt') && ~isempty(opt.dimReduceOpt.type)
	try
		[Xtrain,dimReduceModel] = dimReduce(Xtrain,opt.dimReduceOpt,ytrain);
	catch exception
		switch exception.identifier
			case {'MATLAB:dimReduce:ppcaSameDim','MATLAB:dimReduce:targetDimExceed','MATLAB:eig:matrixWithNaNInf','MATLAB:nomem'}
				fprintf('%s\n',exception.message);
				model = exception;
				return;
			otherwise
				rethrow(exception)
		end		   
	end
end
%% do training
try
    modelName = opt.usedModel;
	if strcmp(modelName(1:3),'HMM')
		if strcmp(modelName,'HMMstu')
			fitFn   = @(X)hmmFit(X, opt.numHMMState, 'student'); 
		else
			fitFn   = @(X)hmmFit(X, opt.numHMMState, 'gauss'); 
		end
		model = generativeClassifierFit(fitFn, Xtrain, ytrain);   
	elseif strcmp(modelName,'GMM')
		fitFn   = @(X)mixGaussFit(cat(2,X{:})', opt.numGMMMixture); 
		model = generativeClassifierFit(fitFn, Xtrain, ytrain);   
	else
		disp('model name error!!')
	end
catch exception
	if strcmp(exception.identifier, 'MATLAB:posdef')
		fprintf('matrix singular, plz try dimension reduction!\n');
		model = exception;
		return;
	else
		rethrow(exception)
	end   
end

model.name = modelName;
model.featureDim = size(Xtrain{1},1);

if isfield(opt,'dimReduceOpt') && ~isempty(opt.dimReduceOpt.type)
	model.dimReduceModel = dimReduceModel;
end	