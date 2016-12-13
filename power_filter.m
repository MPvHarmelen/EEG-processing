%% power_filter: Band pass filter for power data
function [filtered] = power_filter(powers, lower_bound, upper_bound, sample_rate)
    x_axis = powers_x_axis(powers, sample_rate);
    filtered = powers(x_axis >= lower_bound & x_axis < upper_bound, :, :);
end
