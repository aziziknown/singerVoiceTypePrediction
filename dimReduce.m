function [Z,model] = dimReduce(X,opt,y)
% X: traingng features
% opt: from dimReduceOptSet()
% y: ground truth label
% if we use *lda or lda*, y is required, other one, no need to give y

if nargin<2 || isempty(opt), opt=dimReduceOptSet; end

model.type = opt.type;
Xmat = cat(2,X{:});

if size(Xmat,1)<opt.reducedDimNum
    msg = 'target # dim>origin # dim, plz specify lower target # dim';
    fprintf('%s\n',msg);
    error('MATLAB:dimReduce:targetDimExceed', msg);    
end

if ~isempty(strfind(opt.type,'lda'))
	y4lda = cellfun(@(X,Y) repmat({Y},size(X,2),1),X,y,'UniformOutput',false);
	y4lda = cat(1,y4lda{:});
	y4lda = canonizeLabels(y4lda);
end

% compute model/W
switch opt.type
	case 'ppca'
		if opt.autoDetectDim
			modelpca = ppcaFit(Xmat',size(Xmat,1));
			opt.reducedDimNum = sum(modelpca.evals>((10^-5)*sum(modelpca.evals(modelpca.evals>0))));
		end
		if size(Xmat,1)==opt.reducedDimNum
			msg = 'target # dim==origin # dim, ppca cannot reduce X''s # of dim to the same #!!';
			fprintf('%s\n',msg);
			error('MATLAB:dimReduce:ppcaSameDim', msg);
		end
		model.model = ppcaFit(Xmat',opt.reducedDimNum);
	case 'fisherlda'
		if opt.autoDetectDim
			model.W = fisherLdaFit(Xmat',y4lda);
		else
			model.W = fisherLdaFit(Xmat',y4lda,opt.reducedDimNum);
		end
	case 'pcajang'
		if opt.autoDetectDim
			[junk, model.W] = pca(Xmat);
		else
			[junk, model.W] = pca(Xmat,opt.reducedDimNum);
		end
	case 'ldajang'
		DS =struct('input',Xmat,'output',y4lda');
		if opt.autoDetectDim
			[junk, discrimVec] = lda(DS);
			opt.reducedDimNum = size(junk2.input,1);
		else
			[junk, discrimVec] = lda(DS,opt.reducedDimNum);
		end
		model.W = discrimVec(:,1:opt.reducedDimNum);
	case 'fldajang'	
		if opt.autoDetectDim
			[junk, discrimVec] = flda(Xmat',y4lda);
			opt.reducedDimNum = size(junk.input,1);
		else
			[junk, discrimVec] = flda(Xmat',y4lda,opt.reducedDimNum);
		end
		model.W = discrimVec(:,1:opt.reducedDimNum);
end

Z=dimReduceOnData(X,model);
model.reducedDimNum = size(Z{1},1);

