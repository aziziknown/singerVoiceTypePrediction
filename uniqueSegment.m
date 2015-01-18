function waveDataOut = uniqueSegment(waveData)
%delete duplicate vowel segments, remain the first one
waveDataOut = waveData;
nSeg=arrayfun(@(X) length(X.soundSegment),waveDataOut);
nSegCum = cumsum(nSeg);
Seg=[waveData.soundSegment];
allLabel=cellfun(@(X,Y,Z,W) [X '_' Y '_' Z '_' W],{Seg.singer},{Seg.mode},{Seg.noteName},{Seg.vowel},'UniformOutput',false);
[support pickInd]=unique(allLabel,'first');
 pickInd = sort(pickInd);
 
for i=1:length(waveDataOut)
	deleteIndex=[];
    if i==1
        deleteIndex = setdiff(1:nSeg(i),pickInd((pickInd<=nSegCum(i))));
    else
        deleteIndex = setdiff(1:nSeg(i),pickInd((pickInd>nSegCum(i-1))&(pickInd<=nSegCum(i)))-nSegCum(i-1));
    end
    waveDataOut(i).soundSegment(deleteIndex)=[];
end	