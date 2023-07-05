function energy = get_vertical_forward_energy(image)
    [height,width] = size(image);
    energy = zeros(height,width);

    U = circshift(image,1,1);
    L = circshift(image,1,2);
    R = circshift(image,-1,2);
    cv = abs(R-L);
    cl = abs(U-L) + cv;
    cr = abs(U-R) + cv;
    energy(1,:) = image(1,:) - image(2,:);
    for j = 2:height
        for i = 1:width
            energy(j,i)  = energy(j-1,i) + cv(j,i);
            if i > 1 &&  energy(j-1,i-1) + cl(j,i) < energy(j,i)
                energy(j,i) = energy(j-1,i-1) + cl(j,i);
            end
            if i < width && energy(j-1,i+1) + cr(j,i) < energy(j,i)
                energy(j,i) = energy(j-1,i+1) + cr(j,i);
            end
        end
    end
end