function  output = remove_horizontal_seam(input, opt_horizontal_seam)
    [height,width,channels] = size(input);
    output = zeros(height - 1,width,channels);

    for i = 1:width
        output(1:opt_horizontal_seam(i) - 1,i,:) = input(1:opt_horizontal_seam(i) - 1,i,:); 
        output(opt_horizontal_seam(i):end,i,:) = input(opt_horizontal_seam(i) + 1:end,i,:);
        if opt_horizontal_seam(i) > 1
            output(opt_horizontal_seam(i) - 1,i,:) = (input(opt_horizontal_seam(i) - 1,i,:) + input(opt_horizontal_seam(i),i,:)) / 2;
        end
        if opt_horizontal_seam(i) < height
            output(opt_horizontal_seam(i),i,:) = (input(opt_horizontal_seam(i),i,:) + input(opt_horizontal_seam(i) + 1,i,:)) / 2;
        end
        input(opt_horizontal_seam(i),i,:) = [1,0,0];
    end
    imshow(input);
end