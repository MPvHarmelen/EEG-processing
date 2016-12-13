%% batch_function: A function to execute on all data
function batch_function(input_file, output_file)
    % ------- Choices
    % Variable to save
    SAVE_VAR = 'power';

    % Channels to use for Fourier analysis
    CHANNELS = [1:6];

    % Number of time steps to include in each cut
    WINDOW_BEFORE = 52;
    WINDOW_AFTER = 1280;

    % Band pass filter details (in Hz)
    LOWER_BOUND = 4;
    UPPER_BOUND = 32;

    % ------- Information about the data
    % Sample rate used when data was measured
    SAMPLE_RATE = 256;

    % Column number to use for data cutting (mostly 10)
    CUT_COL = 10;

    % Amplitude used to cut TTL
    TTL_CUT_AMP = 4;


    % ------- Code
    % Force f*cking use of built in names :(
    power = [];

    % Load data
    fprintf('Loading %s\n', input_file);
    load(input_file);
    s = [0 0 0];
    if exist('data', 'var')
        disp 'File contained the variable: data'
        s = size(data);
    elseif ~isempty('power')
        disp 'File contained the variable: power'
        s = size(power);
    else
        error('No data found');
    end
    fprintf('Input size: %i %i %i\n', s);

    % Cut data
    % data must be saved in the variable `data`, so overwrite is necessary
    % data = cut_data(data, CUT_COL, WINDOW_BEFORE, WINDOW_AFTER, TTL_CUT_AMP);
    % fprintf('Size after cutting: %i %i %i\n', size(data));

    % Calculate power of data
    % data must be saved in the variable `power`, so using built in name is necessary
    % power = data_power(data, CHANNELS);
    % fprintf('Size after power: %i %i %i\n', size(power));

    % Band pass filter power data
    % power = power_filter(power, LOWER_BOUND, UPPER_BOUND, SAMPLE_RATE);
    % fprintf('Size after power filter: %i %i %i\n', size(power));


    save(output_file, SAVE_VAR);
    fprintf('Saved %s to %s\n\n', SAVE_VAR, output_file);
end
