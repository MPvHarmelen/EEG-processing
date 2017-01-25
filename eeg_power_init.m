%% eeg_power_init: Initialise cell array of matrices and things
function [later_data] = eeg_power_init(fre_bands)
    later_data = cell(size(fre_bands, 1), 1);
