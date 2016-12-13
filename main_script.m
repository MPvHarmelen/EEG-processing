input_dir = uigetdir('', 'Select folder to read from');
output_dir = uigetdir('', 'Select folder to save to');

% From http://stackoverflow.com/questions/2652630/how-to-get-all-files-under-a-specific-directory-in-matlab
% Get the data for the current directory
dirData = dir(input_dir);
% Find the index for directories
dirIndex = [dirData.isdir];
% Get a list of the files
fileList = {dirData(~dirIndex).name}';

input_files = cellfun(@(filename) fullfile(input_dir, filename), fileList, 'UniformOutput', false);
output_files = cellfun(@(filename) fullfile(output_dir, filename), fileList, 'UniformOutput', false);

cellfun(@batch_function, input_files, output_files, 'UniformOutput', false)
