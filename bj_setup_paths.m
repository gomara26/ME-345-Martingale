function bj_setup_paths()
% Ensure project subfolders are on the MATLAB path.
rootDir = fileparts(mfilename('fullpath'));
addpath(fullfile(rootDir, 'engine'));
addpath(fullfile(rootDir, 'rules'));
addpath(fullfile(rootDir, 'utils'));
addpath(fullfile(rootDir, 'apps'));
end
