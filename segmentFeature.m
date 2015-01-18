function Xout = segmentFeature(X,soundSegments)   
% cut the feature sequence X into segments according to "soundSegments"

fprintf('segmenting features...\n');
nout = 0;
nseg = length(soundSegments);
for i=1:nseg
	nout = nout + length(soundSegments{i});
end
Xout = cell(nout,1);
iout = 1;
for i=1:nseg
	for j=1:length(soundSegments{i})
		st = soundSegments{i}(j).beginFeaFrame;
		ed = soundSegments{i}(j).endFeaFrame;
		if st<1, st=1;end;
		if ed>size(X{i},2),ed =size(X{i},2);end;
		Xout{iout}=X{i}(:,st:ed);
		iout = iout + 1;
	end
end	

% figure(1);
% for i=1:nseg
%     imagesc(X{i});
%     hold on
%     bar(soundSegments{i}(1).beginFeaFrame,size(X{i},1));
%     bar(soundSegments{i}(1).endFeaFrame,size(X{i},1));
%     saveas(gcf,sprintf('MFCC%03d.png',i));
%     hold off
% end
% i=0;