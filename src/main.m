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
imdilate_result = ~imdilate_result;
figure(2);
subplot(1,2,1);
imshow(imdilate_result);
title('膨胀腐蚀');
% 检测轮廓
%获取连通区域，并进行显示 
% imclearborder:边界对象抑制
IM2 = imclearborder(imdilate_result,8);
% bwareaopen:删除小面积对象
BW2 = bwareaopen(IM2,59,8);
figure(2);
[B,L] = bwboundaries(BW2,'noholes');%寻找边缘，不包括孔  
% imshow(label2rgb(L, @jet, [.5 .5 .5]))%显示图像 
subplot(1,2,2);
imshow(L); 
title('轮廓检测');
hold on  
% 描边 
for k = 1:length(B)  
   boundary = B{k};  
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)  
end

% 3.通过ROI将每张图片输出 
%获取区域的'basic'属性， 'Area', 'Centroid', and 'BoundingBox'   
stats = regionprops(BW2, 'basic');  
centroids = cat(1, stats.Centroid);  
%绘制开操作之后的二值化图像  
figure('name','ROI区域提取');
imshow(input_img);

hold on  
%绘制重心  
% plot(centroids(:,1), centroids(:,2), 'b*'),  
%绘制感兴趣区域ROI  
for i=1:size(stats)  
     rectangle('Position',[stats(i).BoundingBox],'LineWidth',1,'LineStyle','-','EdgeColor','r'),  
end  
hold off  
figure('name','截取各个区域');
for i=1:size(stats)  
    I = imcrop(input_img, stats(i).BoundingBox);
    subplot(2,4,i);
    imshow(I);
end
