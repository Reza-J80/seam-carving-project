clc
clear
close all

path = 'Samples dataset\';
name = 'diana';

input = im2double(imread([path, name, '\', name,'.png'])); 

height = size(input,1);
width = size(input,2);

[output, energy_map] = seam_carving(path, name, round(height / 1), round(width / 2));

imshow(input,[]);
title('input');

figure,imshow(output,[]);
title('output');

figure,imshow(energy_map,[]);
title('energy map');
