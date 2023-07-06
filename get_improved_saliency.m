function improved_saliency = get_improved_saliency(depth, saliency)      
    thresh = multithresh(depth,3);
    thresh = sort(thresh);
    mask = depth >= thresh(3);
    mask = imdilate(mask, strel('disk',5));
    value = (sum(sum(mask .* saliency)) / sum(sum(mask)));
    result = mask .* value;
    for i = 2:-1:1
        mask = (thresh(i + 1) > depth) .* (depth >= thresh(i));
        mask = imdilate(mask, strel('disk',5));
        value = (sum(sum(mask .* saliency)) / sum(sum(mask)));
        result = max(result , mask .* value);
    end
    result = result / max(max(result));
    improved_saliency = (result  + 1 * saliency)/2;
end

