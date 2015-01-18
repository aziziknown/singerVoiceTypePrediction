function feature = extractFeatureOneFile(wavName, featureName, feature_LPCDan, opt)
if nargin<3, feature_LPCDan=[]; end
if nargin<4, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt; end
try
	if strcmp(featureName,'LSP')
		if isempty(feature_LPCDan)
			feature_LPCDan = extractLPCDan(wavName,opt);
		end
		feature = lpca2lsp([ones(size(feature_LPCDan,1),1) feature_LPCDan]);
	elseif strncmp(featureName,'GlottalMFCC',11)
		feature = feval(str2func(['extractGlottalMFCC']),wavName,featureName(12:end),opt);
	else
		feature = feval(str2func(['extract' featureName]),wavName,opt);
	end
catch  exception
	switch exception.identifier
		case {'MATLAB:nomem','MATLAB:UndefinedFunction'}
			fprintf('%s\n',exception.message);
			feature = exception;
			return;
		otherwise
			rethrow(exception)
	end		   
end