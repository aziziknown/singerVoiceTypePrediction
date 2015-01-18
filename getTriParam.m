function [fstart,fcent,fstop] = getTriParam(frameSize, Nyquistfreq, plotopt)
%GETTRIPARAM : Get parameters of triangular bandpass filters.
%Gavins 2002/5/24 (rough draft version)

if nargin==0,
	frameSize	= 256;
	Nyquistfreq = 4000; %half sample rate
	plotopt = 1;
end;

Melmaxfreq = freq2mel(Nyquistfreq);
Melminfreq = 0;
L = 20; %Counts of Triangular Bandpass Filter
MelBand = Melmaxfreq/L; %每個Mel Band大小, 
melarray = [0 : (MelBand/2) : Melmaxfreq];

% ====== Calculating fstart, fcent, fstop value.
freq  = mel2freq(melarray(1));
fstart= freq2axis(freq, Nyquistfreq, frameSize);
freq  = mel2freq(melarray(2));
fcent = freq2axis(freq, Nyquistfreq, frameSize);
freq  = mel2freq(melarray(3));
fstop = freq2axis(freq, Nyquistfreq, frameSize);
for k = 2 : 20,
	freq	= mel2freq(melarray((k-1)*2));
	axis	= freq2axis(freq, Nyquistfreq, frameSize);
	fstart = [fstart axis];
	
	freq	= mel2freq(melarray(k*2));
	axis	= freq2axis(freq, Nyquistfreq, frameSize);
	fcent  = [fcent axis];
	
	freq	= mel2freq(melarray(k*2+1));
	axis	= freq2axis(freq, Nyquistfreq, frameSize);
	fstop  = [fstop axis];
end;

fstart= fstart + 1;
fcent = fcent + 1;
fstop = fstop + 1;
if fstop(end)>= frameSize/2, %修整最後一個fstop value
	fstop(end)= frameSize/2;
end;

% ==========plot figure==============
if plotopt,
	a = [fstart;fcent;fstop]';
	b = ones(20,1)*[0 1 0];
	for i = 1: 20, plot(a(i,:),b(i,:),'b-'); hold on; end;
end;


% ==================================================%
%						Sub function							%
% ==================================================%
function melscale = freq2mel(freq)
melscale = 2595*log10(1+freq/700);

function freq = mel2freq(melscale)
freq = 700*(10^(melscale/2595)-1);

function axis = freq2axis(freq, Nyquistfreq, frameSize)
axis = round((freq/Nyquistfreq)*(frameSize/2));