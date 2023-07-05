function [energy_map, updated_saliency, updated_depth] = get_energy_map(image, saliency, depth, update, direction, opt_seam)    
    [height,width] = size(depth);
    if update == 0
        updated_saliency = saliency;
        updated_depth = depth;
    elseif strcmp(direction, 'vertical')
        updated_saliency = zeros(height, width - 1);
        updated_depth = zeros(height, width - 1);
        for i = 1:height
            updated_saliency(i,1:opt_seam(i) - 1,:) = saliency(i,1:opt_seam(i) - 1,:); 
            updated_saliency(i,opt_seam(i):end,:) = saliency(i,opt_seam(i) + 1:end,:);
            updated_depth(i,1:opt_seam(i) - 1,:) = depth(i,1:opt_seam(i) - 1,:); 
            updated_depth(i,opt_seam(i):end,:) = depth(i,opt_seam(i) + 1:end,:);
        end

    else
        updated_saliency = zeros(height - 1, width);
        updated_depth = zeros(height - 1, width);
        for i = 1:width
            updated_saliency(1:opt_seam(i) - 1,i,:) = saliency(1:opt_seam(i) - 1,i,:); 
            updated_saliency(opt_seam(i):end,i,:) = saliency(opt_seam(i) + 1:end,i,:);
            updated_depth(1:opt_seam(i) - 1,i,:) = depth(1:opt_seam(i) - 1,i,:); 
            updated_depth(opt_seam(i):end,i,:) = depth(opt_seam(i) + 1:end,i,:);
        end
    end
    updated_depth = updated_depth / max(max(updated_depth));
    updated_saliency = imfilter(updated_saliency, (ones(15,15) + fspecial('gaussian', [15,15], 5/2)));
    updated_saliency = updated_saliency / max(max(updated_saliency));
    image = rgb2gray(image);
    gradient = imgradient(image);
    gradient = gradient / max(max(gradient));
    canny = edge(image, 'canny');
    edges = 0.5 * gradient + 0.5 * canny;
    energy_map = 0.34 * updated_depth + 0.33 * updated_saliency + 0.33 * edges;

end