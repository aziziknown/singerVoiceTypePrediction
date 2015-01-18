function waveDataOut = assignLabel(waveData,singerName)
% assign labels to waveData from parsing filename
% the filename could be noteName_singingMode or noteName_vowel_siningMode
% all separate with "_"
% waveData: structure array, each entry contains the useful information about a wave recording file
%           you can easily got waveData structure from waveData=recursiveFileList(path2wavefile, 'wav');
% singerName: string describe the singer's name, will be assign to each entry in waveData
for i=1:length(waveData)
	[junk, mainName]=fileparts(waveData(i).name);
	items=split(mainName, '_');
	waveData(i).noteName=items{1};
	if length(items)==2 
		waveData(i).mode=items{2};
	elseif length(items)==3 
		waveData(i).vowel=items{2};
		waveData(i).mode=items{3};
	end
end
if exist('singerName','var') && ~isempty(singerName)
	[waveData.singer] = deal(singerName);
end
waveDataOut = waveData;