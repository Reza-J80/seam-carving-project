clc
clear
close all

path = 'Samples dataset\';
name = 'diana';

input = im2double(imread([path, name, '\', name,'.png'])); 

height = size(input,1);
width = size(input,2);

[output, energy_map, starting_energy] = seam_carving(path, name, round(height / 1), round(width / 2));

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

imwrite(starting_energy/max(max(starting_energy)),['Results\Reduced Width\',name,'\Starting Eneergy.png'])
imwrite(output,['Results\Reduced Width\',name,'\Output.png'])
imwrite(energy_map/max(max(energy_map)),['Results\Reduced Width\',name,'\Final Energy.png'])
imwrite(input,['Results\Reduced Width\',name,'\Input.png'])
