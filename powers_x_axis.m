%% powers_x_axis: Get correct x-axis for power data
%% - powers         EEG power data
%% - sample_rate    the sample rate at which the original time EEG-data was measured
%% - x_axis         a 1-dimensional array where x_axis[k] is the frequency
%%                  that corresponds with the amplitude^2 of powers[k], e.g.
%%                  if powers[10] = 9 and x_axis[10] = 5, then the sine wave
%%                  with a frequency of 5 Hz had an amplitude of sqrt(9) = 3 in
%%                  the original EEG-data.
function [x_axis] = powers_x_axis(powers, sample_rate)
    n = size(powers, 1);
    % correct x-axis for sample rate?
    x_axis = (0:n-1) * (sample_rate / n / 2);
end
