%% batch_function: A function to execute on all data
function batch_function(input_file, output_file)
    % ------- Choices
    % Channels to use for Fourier analysis
    CHANNELS = [1:6];

    % Number of time steps to include in each cut
    WINDOW_BEFORE = 52;
    WINDOW_AFTER = 1280;


    % ------- Information about the data
    SAMPLE_RATE = 256;
    % Column number to use for data cutting (mostly 10)
    CUT_COL = 10;

    % Amplitude used to cut TTL
    TTL_CUT_AMP = 4;


    % ------- Code
    load(input_file);

    % Cut data
    % data must be saved in the variable `data`, so overwrite is necessary
    % data = cut_data(data, CUT_COL, WINDOW_BEFORE, WINDOW_AFTER, TTL_CUT_AMP);

    % Calculate power of data
    % data must be saved in the variable `power`, so using keyword is necessary
    power = data_power(data, CHANNELS);

    save(output_file, 'power');
    fprintf('Saved output to %s\n', output_file);
end
