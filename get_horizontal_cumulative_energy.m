function [energy_map,from] = get_horizontal_cumulative_energy(energy_map)
    [height,width] = size(energy_map);
    from = zeros(size(energy_map));

    for i = 2:width
        for j = 1:height
            value  = energy_map(j,i-1);
            from(j,i) = j;
            if j > 1 &&  energy_map(j-1,i-1) < value
                value = energy_map(j-1,i-1);
                from(j,i) = j - 1;
            end
            if j < height && energy_map(j+1,i-1) < value
                value = energy_map(j+1,i-1);
                from(j,i) = j + 1;
            end
            energy_map(j,i) = value + energy_map(j,i);
        end
    end

end