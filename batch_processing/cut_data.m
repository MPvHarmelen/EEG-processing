%% cut_data: cut data, only works on 2D data
function cut_sections = cut_data(data, cut_col, window_before, window_after, ttl_cut_amp)
    [d1 d2 d3] = size(data);
    if d3 > 1
        error('This function only accepts 2D input','Dimension error');
    end
    % Squash the data by one time step to get the delta
    if d2 > 8
        data(1:end-1,9:end) = diff(data(:,9:end)); % jonas edit: replace TLL signal by differentiated signal
    end

    % Does this really need a for loop? Can't this be done better?
    cut_sections = [];
    for i = 1:length(data)
        if data(i, cut_col) >= ttl_cut_amp
            current_slice = data(i-window_before:i+window_after, :);
            if isempty(cut_sections) == 1
                cut_sections = current_slice;
            else
                cut_sections = cat(3, cut_sections, current_slice);
            end
        end
    end
end
