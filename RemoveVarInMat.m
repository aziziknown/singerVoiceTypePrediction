% root_dir = 'D:\azz\music_audio_research\datasets\phonation_mode_dataset\2_1_trimmed\cut_mode\same_number_files_new\model\mode\';
% target_dir = 'D:\azz\music_audio_research\datasets\phonation_mode_dataset\2_1_trimmed\cut_mode\same_number_files_new\model\';
% root_dir = 'D:\Dropbox\Digimax\sing_voice\recordings\mix_littlesunshine_starappleho\model\mode\';
% target_dir = 'D:\Dropbox\Digimax\sing_voice\recordings\mix_littlesunshine_starappleho\model\';
% root_dir = 'D:\Dropbox\Digimax\sing_voice\recordings\bluecy\model\mode\';
% root_dir = 'D:\Dropbox\Digimax\sing_voice\recordings\little_sunshine\model\mode\';
% root_dir = 'D:\Dropbox\Digimax\sing_voice\recordings\starappleho\model\mode\';
% root_dir = 'C:\Users\known\Documents\Dropbox\Digimax\sing_voice\recordings\little_sunshine\three_notes\model\mode\';
root_dirs = {'C:\Users\known\Documents\Dropbox\Digimax\sing_voice\recordings\mix\model\mode\',...
	'C:\Users\known\Documents\Dropbox\Digimax\sing_voice\recordings\cross\model\mode\',...
	'C:\Users\known\Documents\Dropbox\Digimax\sing_voice\recordings\mix_error\model\mode\'};
	
for i=1:length(root_dirs)
	root_dir = root_dirs{i};
target_dir = [root_dir '..\'];

F = dir([root_dir '*.mat']);
[tmp,idx] = sort([F.datenum]);
for i_file = 1:size(F,1)
	if ~strcmp(F(idx(i_file)).name,'HMM5-1-feature_MFCC-26.mat')
		modified=false;
		matfile = [root_dir F(idx(i_file)).name];
		S = load(matfile);
		if isfield(S,'X_all') 
			S = rmfield(S,'X_all');		
			modified=true;
		end
		if isfield(S,'X') 
			S = rmfield(S,'X');
			modified=true;
		end
%		 S = rmfield(S,'y');
		if modified
			save([target_dir F(idx(i_file)).name],'-struct','S');
		end
		pause(0.2)
	end
end
end