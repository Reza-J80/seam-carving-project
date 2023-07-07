function improved_saliency = get_improved_saliency(depth, saliency)
    values = zeros(3,1);
    masks = zeros(3,size(depth,1),size(depth,2));
    improved_saliency = zeros(size(depth));

    thresh = multithresh(depth,3);
    thresh = sort(thresh);
    mask = depth >= thresh(3);
    mask = imopen(mask, strel('disk',5));
    values(3) = thresh(3) * (sum(sum(mask .* saliency)) / sum(sum(mask)));
    masks(3,:,:) = mask;
    for i = 2:-1:1
        mask = (thresh(i + 1) > depth) .* (depth >= thresh(i));
        masks(i,:,:) = imopen(mask, strel('disk',5));
        values(i) = thresh(i) * (sum(sum(mask .* saliency)) / sum(sum(mask)));
    end
    
    [values,idx] = sort(values);
    values = values .^ 2;

    masks = masks(idx,:,:);
    mask1 = reshape(masks(1,:,:),size(depth));
    mask2 = reshape(masks(2,:,:),size(depth));
    mask3 = reshape(masks(3,:,:),size(depth));

    mask1 = imopen(mask1,strel('disk',25));
    mask2 = imopen(mask2,strel('disk',20));
    mask3 = imdilate(mask3,strel('disk',10));

    improved_saliency = max(improved_saliency , mask1 * values(1));
    improved_saliency = max(improved_saliency , mask2 * values(2));
    improved_saliency = max(improved_saliency , mask3 * values(3));

    improved_saliency = improved_saliency / max(max(improved_saliency));
    saliency = saliency + 2 * imfilter(saliency, fspecial("gaussian",[11,11],11/6));
    improved_saliency = (3 * improved_saliency  + saliency)/4;
end

