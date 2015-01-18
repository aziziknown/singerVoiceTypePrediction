st = tic;
% vtpOpt=vtpOptSet;
% opt = vtpOpt.crossValidOpt;
% vtpInit;
% opt = crossValidOptSet();

fprintf('start cross validation...\n');
result = crossValidation([],[],opt);
if ~isa(result,'MException')
    save([opt.outputRoot filesep 'Cross' num2str(opt.numFold) '-' opt.usedModel '-' opt.usedFeature '-' opt.dimReduceOpt.type num2str(result.model{1}.featureDim)  '.mat'],'result','opt');
end
fprintf('end cross validation...\n');
toc(st)
