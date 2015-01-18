function feature_GlottalMFCC = extractGlottalMFCC(audiofile,type,opt)

if nargin<2 || isempty(type), type = 'GLOAT'; end
if nargin<3, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt; end
    
% [wave,Fs]=wavread(audiofile);
waveObj = waveFile2obj(audiofile);
waveObj.signal = mean(waveObj.signal,2);

% GlottalSource = extractGlottalSourceFromSignal(wave,Fs,type);
GlottalSource = feval(str2func(['extractSourceFromSignal' type]),waveObj,opt.Glottal);

feature_GlottalMFCC = extractMFCCFromSignal(GlottalSource,opt);