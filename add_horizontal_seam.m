function  output = add_horizontal_seam(input, opt_horizontal_seam)
    [height,width,channels] = size(input);
    output = zeros(height + 1,width,channels);
    for i = 1:width
        if opt_horizontal_seam(i) == height
            opt_horizontal_seam(i) = height - 1;
        end
        output(1:opt_horizontal_seam(i),i,:) = input(1:opt_horizontal_seam(i),i,:);
        output(opt_horizontal_seam(i) + 1,i,:) = (input(opt_horizontal_seam(i),i,:) + input(opt_horizontal_seam(i) + 1,i,:)) / 2; 
        output(opt_horizontal_seam(i) + 2:end,i,:) = input(opt_horizontal_seam(i) + 1:end,i,:);
    end
end