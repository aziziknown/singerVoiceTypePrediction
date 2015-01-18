function [confusion,confusionInPercent] = calculateConfusionMatrix(y,yhat,categories)
% calculate the confusion metrix
% y   : ground truth labels
% yhat: prediected labels
% categories: list of total categories in y
%	 res = cellfun(@(X) CV.cat_dict.get(X),[y yhat]);
res = [canonizeLabels(y,categories) canonizeLabels(yhat,categories)];
confusion = zeros(length(categories),length(categories));
for i_sample = 1:size(res,1)
	confusion(res(i_sample,1),res(i_sample,2)) = confusion(res(i_sample,1),res(i_sample,2)) + 1;
end
	
%	 confusion
%	 sum(confusion,2)
%	 100*confusion./repmat(sum(confusion,2),1,length(categories))
confusionInPercent = 100*confusion./repmat(sum(confusion,2),1,length(categories));
