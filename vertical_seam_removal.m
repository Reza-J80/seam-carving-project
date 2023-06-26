function  output = vertical_seam_removal(input, energy_map)
    cumulative_energy_map = energy_map;
    [height,width,channels] = size(input);
    output = zeros(height,width - 1,channels);
    
    for i = 2:height
        for j = 1:width
            if j == 1
                cumulative_energy_map(i,j) = cumulative_energy_map(i,j) + min([cumulative_energy_map(i-1,j),cumulative_energy_map(i-1,j+1)]);
            elseif j == width
                cumulative_energy_map(i,j) = cumulative_energy_map(i,j) + min([cumulative_energy_map(i-1,j - 1),cumulative_energy_map(i-1,j)]);
            else
                cumulative_energy_map(i,j) = cumulative_energy_map(i,j) + min([cumulative_energy_map(i-1,j - 1),cumulative_energy_map(i-1,j), cumulative_energy_map(i-1,j + 1)]);
            end
            
        end
    end
    which_column  = zeros(height,1);
    last_row = cumulative_energy_map(end,:);
    [~,idx] = sort(last_row);
    which_column(end) = idx(1);
    
    for i = height-1:-1:1
        next_row = which_column(i+1);
        if next_row == 1
            [~,idx] = sort([cumulative_energy_map(i,1),cumulative_energy_map(i,2)]);
            which_column(i) = idx(1);
        elseif next_row == width
            [~,idx] = sort([cumulative_energy_map(i,width - 1),cumulative_energy_map(i,width)]);
            which_column(i) = width + idx(1) - 2;
        else
            [~,idx] = sort([cumulative_energy_map(i,next_row - 1),cumulative_energy_map(i,next_row),cumulative_energy_map(i,next_row + 1)]);
            which_column(i) = next_row + idx(1) - 2;
        end
    end
    
    for i = 1:height
        output(i,1:which_column(i) - 1,:) = input(i,1:which_column(i) - 1,:); 
        output(i,which_column(i):end,:) = input(i,which_column(i) + 1:end,:);
    end
end