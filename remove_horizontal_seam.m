function  output = remove_horizontal_seam(input, energy_map)
    [height,width,channels] = size(input);
    output = zeros(height - 1,width,channels);
    opt_horizontal_seam = find_opt_horizontal_seam(energy_map);

    for i = 1:width
        output(1:opt_horizontal_seam(i) - 1,i,:) = input(1:opt_horizontal_seam(i) - 1,i,:); 
        output(opt_horizontal_seam(i):end,i,:) = input(opt_horizontal_seam(i) + 1:end,i,:);
    end
end