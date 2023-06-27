function  output = remove_vertical_seam(input, energy_map)
    [height,width,channels] = size(input);
    output = zeros(height,width - 1,channels);
    opt_vertical_seam = find_opt_vertical_seam(energy_map);
    
    for i = 1:height
        output(i,1:opt_vertical_seam(i) - 1,:) = input(i,1:opt_vertical_seam(i) - 1,:); 
        output(i,opt_vertical_seam(i):end,:) = input(i,opt_vertical_seam(i) + 1:end,:);
    end
end