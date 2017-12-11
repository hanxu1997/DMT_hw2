close all;
clc;
clear;
% 输入图像
input_img  = imread('..\input\input.jpg');
%输出图像（将输入图像中的线条一个一个输出）
gray_img = rgb2gray(input_img);
figure(1);
subplot(1,2,1);
imshow(gray_img);
title('灰度图');
% 1.通过阈值进行前后景分割（将线条和A4纸分开）
thresh_result = thresholding(input_img);
subplot(1,2,2);
imshow(thresh_result);
title('阈值前后景分割');
% 2.轮廓检测
% 解决方法之一：形态学图像处理（膨胀腐蚀）
imdilate_result = imdilate_imerode(thresh_result);
figure(2);
subplot(1,2,1);
imshow(imdilate_result);
title('膨胀腐蚀');
% 检测轮廓

% 3.通过ROI将每张图片输出

