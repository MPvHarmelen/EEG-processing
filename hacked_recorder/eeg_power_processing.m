%% eeg_power_processing: Process a time series of frequency data
function [number] = eeg_power_processing(data)
    number = max(mean(data, 2));
