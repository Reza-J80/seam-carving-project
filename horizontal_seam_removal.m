function  output = horizontal_seam_removal(input, energy_map)
    cumulative_energy_map = energy_map;
    [height,width,channels] = size(input);
    output = zeros(height - 1,width,channels);
    
    for i = 2:width
        for j = 1:height
            if j == 1
                cumulative_energy_map(j,i) = cumulative_energy_map(j,i) + min([cumulative_energy_map(j,i-1),cumulative_energy_map(j+1,i-1)]);
            elseif j == height
                cumulative_energy_map(j,i) = cumulative_energy_map(j,i) + min([cumulative_energy_map(j-1,i-1),cumulative_energy_map(j,i-1)]);
            else
                cumulative_energy_map(j,i) = cumulative_energy_map(j,i) + min([cumulative_energy_map(j-1,i-1),cumulative_energy_map(j,i-1), cumulative_energy_map(j+1,i-1)]);
            end
            
        end
    end
    which_row  = zeros(width,1);
    last_column = cumulative_energy_map(:,end);
    [~,idx] = sort(last_column);
    which_row(end) = idx(1);
    
    for i = width-1:-1:1
        next_column = which_row(i+1);
        if next_column == 1
            [~,idx] = sort([cumulative_energy_map(1,i),cumulative_energy_map(2,i)]);
            which_row(i) = idx(1);
        elseif next_column == height
            [~,idx] = sort([cumulative_energy_map(height - 1,i),cumulative_energy_map(height,i)]);
            which_row(i) = height + idx(1) - 2;
        else
            [~,idx] = sort([cumulative_energy_map(next_column - 1,i),cumulative_energy_map(next_column,i),cumulative_energy_map(next_column + 1,i)]);
            which_row(i) = next_column + idx(1) - 2;
        end
    end

    for i = 1:width
        output(1:which_row(i) - 1,i,:) = input(1:which_row(i) - 1,i,:); 
        output(which_row(i):end,i,:) = input(which_row(i) + 1:end,i,:);
    end
end