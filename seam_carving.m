function [output, energy_map, starting_energy] = seam_carving(path, name, new_height, new_width)
    image = im2double(imread([path, name, '\', name,'.png']));
    depth = im2double(imread([path, name, '\', name,'_DMap.png']));
    saliency = im2double(imread([path, name, '\', name,'_SMap.png']));
    nearest_activity = ones(size(depth)) * 0.5;
    
    height = size(image,1);
    width = size(image,2);
    depth = imclose(depth, strel('disk',15));
    saliency = get_improved_saliency(depth, saliency);
    
    energy_map = get_energy_map(image, saliency, depth, nearest_activity, 0, 0, 2, 0);
    starting_energy = energy_map;
    
    if height > new_height
        alpha = max(sum(depth,1)) / height;
        alpha = (alpha ^ 5 * 100 - 0.8) ^ 2;
        while height ~= new_height
            [energy_map,from] = get_horizontal_forward_energy(image,energy_map);
            opt_horizontal_seam = find_opt_horizontal_seam(energy_map,from);
            image = remove_horizontal_seam(image, opt_horizontal_seam);
            [energy_map, saliency, depth, nearest_activity] = get_energy_map(image, saliency, depth, nearest_activity, 1, 'horizontal', alpha, opt_horizontal_seam);
            height = height - 1;
        end
    else
        alpha = max(sum(depth,2)) / width;
        alpha = alpha ^ 5 * 100;
        while width ~= new_width
            [energy_map,from] = get_vertical_forward_energy(image,energy_map);
            opt_vertical_seam = find_opt_vertical_seam(energy_map,from);
            image = remove_vertical_seam(image, opt_vertical_seam);
            [energy_map, saliency, depth, nearest_activity] = get_energy_map(image, saliency, depth, nearest_activity, 1, 'vertical', alpha, opt_vertical_seam);
            width = width - 1;
        end
    end
    output = image;
end