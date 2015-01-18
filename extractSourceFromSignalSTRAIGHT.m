function GlottalSource = extractSourceFromSignalSTRAIGHT(waveObj,opt)

if nargin<2, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt.Glottal; end

audio = waveObj.signal;
Fs =waveObj.fs;
% source
r = exF0candidatesTSTRAIGHTGB(audio,Fs); % Extract F0 information
rc = autoF0Tracking(r,audio); % Clean F0 trajectory by tracking
rc.vuv = refineVoicingDecision(audio,rc);
q = aperiodicityRatioSigmoid(audio,rc,1,2,0); % aperiodicity extraction

% spectral
f = exSpectrumTSTRAIGHTGB(audio,Fs,q);
STRAIGHTobject.waveform = audio;
STRAIGHTobject.samplingFrequency = Fs;
STRAIGHTobject.refinedF0Structure.temporalPositions = r.temporalPositions;
STRAIGHTobject.SpectrumStructure.spectrogramSTRAIGHT = f.spectrogramSTRAIGHT;
STRAIGHTobject.refinedF0Structure.vuv = rc.vuv;
f.spectrogramSTRAIGHT = unvoicedProcessing(STRAIGHTobject);

% synthesize
s2 = exGeneralSTRAIGHTsynthesisR2(q,f);
GlottalSource.signal = s2.synthesisOut/max(abs(s2.synthesisOut))*0.8;
padding = zeros(length(audio)-length(GlottalSource.signal),1);
GlottalSource.signal = [GlottalSource.signal; padding];
GlottalSource.fs=Fs;

