function printConfusionMatrix(fid,confusion,categories,print_decimal)

if ~exist('print_decimal','var')
	print_decimal = '%d';
end
%	 print_format = ['%s' repmat(', %s',1,length(categories)-1) '\n'];
print_format = [repmat(', %s',1,length(categories)) '\n'];
fprintf(fid,print_format,categories{:});
% print_format = [print_decimal repmat([', ' print_decimal],1,length(categories)-1) '\n'];
% fprintf(fid,print_format,confusion');
print_format = ['%s' repmat([', ' print_decimal],1,length(categories)) '\n'];
for i=1:length(categories)
	fprintf(fid,print_format,categories{i},confusion(i,:));  
end
