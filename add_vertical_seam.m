function  output = add_vertical_seam(input, opt_vertical_seam)
    [height,width,channels] = size(input);
    output = zeros(height,width + 1,channels);    
    for i = 1:height
        if opt_vertical_seam(i) == width
            opt_vertical_seam(i) = width - 1;
        end
        output(i,1:opt_vertical_seam(i),:) = input(i,1:opt_vertical_seam(i),:); 
        output(i,opt_vertical_seam(i) + 1,:) = (input(i,opt_vertical_seam(i),:) + input(i,opt_vertical_seam(i) + 1,:)) / 2; 
        output(i,opt_vertical_seam(i) + 2:end,:) = input(i,opt_vertical_seam(i) + 1:end,:);
    end
end