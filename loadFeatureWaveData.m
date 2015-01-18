function X = loadFeatureWaveData(waveData,featureName)
% load and concatenate different features
% waveData: waveData=recursiveFileList(path2wavefile, 'wav');
%           in this case, in features store in the 'feature' field in
%           waveData we want to put them in X
% featureName: cell string array of desire feature name
%%
fprintf('loading features from waveData...\n');
featureSet = split(featureName,'_');
featureAll = [waveData.feature];
delFea = setdiff(fieldnames(featureAll),featureSet);
featureAll = rmfield(featureAll,delFea); %remove unused feature
%% put feature in cell array form
feature = permute(struct2cell(featureAll),[3 1 2]);
X = cell(size(feature,1),1);
for i=1:size(feature,1)
	X{i}=cat(2,feature{i,:})'; % combine multiple features
end
X = segmentFeature(X,{waveData.soundSegment});	%change each element from file-based to segment-based