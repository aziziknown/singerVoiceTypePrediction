function feature_MFCC = extractMFCCFromSignal(waveObj,opt)

if nargin<2, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt; end

frameRate = opt.frameRate;
audio = waveObj.signal;
Fs = waveObj.fs;
% frameRate = 50;
windowSize=Fs/frameRate;
hop = round(windowSize/2);
feature_MFCC = wav2mfcc(audio, Fs, windowSize, windowSize-hop, 1, 0, 13)';
