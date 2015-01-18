function waveDataOut = mergeSingers(waveDataCell)
% find the intersect of vowels of different singers
if isempty(waveDataCell)
	waveDataOut = [];
	return; 
elseif length(waveDataCell)==1
	waveDataOut = waveDataCell{1};
	return;
end

% merge waveDataCell, rmove no common field
for i=1:length(waveDataCell)
	fn=fieldnames(waveDataCell{i});
	if i==1, 
		minFieldNames = fn;
	else
		minFieldNames = intersect(minFieldNames,fn);
	end
end
for i=1:length(waveDataCell)
	fn=fieldnames(waveDataCell{i});
	fnDel = setdiff(fn,minFieldNames);
	waveDataCell{i}=rmfield(waveDataCell{i},fnDel);
end	
waveDataOut = cat(1,waveDataCell{:});

soundSegmentCell = cell(size(waveDataCell));
for i=1:length(waveDataCell)
	soundSegmentCell{i}=[waveDataCell{i}.soundSegment];
end

for i=1:length(soundSegmentCell)
	[junk support]=canonizeLabels({soundSegmentCell{i}.mode});
	if i==1, 
		minSupport = support;
	else
		minSupport = intersect(minSupport,support);
	end
end
% remove category that is not in min support
for i=1:length(waveDataOut)
	deleteIndex=[];
	for j=1:length(waveDataOut(i).soundSegment)
		if ~ismember(waveDataOut(i).soundSegment(j).mode,minSupport)
			deleteIndex=[deleteIndex, j];
		end
	end
	waveDataOut(i).soundSegment(deleteIndex)=[];			
end

%remove segment that its note and vowels are not cover all category
for i=1:length(soundSegmentCell)
	NoteVowel = cellfun(@(X,Y) [X '_' Y],{soundSegmentCell{i}.noteName},{soundSegmentCell{i}.vowel},'UniformOutput',false);
	if i==1
		minNoteVowel = NoteVowel;
	else
		minNoteVowel = intersect(NoteVowel,minNoteVowel);
	end
end
for i=1:length(waveDataOut)
	deleteIndex=[];
	for j=1:length(waveDataOut(i).soundSegment)
		if ~ismember([waveDataOut(i).soundSegment(j).noteName '_' waveDataOut(i).soundSegment(j).vowel],minNoteVowel)
			deleteIndex=[deleteIndex, j];
		end
	end
	waveDataOut(i).soundSegment(deleteIndex)=[];
end
	
%	%remove files that the segment is empty
%	deleteIndex=[];
%	for i=1:length(waveDataOut)
%		 if isempty(waveDataOut(i).soundSegment)
%			 deleteIndex=[deleteIndex, i];
%		 end
%	end

for i=1:length(waveDataOut)
	fn=fieldnames(waveDataOut(i).soundSegment);
	if i==1, 
		minFieldNames = fn;
	else
		minFieldNames = intersect(minFieldNames,fn);
	end
end
for i=1:length(waveDataOut)
	fn=fieldnames(waveDataOut(i).soundSegment);
	fnDel = setdiff(fn,minFieldNames);
	waveDataOut(i).soundSegment=rmfield(waveDataOut(i).soundSegment,fnDel);
end  
%	waveDataOut(deleteIndex)=[];
