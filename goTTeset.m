vtpInit;
outputRoot = 'D:\azz\music_audio_research\datasets\phonation_mode_dataset\2_1_trimmed\output\6th\';
% baseline = 'Cross5-GMM-MFCC-26';
% baseline = 'Cross5-HMM-MFCC-26';
baseline = 'Cross5-GMM-GlottalMFCCLPCDan-26';
outfile = 'TTtestAll.csv';
featureToUse = {'MFCC','LPCDan','LSP','GlottalMFCCGLOAT','GlottalMFCCSTRAIGHT','GlottalMFCCLPCDan','GlottalMFCCLPCvoicebox'};
% featureToUse = {'MFCC','LPCDan_GlottalMFCCGLOAT','LPCDan_GlottalMFCCSTRAIGHT','LPCDan_GlottalMFCCLPCDan','LPCDan_GlottalMFCCvoicebox','LSP_GlottalMFCCGLOAT','LSP_GlottalMFCCSTRAIGHT','LSP_GlottalMFCCLPCDan','LSP_GlottalMFCCLPCvoicebox'};
% featureToUse = {'MFCC_GlottalMFCCLPCDan','LSP_GlottalMFCCLPCDan','MFCC_LSP','MFCC_LSP_GlottalMFCCLPCDan'};
% featureToUse = {'MFCC_LSP_GlottalMFCCLPCDan'};
modelToUse = {'HMM','GMM'};
% reduceType = {'','ppca','ppca','ppca','ppca','ppca'};
reduceType = {'','ppca','ppca','ppca'};
% reduceType={'ppca','ppca','ppca'};
% reduceDim={13,7,4};
reduceDim ={26,26,13,7};
% reduceDim ={52,78,52,26,13,7};

if ~exist(outfile,'file')
    fid = fopen(outfile,'w');
    fprintf(fid,'time, singer, numFold, usedModel, usedFeature, dimReduceType, featureDim, Accuracy, std, baseline, hypothesis, p value\n');
else
    fid = fopen(outfile,'a');
end

for i =1:length(featureToUse)
    for j=1:length(modelToUse)
        for k=1:length(reduceType)
            fprintf('cross fea %d/%d mod %d/%d red %d/%d\n',i,length(featureToUse),j,length(modelToUse),k,length(reduceType));
            opt = crossValidOptSet();
            opt.outputRoot = outputRoot;
            opt.usedFeature=featureToUse{i};
            opt.usedModel=modelToUse{j};
            opt.dimReduceOpt.type=reduceType{k};
            opt.dimReduceOpt.reducedDimNum=reduceDim{k};
            
            try
                B=load([opt.outputRoot filesep baseline '.mat'],'result');
                S=load([opt.outputRoot filesep 'Cross' num2str(opt.numFold) '-' opt.usedModel '-' opt.usedFeature '-' opt.dimReduceOpt.type num2str(opt.dimReduceOpt.reducedDimNum)  '.mat'],'result');
                baseAcc = arrayfun(@(X) sum(diag(X.confusion))/sum(X.confusion(:)),B.result.fold);
                acc = arrayfun(@(X) sum(diag(X.confusion))/sum(X.confusion(:)),S.result.fold);
                [h p] = ttest(baseAcc,acc);
                printTrainingCnd(fid, opt, S.result);
                fprintf(fid,', %.4f',S.result.avgAccuracy);
                fprintf(fid,', %.4f',S.result.stdAccuracy);
                fprintf(fid,', %s',baseline);
                fprintf(fid,', %d',h);
                fprintf(fid,', %.4f',p);
                fprintf(fid,'\n');
            catch exception
                disp(exception.message);
            end

        end
    end
end
fclose(fid);