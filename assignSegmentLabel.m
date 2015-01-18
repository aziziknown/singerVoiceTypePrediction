function waveDataOut = assignSegmentLabel(waveData,label,opt)
% use endpoint detection (in sap toolbox) to detect segments
% assign labels on segments sequentially
% waveData:  structure array, each entry contains the useful information about a wave recording file
%           you can easily got waveData structure from waveData=recursiveFileList(path2wavefile, 'wav');
% label: structure of fields: 'noteName','vowel','mode','singer', each of
%        them could be also cell array
%         e.g. label=struct('singer','known','vowel',{'I','E','A','O','U'})

if nargin<2, label=[]; end
if nargin<3, opt=featureExtractOpt(); end

for i=1:length(waveData)
	fprintf('Find Sound Segment: %d/%d: waveFile=%s\n', i, length(waveData), waveData(i).path);

	wavName=waveData(i).path;
	[audio fs nb]=wavread(wavName);
	audio = mean(audio,2);
	[junk, junk, soundSegment, junk, junk] = epdByVolZcr(audio,fs,nb);

	if ~isempty(label), soundSegment(1:(end-length(label)))=[];end;

	hop = fs*0.5/opt.frameRate;
	tmp = num2cell(round([[soundSegment.beginSample]; [soundSegment.endSample]]./hop));

	[soundSegment.beginFeaFrame] = tmp{1,:};
	[soundSegment.endFeaFrame] = tmp{2,:};

	labelCat = {'noteName','vowel','mode','singer'};
	for i_lab=1:length(labelCat)
		if isfield(waveData(i),labelCat{i_lab}), 
			[soundSegment.(labelCat{i_lab})] = deal(waveData(i).(labelCat{i_lab}));
		else 
			[soundSegment.(labelCat{i_lab})] = label.(labelCat{i_lab});
		end
	end

	waveData(i).soundSegment = soundSegment;
end
waveDataOut = waveData;