function plotPitchPeriodFromSignal(audio,fs,yrange,ftitle)
% yrang: the ylimit of the plot
% ftitle: the title of the figure
%-------------------------
% audiofile = 'F:\Download\datasets\phonation_mode_dataset\2_1_trimmed\cut_mode_same_size\cut\flow\A4_A_flow.wav';
% [audio,f] = wavread(audiofile);
% audio = mean(audio,2);
if ~exist('ftitle','var')
	ftitle='audio';
end

pitch_marks = find_pmarks(audio, fs);
l = round(mean(diff(pitch_marks)));
fh=figure('Name',ftitle);
hold off
for i=1:length(pitch_marks)-2
% figure(1);plot(abs(audio(pitch_marks(i):pitch_marks(i+2))));ylim(yrange)%ylim([-0.02,0.02])%ylim([-5,5])%
xx = audio(pitch_marks(i):pitch_marks(i+2));
xx = resample(xx,l*2,length(xx));
%figure(fh);plot(xx);ylim(yrange)%ylim([-0.02,0.02])%ylim([-5,5])%
plot(xx);ylim(yrange)%ylim([-0.02,0.02])%ylim([-5,5])%
xlim([0 600])
title(strrep(ftitle,'_',' '))
hold on
% pause(0.1)
end
saveas(fh,[ftitle '.png']);
close