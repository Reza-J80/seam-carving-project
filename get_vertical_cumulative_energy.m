function [energy_map,from] = get_vertical_cumulative_energy(energy_map)
    [height,width] = size(energy_map);
    from = zeros(size(energy_map));
    
    for j = 2:height
        for i = 1:width
            value  = energy_map(j-1,i);
            from(j,i) = i;
            if i > 1 &&  energy_map(j-1,i-1) < value
                value = energy_map(j-1,i-1);
                from(j,i) = i - 1;
            end
            if i < width && energy_map(j-1,i+1) < value
                value = energy_map(j-1,i+1);
                from(j,i) = i + 1;
            end
            energy_map(j,i) = value + energy_map(j,i);
        end
    end
end