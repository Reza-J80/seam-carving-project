function [M,from] = get_horizontal_forward_energy(image, energy_map)
    image = rgb2gray(image);
    [height,width] = size(image);
    M = zeros(height,width);
    from = zeros(height,width);

    U = circshift(image,1,2);
    L = circshift(image,-1,1);
    R = circshift(image,1,1);
    cv = abs(L-R);
    cl = abs(U-L) + cv;
    cr = abs(U-R) + cv;
    M(:,1) = energy_map(:,1) + image(:,1) - image(:,1);
    for i = 2:width
        for j = 1:height
            M(j,i)  = M(j,i-1) + cv(j,i);
            from(j,i) = j;
            if j > 1 &&  M(j-1,i-1) + cr(j,i) < M(j,i)
                M(j,i) = M(j-1,i-1) + cr(j,i);
                from(j,i) = j - 1;
            end
            if j < height && M(j+1,i-1) + cl(j,i) < M(j,i)
                M(j,i) = M(j+1,i-1) + cl(j,i);
                from(j,i) = j + 1;
            end
            M(j,i) = energy_map(j,i) + M(j,i);
        end
    end
end