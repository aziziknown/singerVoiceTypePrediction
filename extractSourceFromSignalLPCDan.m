function GlottalSource = extractSourceFromSignalLPCDan(waveObj,opt)

if nargin<2, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt.Glottal; end

audio = waveObj.signal;
Fs=waveObj.fs;
if ~isfield(opt,'LPCOrder')
    p = round((Fs/16000)*20);
else
    p = opt.LPCOrder;
end

% p=20;
frameRate = opt.frameRate;
% frameRate = 50;
windowSize=Fs/frameRate;
% hop = round(windowSize/2);
[a,g,e] = lpcfit(audio,p,round(windowSize/2),windowSize);

GlottalSource.signal = e;
GlottalSource.fs=Fs;