function waveDataOut = phonationDatasetFileProcessing(waveData,opt)
% do some processing for the phonation mode dataset
% =========
% waveData:  structure array, each entry contains the useful information about a wave recording file
%           you can easily got waveData structure from waveData=recursiveFileList(path2wavefile, 'wav');

if nargin<2
	vtpOpt=vtpOptSet;
	opt=vtpOpt.featureExtractOpt;
end

% remove .* files, X5 files, *_2.wav *_pressedta.wav files
deleteIndex=[];
for i=1:length(waveData)
	if waveData(i).name(1)=='.'; deleteIndex=[deleteIndex, i]; end	
	if waveData(i).name(2)=='5'; deleteIndex=[deleteIndex, i]; end
	if strfind(waveData(i).name, '_2.wav'); deleteIndex=[deleteIndex, i]; end
	if strfind(waveData(i).name, '_3.wav'); deleteIndex=[deleteIndex, i]; end
	if strfind(waveData(i).name, 'pressedta.wav'); deleteIndex=[deleteIndex, i]; end
end
waveData(deleteIndex)=[];

% get and correct notename, vowel, singing mode/type
waveData = assignLabel(waveData,'polina');
for i=1:length(waveData)
	waveData(i).noteName=correctNoteName(waveData(i).noteName);
end

% remove files that singer did not sing all 4 types
deleteIndex=[];
allNoteName = {waveData.noteName};
allVowel = {waveData.vowel};
allMode = {waveData.mode};
[junk,support] = canonizeLabels(allMode);
for i=1:length(waveData)
	if ~ismember(i,deleteIndex)
		i_sameNoteVowel = find(strcmp(allNoteName,waveData(i).noteName) & strcmp(allVowel,waveData(i).vowel));
		if length(i_sameNoteVowel)<length(support)
			deleteIndex=[deleteIndex,i_sameNoteVowel];
		end
	end
end
waveData(deleteIndex)=[];

% detect endpoint and labels
waveData = assignSegmentLabel(waveData,[],opt);

waveDataOut = waveData;
end

function noteNameOut = correctNoteName(noteName)
	noteName = upper(noteName);
	if length(noteName)==3
		% change X3# to X#3 (for X=A~F)
		tmp = noteName(3);
		noteName(3)=noteName(2);
		noteName(2)=tmp;
	end
	noteName=strrep(noteName,'B','A#');
	noteName=strrep(noteName,'H','B');
	noteNameOut = noteName;
end