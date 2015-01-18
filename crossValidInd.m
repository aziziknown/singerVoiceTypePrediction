function CV=crossValidInd(y,K)
% y: ground truth label
% K: number of folds
% return CV as a structure describing the pick index of the data in each fold

 % compute stractified cross valid indexes
[junk ,categories] = canonizeLabels(y);
trainfolds = cell(K,1);
testfolds = cell(K,1);
cat2ind = java.util.Hashtable;
for i_cat = 1:length(categories)
	cat2ind.put(categories{i_cat},i_cat);
	cat_ind = find(strcmp(categories{i_cat},y));
	[trainfold, testfold] = Kfold(length(cat_ind), K, true);
	trainfolds = cellfun(@(X,Y) [X;cat_ind(Y)],trainfolds,trainfold','UniformOutput',false);
	testfolds = cellfun(@(X,Y) [X;cat_ind(Y)],testfolds,testfold','UniformOutput',false);
end
CV.categories = categories;
CV.cat2ind = cat2ind;
CV.trainfolds = trainfolds;
CV.testfolds = testfolds;
CV.numFold=K;