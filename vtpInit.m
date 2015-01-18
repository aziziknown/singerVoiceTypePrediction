function vtpInit

%% Add necessary toolboxes to the search path
toolboxPath.root=''; %root path for your utility,machineLearning, sap toolboxes (by Roger jang), voicebox and pmtk toolbox
toolboxPath.remote = {'utility','machineLearning','sap','voicebox','pmtk3-1nov12'};
toolboxPath.remotePrefix = repmat({''},1,6); %if the toolboxes are put in the same root dir but different sub dir, you could specify this Prefix
for i=1:length(toolboxPath.remote)
% 	addpath([toolboxPath.root, toolboxPath.remote{i}]);
	addpath([toolboxPath.root, toolboxPath.remotePrefix{i} toolboxPath.remote{i}]);	
end
currDir = pwd; initPmtk3; cd(currDir);
toolboxPath.local = {'GLOAT','pmtk','sap'}; %path to the files of several toolboxes that has been modified by me.
for i=1:length(toolboxPath.local)
	addpath([pwd filesep toolboxPath.local{i}]);
end