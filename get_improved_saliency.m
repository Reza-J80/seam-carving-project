function improved_saliency = get_improved_saliency(depth, saliency)      
    thresh = multithresh(depth,3);
    thresh = sort(thresh);
    mask = depth >= thresh(3);
    mask = imopen(mask, strel('disk',5));
    max_value = max(max(mask .* saliency));
    value = thresh(2) * (sum(sum(mask .* saliency)) / sum(sum(mask))) * max_value;
    result = mask .* value;
    for i = 2:-1:1
        mask = (thresh(i + 1) > depth) .* (depth >= thresh(i));
        mask = imopen(mask, strel('disk',5));
        max_value = max(max(mask .* saliency));
        value = thresh(i) * (sum(sum(mask .* saliency)) / sum(sum(mask))) * max_value;
        result = max(result , mask .* value);
    end
    result = result / max(max(result));
    improved_saliency = (4 * result  + saliency)/5;
end

