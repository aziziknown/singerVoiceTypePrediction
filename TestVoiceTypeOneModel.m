function [yhat,post] = TestVoiceTypeOneModel(Xtest,model)
% Xtest: testing data in cell array, each entry contains a sequence of features 
% model: trained by TrainVoiceTypeOneModel
%% dimension reduction
if isfield(model,'dimReduceModel') && ~isempty(model.dimReduceModel.type)
	Xtest = dimReduceOnData(Xtest,model.dimReduceModel);
end
%% testing
if strcmp(model.name(1:3),'HMM')
	logprobFn = @hmmLogprob;
	[yhat, post] = generativeClassifierPredict(logprobFn, model, Xtest);
elseif strcmp(model.name,'GMM')
	logprobFn = @mixGaussLogprob;
	[yhat,post] = cellfun(@(X) generativeClassifierPredict(logprobFn, model,X'),Xtest,'UniformOutput',false);
	categories = model.support;
	yhat = cellfun(@(X) categories{mode(canonizeLabels(X,categories))},yhat,'UniformOutput',false);
	post = cellfun(@(X) mean(X),post,'UniformOutput',false);
	post = cat(1,post{:});
else
	disp('model name error!!')
	yhat = [];
	post = [];
end