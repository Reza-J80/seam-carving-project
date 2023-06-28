function [energy_map, updated_saliency, updated_depth] = get_energy_map(image, saliency, depth, update, direction, remove, opt_seam)
    image = rgb2gray(image);
    [height,width] = size(depth);
    if update == 0
        edges = edge(image, 'canny');
        energy_map = depth + saliency + edges;
        energy_map = imfilter(energy_map, fspecial('gaussian', [3,3], 1/2));
    elseif strcmp(direction, 'vertical')
        if remove
            updated_saliency = zeros(height, width - 1);
            updated_depth = zeros(height, width - 1);
            for i = 1:height
                updated_saliency(i,1:opt_seam(i) - 1,:) = saliency(i,1:opt_seam(i) - 1,:); 
                updated_saliency(i,opt_seam(i):end,:) = saliency(i,opt_seam(i) + 1:end,:);
                updated_depth(i,1:opt_seam(i) - 1,:) = depth(i,1:opt_seam(i) - 1,:); 
                updated_depth(i,opt_seam(i):end,:) = depth(i,opt_seam(i) + 1:end,:);
            end
        else
            updated_saliency = zeros(height, width + 1);
            updated_depth = zeros(height, width + 1);
            for i = 1:height
                if opt_seam(i) == width
                    opt_seam(i) = width - 1;
                end
                updated_saliency(i,1:opt_seam(i),:) = saliency(i,1:opt_seam(i),:); 
                updated_saliency(i,opt_seam(i) + 1,:) = (saliency(i,opt_seam(i),:) + saliency(i,opt_seam(i) + 1,:)) / 2; 
                updated_saliency(i,opt_seam(i) + 2:end,:) = saliency(i,opt_seam(i) + 1:end,:);
                updated_depth(i,1:opt_seam(i),:) = depth(i,1:opt_seam(i),:); 
                updated_depth(i,opt_seam(i) + 1,:) = (depth(i,opt_seam(i),:) + depth(i,opt_seam(i) + 1,:)) / 2; 
                updated_depth(i,opt_seam(i) + 2:end,:) = depth(i,opt_seam(i) + 1:end,:);
            end

        end
        edges = edge(image, 'canny');
        energy_map = updated_depth + updated_saliency + edges;
        energy_map = imfilter(energy_map, fspecial('gaussian', [3,3], 1/2));
    else
        if remove
            updated_saliency = zeros(height - 1, width);
            updated_depth = zeros(height - 1, width);
            for i = 1:width
                updated_saliency(1:opt_seam(i) - 1,i,:) = saliency(1:opt_seam(i) - 1,i,:); 
                updated_saliency(opt_seam(i):end,i,:) = saliency(opt_seam(i) + 1:end,i,:);
                updated_depth(1:opt_seam(i) - 1,i,:) = depth(1:opt_seam(i) - 1,i,:); 
                updated_depth(opt_seam(i):end,i,:) = depth(opt_seam(i) + 1:end,i,:);
            end

        else
            updated_saliency = zeros(height + 1, width);
            updated_depth = zeros(height + 1, width);
            for i = 1:width
                if opt_seam(i) == height
                    opt_seam(i) = height - 1;
                end
                updated_saliency(1:opt_seam(i),i,:) = saliency(1:opt_seam(i),i,:);
                updated_saliency(opt_seam(i) + 1,i,:) = (saliency(opt_seam(i),i,:) + saliency(opt_seam(i) + 1,i,:)) / 2; 
                updated_saliency(opt_seam(i) + 2:end,i,:) = saliency(opt_seam(i) + 1:end,i,:);
                updated_depth(1:opt_seam(i),i,:) = depth(1:opt_seam(i),i,:);
                updated_depth(opt_seam(i) + 1,i,:) = (depth(opt_seam(i),i,:) + depth(opt_seam(i) + 1,i,:)) / 2; 
                updated_depth(opt_seam(i) + 2:end,i,:) = depth(opt_seam(i) + 1:end,i,:);
            end
        end
        edges = edge(image, 'canny');
        energy_map = updated_depth + updated_saliency + edges;
        energy_map = imfilter(energy_map, fspecial('gaussian', [3,3], 1/2));
    end

end