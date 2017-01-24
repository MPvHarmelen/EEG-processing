%% power_save: Calculate some resulting value from the data and save it to a file
function [later_data] = power_save(powers, filenames, delay)
    % Get time since last output
    global last_output_time;
    new_output_time = clock;
    duration = etime(last_output_time, new_output_time);
    last_output_time = new_output_time;

    if duration >= delay
        for i=1:size(powers, 3)
            maximum = max(max(powers(:, :, i)));
            %the_very_average = mean(powers(:));
            file = fopen(filenames{i}, 'w');
            fprintf(file, '%.50f\n', maximum);
            fclose(file);
        end
        later_data = [];
    else
        later_data = powers;
    end
