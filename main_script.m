input_dir = uigetdir('', 'Select a folder to read from');
if ~input_dir
    error('Please select a folder to read from');
end
output_dir = uigetdir('', 'Select a folder to save to');
if ~output_dir
    error('Please select a folder to save to');
end

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
