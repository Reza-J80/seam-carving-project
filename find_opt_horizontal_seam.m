function opt_horizontal_seam = find_opt_horizontal_seam(energy_map)
    [height,width] = size(energy_map);

    for i = 2:width
        for j = 1:height
            if j == 1
                energy_map(j,i) = energy_map(j,i) + min([energy_map(j,i-1),energy_map(j+1,i-1)]);
            elseif j == height
                energy_map(j,i) = energy_map(j,i) + min([energy_map(j-1,i-1),energy_map(j,i-1)]);
            else
                energy_map(j,i) = energy_map(j,i) + min([energy_map(j-1,i-1),energy_map(j,i-1), energy_map(j+1,i-1)]);
            end
            
        end
    end
    opt_horizontal_seam  = zeros(width,1);
    last_column = energy_map(:,end);
    [~,idx] = sort(last_column);
    opt_horizontal_seam(end) = idx(1);
    
    for i = width-1:-1:1
        next_column = opt_horizontal_seam(i+1);
        if next_column == 1
            [~,idx] = sort([energy_map(1,i),energy_map(2,i)]);
            opt_horizontal_seam(i) = idx(1);
        elseif next_column == height
            [~,idx] = sort([energy_map(height - 1,i),energy_map(height,i)]);
            opt_horizontal_seam(i) = height + idx(1) - 2;
        else
            [~,idx] = sort([energy_map(next_column - 1,i),energy_map(next_column,i),energy_map(next_column + 1,i)]);
            opt_horizontal_seam(i) = next_column + idx(1) - 2;
        end
    end
end