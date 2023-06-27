function opt_vertical_seam = find_opt_vertical_seam(energy_map)
    [height,width] = size(energy_map);
    
    for i = 2:height
        for j = 1:width
            if j == 1
                energy_map(i,j) = energy_map(i,j) + min([energy_map(i-1,j),energy_map(i-1,j+1)]);
            elseif j == width
                energy_map(i,j) = energy_map(i,j) + min([energy_map(i-1,j - 1),energy_map(i-1,j)]);
            else
                energy_map(i,j) = energy_map(i,j) + min([energy_map(i-1,j - 1),energy_map(i-1,j), energy_map(i-1,j + 1)]);
            end
            
        end
    end
    opt_vertical_seam  = zeros(height,1);
    last_row = energy_map(end,:);
    [~,idx] = sort(last_row);
    opt_vertical_seam(end) = idx(1);
    
    for i = height-1:-1:1
        next_row = opt_vertical_seam(i+1);
        if next_row == 1
            [~,idx] = sort([energy_map(i,1),energy_map(i,2)]);
            opt_vertical_seam(i) = idx(1);
        elseif next_row == width
            [~,idx] = sort([energy_map(i,width - 1),energy_map(i,width)]);
            opt_vertical_seam(i) = width + idx(1) - 2;
        else
            [~,idx] = sort([energy_map(i,next_row - 1),energy_map(i,next_row),energy_map(i,next_row + 1)]);
            opt_vertical_seam(i) = next_row + idx(1) - 2;
        end
    end
end