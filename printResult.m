function printResult(opt,result)

if isfield(opt,'printResultOrNot') && opt.printResultOrNot==true
	%print accuracies
	if ~exist(opt.outFileName.resultAccuracy,'file')
		fid = fopen(opt.outFileName.resultAccuracy,'w');
		fprintf(fid,'time, singer, numFold, usedModel, usedFeature, dimReduceType, featureDim, Accuracy, std\n');
	else
		fid = fopen(opt.outFileName.resultAccuracy,'a');
	end
	printTrainingCnd(fid, opt, result);
	fprintf(fid,',%.4f',result.avgAccuracy);
    fprintf(fid,',%.4f',result.stdAccuracy);
	fprintf(fid,'\n');
	fclose(fid);

	%print confusion matrix
	fid = fopen(opt.outFileName.resultConfusion,'a');
	printTrainingCnd(fid, opt, result)
	fprintf(fid,'\n');	
	printConfusionMatrix(fid,result.avgConfusionInPercent,result.categories,'%.4f');	
	fprintf(fid,'\n');
	fclose(fid);
end