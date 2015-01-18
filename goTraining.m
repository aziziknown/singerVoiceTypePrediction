st=tic;
% vtpInit;
opt = trainingOptSet;

%% trainging
fprintf('start self training...\n');
model = TrainVoiceTypeOneModel([],[],opt);
save('selfTrainModel.mat','model','opt');
fprintf('end self training...\n');
toc(st)