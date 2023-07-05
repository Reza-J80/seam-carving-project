function energy = get_horizontal_forward_energy(image)
    [height,width] = size(image);
    energy = zeros(height,width);

    U = circshift(image,1,2);
    L = circshift(image,-1,1);
    R = circshift(image,1,1);
    cv = abs(L-R);
    cl = abs(U-L) + cv;
    cr = abs(U-R) + cv;
    energy(:,1) = image(:,1) - image(:,1);
    for i = 2:width
        for j = 1:height
            energy(j,i)  = energy(j,i-1) + cv(j,i);
            if j > 1 &&  energy(j-1,i-1) + cr(j,i) < energy(j,i)
                energy(j,i) = energy(j-1,i-1) + cr(j,i);
            end
            if j < height && energy(j+1,i-1) + cl(j,i) < energy(j,i)
                energy(j,i) = energy(j+1,i-1) + cl(j,i);
            end
        end
    end
end