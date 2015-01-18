function opt=dimReduceOptSet

% opt.type='ppca'; % options: ppca, pcajang, ldajang, fldajang, fisherlda
opt.type='';   %'' for not use dimension reduction
opt.autoDetectDim =false; %automatic determine #of dim to reduce 
% opt.autoDetectDim =true; %automatic determine #of dim to reduce 
opt.reducedDimNum =[]; % target dim number(reduced dim number)
% opt.reducedDimNum =26; % target dim number(reduced dim number)
