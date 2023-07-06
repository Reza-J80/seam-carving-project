function [output, energy_map] = seam_carving(path, name, new_height, new_width)
    image = im2double(imread([path, name, '\', name,'.png']));
    depth = im2double(imread([path, name, '\', name,'_DMap.png'])); 
    saliency = im2double(imread([path, name, '\', name,'_SMap.png']));
    
    height = size(image,1);
    width = size(image,2);
    saliency = get_improved_saliency(depth, saliency);
    
    energy_map = get_energy_map(image, saliency, depth, 0, 0, 0);
    
    while height >= new_height
        [energy_map,from] = get_horizontal_cumulative_energy(image,energy_map);
        opt_horizontal_seam = find_opt_horizontal_seam(energy_map,from);
        image = remove_horizontal_seam(image, opt_horizontal_seam);
        [energy_map, saliency, depth] = get_energy_map(image, saliency, depth, 1, 'horizontal', opt_horizontal_seam);
        height = height - 1;
    end

    while width >= new_width
        [energy_map,from] = get_vertical_cumulative_energy(image,energy_map);
        opt_vertical_seam = find_opt_vertical_seam(energy_map,from);
        image = remove_vertical_seam(image, opt_vertical_seam);
        [energy_map, saliency, depth] = get_energy_map(image, saliency, depth, 1, 'vertical', opt_vertical_seam);
        width = width - 1;
    end

   output = image;
end