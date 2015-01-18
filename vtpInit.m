function vtpInit

%% Add necessary toolboxes to the search path
% toolboxPath.root='d:\users\jang\matlab\toolbox\';
toolboxPath.root='D:\azz\music_audio_research\toolbox\';
% toolboxPath.root='C:\azz\Programmes\matlab_tools\';
toolboxPath.remote = {'utility','machineLearning','sap','TandemSTRAIGHTmonolithicPackage002Test','voicebox','pmtk3-1nov12'};
toolboxPath.remotePrefix = {'jang\','jang\','jang\','07_HumanVoice\general\STRAIGHT\','07_HumanVoice\general\','00_Machine_Learning\'};
% toolboxPath.remotePrefix = repmat({''},1,6);
for i=1:length(toolboxPath.remote)
% 	addpath([toolboxPath.root, toolboxPath.remote{i}]);
	addpath([toolboxPath.root, toolboxPath.remotePrefix{i} toolboxPath.remote{i}]);	
end
currDir = pwd; initPmtk3; cd(currDir);
toolboxPath.local = {'GLOAT','pmtk','sap','STRAIGHT'};
for i=1:length(toolboxPath.local)
	addpath([pwd filesep toolboxPath.local{i}]);
end