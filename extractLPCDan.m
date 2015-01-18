function feature_LPCDan = extractLPCDan(audiofile,opt)
%audiofile = 'F:\MMAI\cut\breathy\A3_A_breathy.wav';
% audiofile = 'D:\azz\music_audio_research\datasets\phonation_mode_dataset\2_1_trimmed\cut_mode\cut\breathy\A#3_A_breathy.wav';
if nargin<2, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt; end
frameRate = opt.frameRate;
% frameRate = 50;
% frameRate = 62.5;

[audio,f] = wavread(audiofile);
audio = mean(audio,2);
windowSize=f/frameRate;

if ~isfield(opt,'LPCOrder')
	p = round((f/16000)*20);
else
	p = opt.LPCOrder;
end
% p=20;
[a,g,e] = lpcfit(audio,p,round(windowSize/2),windowSize);
feature_LPCDan = a(:,2:end);

disp(sprintf('extract LPC end : %s', audiofile));
