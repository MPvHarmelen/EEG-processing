%% powers_x_axis: Get correct x-axis for power data
function [x_axis] = powers_x_axis(powers, sample_rate)
    n = size(powers, 1);
    % correct x-axis for sample rate?
    x_axis = (0:n-1) * (sample_rate / n / 2);
end
