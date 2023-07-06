function  output = remove_vertical_seam(input, opt_vertical_seam)
    [height,width,channels] = size(input);
    output = zeros(height,width - 1,channels);
    
    for i = 1:height
        output(i,1:opt_vertical_seam(i) - 1,:) = input(i,1:opt_vertical_seam(i) - 1,:); 
        output(i,opt_vertical_seam(i):end,:) = input(i,opt_vertical_seam(i) + 1:end,:);
        if opt_vertical_seam(i) > 1
            output(i,opt_vertical_seam(i) - 1,:) = (input(i,opt_vertical_seam(i) - 1,:) + input(i,opt_vertical_seam(i),:)) / 2;
        end
        if opt_vertical_seam(i) < width
            output(i,opt_vertical_seam(i),:) = (input(i,opt_vertical_seam(i),:) + input(i,opt_vertical_seam(i) + 1,:)) / 2;
        end
        input(i,opt_vertical_seam(i),:) = [1,0,0];
    end
    imshow(input);
end