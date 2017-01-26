%% eeg_power_processing: Process a time series of frequency data
function [number] = eeg_power_processing(data)
    number = median(max(data, 2));
