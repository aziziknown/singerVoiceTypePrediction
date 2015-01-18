function Z=dimReduceOnData(X,model)
% compute output Z space (the reduced space), and determine K
% X features
% model: dimension reduction model (computed by dimReduce.m)
switch model.type
	case 'ppca'
		Z = cellfun(@(X) ppcaInferLatent(model.model,X')',X,'UniformOutput',false);
	case {'fisherlda','pcajang','ldajang','fldajang'}
		Z = cellfun(@(X) (X'*model.W)',X,'UniformOutput',false);
	otherwise
		Z = X;
end
