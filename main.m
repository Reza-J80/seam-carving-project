clc
clear
close all

path = 'Samples dataset\';
name = 'Dolls';

input = im2double(imread([path, name, '\', name,'.png'])); 

height = size(input,1);
width = size(input,2);

[output, energy_map, starting_energy] = seam_carving(path, name, round(height / 2), round(width / 1));

subplot(2,2,1);
imshow(input,[]);
title('input');

subplot(2,2,2);
imshow(starting_energy,[]);
title('starting energy');

subplot(2,2,3);
imshow(output,[]);
title('output');

subplot(2,2,4);
imshow(energy_map,[]);
title('energy map');
