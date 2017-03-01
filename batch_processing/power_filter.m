%% power_filter: Band pass filter for power data
%% - powers         EEG power data
%% - lower_bound    the lower bound of the band pass filter (in Hz)
%% - upper_bound    the upper bound of the band pass filter (in Hz)
%% - sample_rate    the sample rate at which the original time EEG-data was measured
%% - filtered       the powers of only the required frequencies
function [filtered] = power_filter(powers, lower_bound, upper_bound, sample_rate)
    x_axis = powers_x_axis(powers, sample_rate);
    filtered = powers(x_axis >= lower_bound & x_axis < upper_bound, :, :);
end
