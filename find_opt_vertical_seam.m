function opt_vertical_seam = find_opt_vertical_seam(energy_map,from)
    height = size(energy_map,1);

    opt_vertical_seam  = zeros(height,1);
    last_row = energy_map(end,:);
    [~,idx] = sort(last_row);
    opt_vertical_seam(end) = idx(1);
    
    for i = height-1:-1:1
        opt_vertical_seam(i) = from(i+1,opt_vertical_seam(i + 1));
    end
end