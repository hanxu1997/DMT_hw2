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
imwrite(gray_img, '..\output\gary_img.jpg');

% 1.通过阈值进行前后景分割（将线条和A4纸分开）
thresh_result = im2bw(gray_img, 0.75);
subplot(1,2,2);
imshow(thresh_result);
title('阈值前后景分割');
imwrite(thresh_result, '..\output\thresh_result.jpg');
saveas(gcf, '..\output\figure1.jpg');

% 2.轮廓检测
% 形态学图像处理（膨胀腐蚀）
imdilate_result = imdilate_imerode(thresh_result);
figure(2);
subplot(1,2,1);
imshow(imdilate_result);
title('膨胀腐蚀');
imwrite(imdilate_result, '..\output\imdilate_result.jpg');
% 检测轮廓
% 为方便连通区域选择，二值图取反
imdilate_result = ~imdilate_result;
%获取连通区域，并进行显示 
% imclearborder:边界对象抑制
IM2 = imclearborder(imdilate_result,8);
% bwareaopen:删除小面积对象
BW2 = bwareaopen(IM2,60,8);
figure(2);
%寻找边缘，不包括孔
[B,L] = bwboundaries(BW2,'noholes');  
subplot(1,2,2);
imshow(L); 
title('轮廓检测');
hold on  
% 描边 
for k = 1:length(B)  
   boundary = B{k};  
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)  
end
saveas(gcf, '..\output\figure2.jpg');
% 3.通过ROI将每张图片输出 
%获取区域的'basic'属性， 'Area', 'Centroid', and 'BoundingBox'   
stats = regionprops(BW2, 'basic');  
%绘制感兴趣区域ROI
figure('name','ROI区域提取');
imshow(input_img);
hold on  

for i=1:size(stats)  
     rectangle('Position',[stats(i).BoundingBox],'LineWidth',1,'LineStyle','-','EdgeColor','g'),  
end  
hold off  
saveas(gcf, '..\output\figure3.jpg');
figure('name','截取各个区域');
for i=1:size(stats)  
    I = imcrop(input_img, stats(i).BoundingBox);
    subplot(2,4,i);
    imshow(I);
    titlename = ['cut',num2str(i)];
    title(titlename);
    filename = ['..\output\cut\cut',num2str(i),'.jpg'];
    imwrite(I,filename);
end
saveas(gcf, '..\output\figure4.jpg');
