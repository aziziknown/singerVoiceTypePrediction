function GlottalSource = extractGlottalSourceFromSignal(waveObj,type,opt)

if nargin<2 || isempty(type), type = 'GLOAT'; end
if nargin<3, vtpOpt=vtpOptSet;opt=vtpOpt.featureExtractOpt.Glottal; end

GlottalSource = feval(str2func(['extractSourceFromSignal' type]),waveObj,opt);
 