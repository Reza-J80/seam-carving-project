function opt_horizontal_seam = find_opt_horizontal_seam(energy_map,from)
    width = size(energy_map,2);

    opt_horizontal_seam  = zeros(width,1);
    last_column = energy_map(:,end);
    [~,idx] = sort(last_column);
    opt_horizontal_seam(end) = idx(1);
    
    for i = width-1:-1:1
        opt_horizontal_seam(i) = from(opt_horizontal_seam(i + 1),i + 1);
    end
end