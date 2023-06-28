function [output, energy_map] = seam_carving(path, name, new_height, new_width)
   image = im2double(imread([path, name, '\', name,'.png'])); 
   depth = im2double(imread([path, name, '\', name,'_DMap.png'])); 
   saliency = im2double(imread([path, name, '\', name,'_SMap.png']));

   height = size(image,1);
   width = size(image,2);
   energy_map = get_energy_map(image, saliency, depth, 0, 0, 0, 0);
   
   if height >= new_height
       while height > new_height
           opt_horizontal_seam = find_opt_horizontal_seam(energy_map);
           image = remove_horizontal_seam(image, opt_horizontal_seam);
           [energy_map, saliency, depth] = get_energy_map(image, saliency, depth, 1, 'horizontal', 1, opt_horizontal_seam);
           imshow(image,[]);
           height = height - 1;
       end
   else
       while height < new_height
           opt_horizontal_seam = find_opt_horizontal_seam(energy_map);
           image = add_horizontal_seam(image, opt_horizontal_seam);
           [energy_map, saliency, depth] = get_energy_map(image, saliency, depth, 1, 'horizontal', 0, opt_horizontal_seam);
           imshow(image,[]);
           height = height + 1;
       end
   end

   if width >= new_width
       while width > new_width
           opt_vertical_seam = find_opt_vertical_seam(energy_map);
           image = remove_vertical_seam(image, opt_vertical_seam);
           [energy_map, saliency, depth] = get_energy_map(image, saliency, depth, 1, 'vertical', 1, opt_vertical_seam);
           imshow(image,[]);
           width = width - 1;
       end
   else
       while width < new_width
           opt_vertical_seam = find_opt_vertical_seam(energy_map);
           image = add_vertical_seam(image, opt_vertical_seam);
           [energy_map, saliency, depth] = get_energy_map(image, saliency, depth, 1, 'vertical', 0, opt_vertical_seam);
           imshow(image,[]);
           width = width + 1;
       end
   end
   output = image;
end