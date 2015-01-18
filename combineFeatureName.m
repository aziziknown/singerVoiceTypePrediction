function comninedList = combineFeatureName(featureList,k)
% input featureList and k
% output a cell array contains all possible combination of k
% e.g. featureList={'A','B','C'}, k=2;
%      combinedList={ 'A_B','A_C','B_C'}
C=combnk(featureList,k);
comninedList = cell(1,size(C,1));
for i=1:size(C,1)
	comninedList{i} = sprintf('_%s',C{i,:});
	comninedList{i} = comninedList{i}(2:end);
end
	