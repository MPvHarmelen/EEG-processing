% Column number to use for data cutting (mostly 10)
COL_N = 10;

% Number of time steps to include in each cut
WINDOW_BEFORE = 52;
WINDOW_AFTER = 1280;

% Amplitude used to cut TTL
TTL_CUT_AMP = 4;

% Filename
FILENAME = '/media/windows/Users/Martin/Documents/repos/EEG-processing/EEG recorder_2015v2.5/data/01-12-2016_13.31_v1_ppn4_meting1.mat.mat'

% Get filename
if isempty(FILENAME)
    [filename, pathname] = uigetfile({'*.mat';},'Select a 2D array');
    fprintf('filename: %s\n', filename);
    fprintf('pathname: %s\n', pathname);
    FILENAME = strcat(pathname, filename);
end


% Load data
load(FILENAME); % data is saved in the variable `data`
[a b c] = size(data);
if c>1
    errordlg('This function only accepts 2D input','Dimension error');
end

% Cut data
% Squash the data by one time step to get the delta
if size(data,2) > 8
    data(1:end-1,9:end) = diff(data(:,9:end)); % jonas edit: replace TLL signal by differentiated signal
end

% Does this really need a for loop? Can't this be done better?
cut_sections = [];
for i = 1:length(data)
    if data(i,COL_N) >= TTL_CUT_AMP
        current_slice = data(i-WINDOW_BEFORE:i+WINDOW_AFTER, :);
        if isempty(cut_sections) == 1
            cut_sections = current_slice;
        else
            cut_sections = cat(3, cut_sections, current_slice);
        end
    end
end

% Save data
% data must be saved in the variable `data`, so rename is necessary
data = cut_sections;
fprintf('%i\n', size(data));
uisave({'data'},'Name');
