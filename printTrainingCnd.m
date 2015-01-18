function printTrainingCnd(fid,opt,result)
%print training condition: opt, time, feature dim
	fprintf(fid,'%s',datestr(result.time));
	if isfield(result,'singer'), fprintf(fid,', %s',result.singer); else fprintf(fid,', ');end;
	if isfield(opt,'numFold'), fprintf(fid,', %d',opt.numFold); else fprintf(fid,', ');end;
	fprintf(fid,', %s',result.model{1}.name);
	fprintf(fid,', %s',opt.usedFeature);
	fprintf(fid,', %s',opt.dimReduceOpt.type);
	fprintf(fid,', %d',result.model{1}.featureDim);
	