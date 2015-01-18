st = tic;
vtpInit;
opt = featureExtractOptSet;
%% Collect all wav files
waveData=recursiveFileList(opt.datasetDir, 'wav');
% House keeping
% waveData = phonationDatasetFileProcessing(waveData, opt);
% waveData = azzDatasetFileProcessing(waveData,struct('singer','known','vowel',{'I','E','A','O','U'}),opt);
waveData = azzDatasetFileProcessing(waveData,struct('singer','known','vowel',[repmat({'I'},1,5),repmat({'A'},1,5)]),opt);
%% extracting feature
errFeaInd=false(length(opt.featureList),1);
for i=1:length(waveData)
	fprintf('%d/%d: waveFile=%s\n', i, length(waveData), waveData(i).path);
	wavName=waveData(i).path;
	for j=1:length(opt.featureList)
% 		if i==1; feature.(opt.featureList{j}) = cell(length(waveData),1); end;
		featureName = opt.featureList{j};
		if strcmp(featureName,'LSP') && isfield(waveData(i).feature,'LPCDan') && ~isa(waveData(i).feature.LPCDan,'MException')
			waveData(i).feature.(featureName) = extractFeatureOneFile(wavName,featureName,waveData(i).feature.LPCDan, opt);
		else
			waveData(i).feature.(featureName) = extractFeatureOneFile(wavName,featureName, [], opt);
		end
	end
	errFeaInd = errFeaInd | structfun(@(X) isa(X,'MException'),waveData(i).feature);
end
errFea = opt.featureList(errFeaInd);
errMsg = arrayfun(@(X) rmfield(X,opt.featureList(~errFeaInd)),[waveData.feature],'UniformOutput',false);%remove normal feature
feature = arrayfun(@(X) rmfield(X,opt.featureList(errFeaInd)),[waveData.feature],'UniformOutput',false);%remove error feature
[waveData.feature] = deal(feature{:});%remove error feature--assign back to waveData
% feature=rmfield(feature,fn(structfun(@(X) sum(cellfun(@(Y) isa(Y,'MException'),X))~=0,feature))); %remove feature that has err 
%%
save(opt.featurePath,'waveData', 'opt','errFea','errMsg');
disp('end feature extraction...')
toc(st)