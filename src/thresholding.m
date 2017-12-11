function output_img = thresholding( input_img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    input_img = rgb2gray(input_img);
%     threshlevel = graythresh(input_img);
    output_img = im2bw(input_img, 0.75);
end

