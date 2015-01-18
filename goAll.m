vtpInit;

% % goFeatureExtract;
% goTraining;%self train
% goTesting; %self test
% goCV;%cross validation

% featureToUse = {'MFCC','LPCDan','LSP','GlottalMFCCGLOAT','GlottalMFCCSTRAIGHT','GlottalMFCCLPCDan','GlottalMFCCLPCvoicebox'};
% featureToUse = {'MFCC','LPCDan_GlottalMFCCGLOAT','LPCDan_GlottalMFCCSTRAIGHT','LPCDan_GlottalMFCCLPCDan','LPCDan_GlottalMFCCvoicebox','LSP_GlottalMFCCGLOAT','LSP_GlottalMFCCSTRAIGHT','LSP_GlottalMFCCLPCDan','LSP_GlottalMFCCLPCvoicebox'};
featureToUse = {'MFCC_GlottalMFCCLPCDan','LSP_GlottalMFCCLPCDan','MFCC_LSP','MFCC_LSP_GlottalMFCCLPCDan'};
% featureToUse = {'MFCC_LSP_GlottalMFCCLPCDan'};
modelToUse = {'HMM','GMM'};
reduceType = {'','ppca','ppca','ppca','ppca','ppca'};
% reduceType = {'','ppca','ppca','ppca'};
% reduceType={'ppca','ppca','ppca'};
% reduceDim={13,7,4};
% reduceDim ={[],26,13,7};
reduceDim ={[],78,52,26,13,7};
for i =1:length(featureToUse)
    for j=1:length(modelToUse)
        for k=1:length(reduceType)
            fprintf('cross fea %d/%d mod %d/%d red %d/%d\n',i,length(featureToUse),j,length(modelToUse),k,length(reduceType));
            opt = crossValidOptSet();
            opt.usedFeature=featureToUse{i};
            opt.usedModel=modelToUse{j};
            opt.dimReduceOpt.type=reduceType{k};
            opt.dimReduceOpt.reducedDimNum=reduceDim{k};
            goCV();
        end
    end
end
