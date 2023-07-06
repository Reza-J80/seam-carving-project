function [energy_map, updated_saliency, updated_depth, updated_nearest_activity] = get_energy_map(image, saliency, depth, nearest_activity, update, direction, alpha, opt_seam)
    image = rgb2gray(image);
    [height,width] = size(depth);
    if update == 0
        updated_saliency = saliency;
        updated_depth = depth;
        updated_nearest_activity = nearest_activity;

    elseif strcmp(direction, 'vertical')
        updated_saliency = zeros(height, width - 1);
        updated_depth = zeros(height, width - 1);
        updated_nearest_activity = zeros(height, width - 1);
        h = fspecial('gaussian', [11,11], 11/6);
        h = h(6,:);
        for i = 1:height
            proper_h = h(max(7 - opt_seam(i),1):min(width + 6 - opt_seam(i),11)) * nearest_activity(i,opt_seam(i));
            nearest_activity(i,max(1,opt_seam(i) - 5):min(width,opt_seam(i) + 5)) = nearest_activity(i,max(1,opt_seam(i) - 5):min(width,opt_seam(i) + 5)) + proper_h;
            updated_saliency(i,1:opt_seam(i) - 1,:) = saliency(i,1:opt_seam(i) - 1,:); 
            updated_saliency(i,opt_seam(i):end,:) = saliency(i,opt_seam(i) + 1:end,:);
            updated_depth(i,1:opt_seam(i) - 1,:) = depth(i,1:opt_seam(i) - 1,:); 
            updated_depth(i,opt_seam(i):end,:) = depth(i,opt_seam(i) + 1:end,:);
            updated_nearest_activity(i,1:opt_seam(i) - 1,:) = nearest_activity(i,1:opt_seam(i) - 1,:); 
            updated_nearest_activity(i,opt_seam(i):end,:) = nearest_activity(i,opt_seam(i) + 1:end,:);
        end
    else
        updated_saliency = zeros(height - 1, width);
        updated_depth = zeros(height - 1, width);
        updated_nearest_activity = zeros(height - 1, width);
        h = fspecial('gaussian', [11,11], 11/6);
        h = h(:,6);
        for i = 1:width
            proper_h = h(max(7 - opt_seam(i),1):min(height + 6 - opt_seam(i),11)) * nearest_activity(opt_seam(i),i);
            nearest_activity(max(1,opt_seam(i) - 5):min(height,opt_seam(i) + 5),i) = nearest_activity(max(1,opt_seam(i) - 5):min(height,opt_seam(i) + 5),i) + proper_h;
            updated_saliency(1:opt_seam(i) - 1,i,:) = saliency(1:opt_seam(i) - 1,i,:); 
            updated_saliency(opt_seam(i):end,i,:) = saliency(opt_seam(i) + 1:end,i,:);
            updated_depth(1:opt_seam(i) - 1,i,:) = depth(1:opt_seam(i) - 1,i,:); 
            updated_depth(opt_seam(i):end,i,:) = depth(opt_seam(i) + 1:end,i,:);
            updated_nearest_activity(1:opt_seam(i) - 1,i,:) = nearest_activity(1:opt_seam(i) - 1,i,:); 
            updated_nearest_activity(opt_seam(i):end,i,:) = nearest_activity(opt_seam(i) + 1:end,i,:);
        end
    end
    updated_depth = updated_depth / max(max(updated_depth));
    updated_saliency = updated_saliency / max(max(updated_saliency));
    gradient = imgradient(image);
    gradient = gradient / max(max(gradient));
    canny = edge(image, 'canny');
    edges = 0.75 * gradient + 0.25 * canny;
    edges = edges / max(max(edges));
    energy_map = 0.25 * updated_depth + 2 * updated_saliency + 1.5 * edges + alpha * updated_nearest_activity;
end