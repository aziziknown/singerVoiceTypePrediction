function feature_ZCR = extractZCR(audiofile)

start=1;
frameRate = 50;

[audio,f] = wavread(audiofile, [1 10]);
windowSize=f/frameRate;
total = wavread(audiofile, 'size');
total = total(1);
feature_ZCR = zeros(floor(total/windowSize),1);

for i = 1:length(feature_ZCR)
	st = (i-1)*windowSize+1;
	ed = i*windowSize;
	data = wavread(audiofile, [st ed]);
	feature_ZCR(i) = cr(data, 0);
end

disp(sprintf('extract ZCR end : %s', audiofile));
