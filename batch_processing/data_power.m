%% data_power: convert time EEG-data to power data
%% - data       time EEG-data to convert
%% - channels   channels to calculate the power of
%% - powers     the calculated power data
function powers = data_power(data, channels)
    % http://www.wikiwand.com/en/Fast_Fourier_transform#/Definition_and_speed
    % says "The best known use of the Cooley–Tukey algorithm is to divide the
    % transform into two pieces of size N/2 at each step, and is therefore
    % limited to power-of-two sizes"
    % Because I don't really know why this is still important, I'm just not
    % going to touch it.

    % pad the data with 0s to make it a power of two >> why? no one knows >>
    % probably because you can then remember what the frequencies were.

    % do the transform? >> find fft documentation
    % divide by n to get original amplitude
    n = pow2(nextpow2(size(data, 1)));
    dfty1 = fft(data(:, channels, :), n);

    % Normalise data (complex > real & fix amplitude)
    % WHY DEVIDE BY n?!?! >> because then unit stays the same? Or something?
    % absolute value squared divided by length of the data
    powers = dfty1 .* conj(dfty1) / n;
    % The result is always mirror symmetric (or almost)
    powers = powers(1:n/2, :, :);
end
