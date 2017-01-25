%% power_buffer: Save the power for later
function [later_data] = power_buffer(later_data, spectral_data, axis_values, fre_bands)
    % different frequency bands aren't the same size. Make later_data a cell array

    if ~isempty(later_data)
        new_size = size(later_data{1}, 2) + 1;
        for i=1:size(fre_bands, 1)
            start_index = find(axis_values>=fre_bands(i, 1), 1);
            end_index = find(axis_values>=fre_bands(i, 2), 1);
            later_data{i}(:, new_size) = spectral_data(start_index:end_index);
        end
    end
