st = tic;
% vtpInit;
modelPath = 'selfTrainModel.mat';
load(modelPath,'model','opt')
opt = testingOptSet(opt);

fprintf('start self testing...\n');
result=TestVoiceTypeOneModelLoadData([],[],model,opt);
printResult(opt,result);
save('selfTestResult.mat','result','opt');
fprintf('end self testing...\n');
toc(st)