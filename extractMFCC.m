function feature_MFCC = extractMFCC(audiofile,opt)
% audiofile = 'D:\Dropbox\Digimax\sing_voice\recordings\little_sunshine\cut\high_thick\C4_A_high_thick.wav';
% audiofile = 'D:\azz\music_audio_research\datasets\phonation_mode_dataset\2_1_trimmed\cut_mode\cut\breathy\A#3_A_breathy.wav';
% audiofile = 'F:\Download\datasets\phonation_mode_dataset\2_1_trimmed\cut\A3_A_breathy.wav';
if nargin<2, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt; end

waveObj = waveFile2obj(audiofile);
waveObj.signal = mean(waveObj.signal,2);

feature_MFCC = extractMFCCFromSignal(waveObj,opt);
