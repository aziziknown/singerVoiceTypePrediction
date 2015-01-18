function waveDataOut = azzDatasetFileProcessing(waveData,label,opt)
% do some processing for my own datasets
% assign labels on each segment and then remove files that has sound detection error
% =========
% waveData:  structure array, each entry contains the useful information about a wave recording file
%           you can easily got waveData structure from waveData=recursiveFileList(path2wavefile, 'wav');
% label: structure of fields: 'noteName','vowel','mode','singer', each of
%        them could be also cell array
%         e.g. label=struct('singer','known','vowel',{'I','E','A','O','U'})

if nargin<3, opt=vtpOpt.featureExtractOpt(); end

%	 waveData = assignLabels(waveData,'known');
waveData = assignLabel(waveData);
%	 vowels = {'I','E','A','O','U'};
% label = repmat(label,1,5);
waveData = assignSegmentLabel(waveData,label,opt);

%remove files that has sound detection error
deleteIndex=[];
allNoteName = {waveData.noteName};
for i=1:length(waveData)
	if ~ismember(i,deleteIndex)
		if length(waveData(i).soundSegment)~=10
			i_sameNote = find(strcmp(allNoteName,waveData(i).noteName));
			deleteIndex=[deleteIndex,i_sameNote];
		end
	end
end
waveData(deleteIndex)=[];
	
waveDataOut = waveData;