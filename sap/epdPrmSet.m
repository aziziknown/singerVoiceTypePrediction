function epdPrm=epdPrmSet(fs)
% epdPrmSet: Set parameters for endpoint detection
% 	Usage: epd=epdPrmSet(fs)

%	Roger Jang, 20070630, 20080504

if nargin<1; fs=8000; end

epdPrm.frameSize=fs/(16000/256);	% Frame size (fs=16000 ===> frameSize=256)
epdPrm.overlap=0;			% Frame overlap

% The followings are mainly for epdByVol.m
epdPrm.volRatio=0.1;
epdPrm.vMinMaxPercentile=3;

% For epdByVolZcr.m
epdPrm.volRatio2=0.2;
epdPrm.zcrRatio=0.1;
epdPrm.zcrShiftGain=4;

% For epdByEntropy
epdPrm.veRatio=0.1;
epdPrm.veMinMaxPercentile=3;

% For epdByVolHod.m
epdPrm.vhRatio=0.012;	% 0.11
epdPrm.diffOrder=1;
epdPrm.volWeight=0.76;
epdPrm.vhMinMaxPercentile=2.3;		% 5.0%

epdPrm.extendNum=1;			% Extend front and back
% epdPrm.minSegment=0.068;			% Sound segments (in seconds) shorter than or equal to this value are removed
epdPrm.minSegment=0.5;			% Sound segments (in seconds) shorter than or equal to this value are removed
% epdPrm.maxSilBetweenSegment=0.416;	% 
epdPrm.maxSilBetweenSegment=0.1;	% 
epdPrm.minLastWordDuration=0.2;	%