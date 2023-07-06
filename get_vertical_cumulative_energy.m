function [energy_map,from] = get_vertical_cumulative_energy(image,energy_map)
    image = rgb2gray(image);
    [height,width] = size(image);
    from = zeros(size(image));
    
    for j = 2:height
        for i = 1:width
            value  = energy_map(j,i);
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