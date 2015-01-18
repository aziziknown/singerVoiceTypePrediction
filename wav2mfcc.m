function parameter= wav2mfcc(y, fs, frameSize, overlap, alpha, useEpd, order)
%WAV2MFCC Wave to MFCC (Mel-Frequency Cepstral Cofficient) conversion
%	Usage:
%	parameter = wav2mfcc(y, fs, frameSize, overlap, alpha, useEpd, order)
%	Parameter: MFCC and log energy, plus their delta value.
%	fs: sampling rate
%	useEpd: use end point detection or not

if nargin<1, selfdemo; return; end
if nargin<2, fs=16000; end
if nargin<3,
	switch fs,
	case {8000, 11025},
		frameSize = 256;
	case {16000, 22025, 22050}
		frameSize = 512;
	case {32000, 44100, 48000},
		frameSize = 1024;
	otherwise,
		frameSize = 512;
	end
end
if nargin<4, overlap=round(frameSize/3); end
if nargin<5, alpha=1; end
if nargin<6, useEpd=0; end
if nargin<7, order=8; end

[fstart,fcenter,fstop] = getTriParam(frameSize, fs/2, 0);

% ====== First Step : pre-emphasis.
y = filter([1, -0.95], 1, y);

% ====== Second Step: frame blocking.
framedY = buffer2(y, frameSize, overlap);
energy = sum(framedY.^2)/frameSize;
logEnergy = 10*log10(eps+energy);

% ====== Simple End Point Detection for Speaker Identification
if useEpd,
	threshold = 0.00001;	%energy threshold
	index = find(energy<threshold);
	energy(index)=[];
	logEnergy(index)=[];
	framedY(:, index) = [];
	if isempty(framedY), error('Empty after end-point detection!'); end;
end;

parameter = [];
for i = 1:size(framedY, 2),
	% ====== Third Step: hamming window.
	Wframe  = hamming(frameSize).*framedY(:,i);
    
	% ====== Forth Step: fast fourier transform.
	fftMag = abs(fft(Wframe));
	halfIndex = floor((frameSize+1)/2);
	fftMag = fftMag(1:halfIndex);
	fftMag = interp1(1:halfIndex,fftMag,1:1/alpha:halfIndex)';
      
	% ====== Fifth Step: triangular bandpass filter.
	P=20;
	tbfCoef = triBandFilter(fftMag, P, fstart, fcenter, fstop);
      
	% ====== Sixth Step: cosine transform. (Using DCT to get L order mel-scale-cepstrum parameters.)
	L=order;
	mfcc = melCepstrum(L, P, tbfCoef);
	parameter = [parameter mfcc'];
end;
%parameter = [parameter; logEnergy];

% ====== compute delta energy and delta cepstrum
deltaWindow = 2;
parameter = deltaFunction(deltaWindow, parameter);


% ====== Subfunction ======
% === Self demo
function selfdemo
waveFile='cnn01-1.wav';
[y, fs]=wavread(waveFile);
frameSize=512;
parameter= feval(mfilename, y, fs, frameSize);
fprintf('No. of extracted frames = %d\n', size(parameter, 2));

% === Triangular band-pass filters
function tbfCoef = triBandFilter(fftMag, P, fstart, fcenter, fstop)
% Triangular bandpass filter.
for i=1:P,
	for j = fstart(i):fcenter(i),
		filtmag(j) = (j-fstart(i))/(fcenter(i)-fstart(i));
	end
	for j = fcenter(i)+1:fstop(i),
		filtmag(j) = 1-(j-fcenter(i))/(fstop(i)-fcenter(i));
	end
	tbfCoef(i) = sum(fftMag(fstart(i):fstop(i)).*filtmag(fstart(i):fstop(i))');
end;
tbfCoef=log(eps+tbfCoef.^2);

% === TBF coefficients to MFCC
function mfcc = melCepstrum(L, P, tbfCoef)
% DCT to find MFCC
for i = 1:L,
	coef = cos((pi/P)*i*(linspace(1,P,P)-0.5))';
	mfcc(i) = sum(coef.*tbfCoef');
end;

% === Delta function
function parameter = deltaFunction(deltaWindow,parameter)
% compute delta cepstrum and delta log energy.
rows  = size(parameter,1);
cols  = size(parameter,2);
%temp  = [zeros(rows,deltaWindow) parameter zeros(rows,deltaWindow)];
temp  = [parameter(:,1)*ones(1,deltaWindow) parameter parameter(:,end)*ones(1,deltaWindow)];
temp2 = zeros(rows,cols);
denominator = sum([1:deltaWindow].^2)*2;
for i = 1+deltaWindow : cols+deltaWindow,
	subtrahend = 0;
	minuend    = 0;
	for j = 1 : deltaWindow,
		subtrahend = subtrahend + temp(:,i+j)*j;
		minuend = minuend + temp(:,i-j)*(-j);
	end;
	temp2(:,i-deltaWindow) = (subtrahend + minuend)/denominator;
end;
parameter = [parameter; temp2];
