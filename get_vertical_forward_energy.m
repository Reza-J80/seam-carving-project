function [M,from] = get_vertical_forward_energy(image,energy_map)
    image = rgb2gray(image);
    [height,width] = size(image);
    M = zeros(height,width);
    from = zeros(height,width);

    U = circshift(image,1,1);
    L = circshift(image,1,2);
    R = circshift(image,-1,2);
    cv = abs(R-L);
    cl = abs(U-L) + cv;
    cr = abs(U-R) + cv;
    M(1,:) = energy_map(1,:) + image(1,:) - image(2,:);
    for j = 2:height
        for i = 1:width
            M(j,i)  = M(j-1,i) + cv(j,i);
            from(j,i) = i;
            if i > 1 &&  M(j-1,i-1) + cl(j,i) < M(j,i)
                M(j,i) = M(j-1,i-1) + cl(j,i);
                from(j,i) = i - 1;
            end
            if i < width && M(j-1,i+1) + cr(j,i) < M(j,i)
                M(j,i) = M(j-1,i+1) + cr(j,i);
                from(j,i) = i + 1;
            end
            M(j,i) = energy_map(j,i) + M(j,i);
        end
    end
end