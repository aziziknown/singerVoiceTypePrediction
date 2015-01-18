function GlottalSource = extractSourceFromSignalGLOAT(waveObj,opt)

if nargin<2, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt.Glottal; end

F0min=opt.f0Min;
F0max=opt.f0Max;
wave=waveObj.signal;
Fs = waveObj.fs;
% F0min=80;
% F0max=800;

%% Pitch tracking using a method based on the Summation of the Residual Harmonics
[f0,VUVDecisions,SRHVal] = SRH_PitchTracking(wave,Fs,F0min,F0max);
VUVDecisions2=zeros(1,length(wave));
HopSize=round(10/1000*Fs);
for k=1:length(VUVDecisions)
	VUVDecisions2((k-1)*HopSize+1:k*HopSize)=VUVDecisions(k);    
end

%% Estimation of the mean pitch value
f0_tmp=f0.*VUVDecisions;
pos= f0_tmp~=0;
f0_tmp=f0_tmp(pos);
F0mean=mean(f0_tmp);

%% Oscillating Moment-based Polarity Detection
[Polarity] = OMPD_PolarityDetection(wave,Fs,F0mean,VUVDecisions);

%% Speech Event Detection using the Residual Excitation And a Mean-based Signal
% [gci,MeanBasedSignal] = SEDREAMS_GCIDetection(Polarity*wave,Fs,F0mean);
[gci,MeanBasedSignal] = SEDREAMS_GCIDetection_ComputationalPerformanceOptimized(Polarity*wave,Fs,F0mean);
%% Glottal Source estimation using the Complex Cepstrum
[GlottalSource.signal] = CCD_GlottalFlowEstimation(Polarity*wave,Fs,gci,f0,VUVDecisions);
GlottalSource.fs=Fs;
