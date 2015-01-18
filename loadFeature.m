function X = loadFeature(featurePath,featureName)
% load and concatenate different features
% featurePath: path for loading features
% featureName: cell string array of desire feature name
fprintf('loading features...\n');
featureSet = split(featureName,'_');
S = load(featurePath,featureSet{:});
if length(fieldnames(S))<length(featureSet)
	missingFeature = setdiff(featureSet,fieldnames(S));
	msg = ['Feature not exist: ' sprintf('%s,',missingFeature{:})];
	fprintf('%s\n',msg);
	error('MATLAB:loadFeature:noFeature', msg);
end
C = struct2cell(S)';
feature = cat(2,C{:});
X = cell(size(feature,1),1);
for i=1:size(feature,1)
	X{i}=cat(2,feature{i,:})';
end
%	 feature = cellfun(@(X) S.(X),featureSet,'UniformOutput',false);
%	 feature = cellfun(@(X) cat(,cat(2,feature{:});
%	 X = feature;	