clc
clear
close all

path = 'Samples dataset\';
name = 'Snowman';

input = im2double(imread([path, name, '\', name,'.png'])); 
depth = im2double(imread([path, name, '\', name,'_DMap.png'])); 
saliency = im2double(imread([path, name, '\', name,'_SMap.png']));

input = rgb2gray(input);
gradient = imgradient(input);
gradient = gradient / max(max(gradient));
canny = edge(input, 'canny');
edges = 0.66 * gradient + 0.37 * canny;
energy_map = 1 * depth + 1 * saliency + 1 * edges;

height = size(input,1);
width = size(input,2);

%[output, energy_map] = seam_carving(path, name, round(height / 1), round(width / 2));

%figure,imshow(output,[]);
%title('output');

%figure,imshow(energy_map,[]);
%title('energy_map');

imshow([gradient,canny,edges],[]);
title('edges');

%figure,imshow(depth,[]);
%title('depth');

%figure,imshow(saliency,[]);
%title('saliency');

%figure,imshow(energy_map,[]);
%title('energy_map');

