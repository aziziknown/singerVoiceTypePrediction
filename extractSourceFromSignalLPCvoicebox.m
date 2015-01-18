function GlottalSource = extractSourceFromSignalLPCvoicebox(waveObj,opt)

if nargin<2, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt.Glottal; end

audio = waveObj.signal;
Fs = waveObj.fs;

dy_lpcnf=voicebox('dy_lpcnf');          % lpc poles per Hz (1/Hz)
dy_lpcn=voicebox('dy_lpcn');
lpcord=ceil(Fs*dy_lpcnf+dy_lpcn);
dy_preemph=voicebox('dy_preemph');
dy_lpcstep=voicebox('dy_lpcstep');
dy_lpcdur=voicebox('dy_lpcdur');
audio=filter([1 -exp(-2*pi*dy_preemph/Fs)],1,audio);
[ar, e, k] = lpcauto(audio,lpcord,floor([dy_lpcstep dy_lpcdur]*Fs));
GlottalSource.signal = lpcifilt(audio,ar,k);
GlottalSource.fs = Fs;

