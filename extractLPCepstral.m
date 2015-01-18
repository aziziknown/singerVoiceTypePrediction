function feature_LPCepstral = extractLPCepstral(audiofile,opt)
% audiofile = 'D:\Dropbox\Digimax\sing_voice\recordings\little_sunshine\cut\high_thick\C4_A_high_thick.wav';
% audiofile = 'D:\azz\music_audio_research\datasets\phonation_mode_dataset\2_1_trimmed\cut_mode\cut\breathy\A#3_AE_breathy.wav';

if nargin<2, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt; end

frameRate = opt.frameRate;
% frameRate = 50;
% frameRate = 62.5;
% sampling_rate = 16000;

[audio,f] = wavread(audiofile);
audio = mean(audio,2);
% audio_max = max(audio);
% audio_min = min(audio);
% audio = resample(audio, sampling_rate,f);
% audio_r_max = max(audio);
% audio_r_min = min(audio);
% audio = ((audio-audio_r_min)/(audio_r_max-audio_r_min))*(audio_max-audio_min) +audio_min ;
windowSize=f/frameRate;
% windowSize=sampling_rate/frameRate;

if ~isfield(opt,'LPCOrder')
	p = round((f/16000)*20);
else
	p = opt.LPCOrder;
end
% p = round((sampling_rate/16000)*20);
% p=20;
% order = 20;
[a,g,e] = lpcfit(audio,p,round(windowSize/2),windowSize);
feature_LPCepstral = zeros(size(a));
for n=1:(p+1)
	feature_LPCepstral(:,n) = a(:,n);
	for i=1:(n-1)
		feature_LPCepstral(:,n) = feature_LPCepstral(:,n) + (i/n)*feature_LPCepstral(:,i).*a(:,n-i);
	end
end
feature_LPCepstral(:,1)=[];
% feature_LPCepstral(:,(order+1):end)=[];

disp(sprintf('extract LPC Cepstral end : %s', audiofile));
