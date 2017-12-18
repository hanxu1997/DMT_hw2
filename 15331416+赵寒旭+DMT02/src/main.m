close all;
clc;
clear;
% ����ͼ��
input_img  = imread('..\input\input.jpg');
%���ͼ�񣨽�����ͼ���е�����һ��һ�������
gray_img = rgb2gray(input_img);
figure(1);
subplot(1,2,1);
imshow(gray_img);
title('�Ҷ�ͼ');
imwrite(gray_img, '..\output\gary_img.jpg');

% 1.ͨ����ֵ����ǰ�󾰷ָ��������A4ֽ�ֿ���
thresh_result = im2bw(gray_img, 0.75);
subplot(1,2,2);
imshow(thresh_result);
title('��ֵǰ�󾰷ָ�');
imwrite(thresh_result, '..\output\thresh_result.jpg');
saveas(gcf, '..\output\figure1.jpg');

% 2.�������
% ��̬ѧͼ�������͸�ʴ��
imdilate_result = imdilate_imerode(thresh_result);
figure(2);
subplot(1,2,1);
imshow(imdilate_result);
title('���͸�ʴ');
imwrite(imdilate_result, '..\output\imdilate_result.jpg');
% �������
% Ϊ������ͨ����ѡ�񣬶�ֵͼȡ��
imdilate_result = ~imdilate_result;
%��ȡ��ͨ���򣬲�������ʾ 
% imclearborder:�߽��������
IM2 = imclearborder(imdilate_result,8);
% bwareaopen:ɾ��С�������
BW2 = bwareaopen(IM2,60,8);
figure(2);
%Ѱ�ұ�Ե����������
[B,L] = bwboundaries(BW2,'noholes');  
subplot(1,2,2);
imshow(L); 
title('�������');
hold on  
% ��� 
for k = 1:length(B)  
   boundary = B{k};  
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)  
end
saveas(gcf, '..\output\figure2.jpg');
% 3.ͨ��ROI��ÿ��ͼƬ��� 
%��ȡ�����'basic'���ԣ� 'Area', 'Centroid', and 'BoundingBox'   
stats = regionprops(BW2, 'basic');  
%���Ƹ���Ȥ����ROI
figure('name','ROI������ȡ');
imshow(input_img);
hold on  

for i=1:size(stats)  
     rectangle('Position',[stats(i).BoundingBox],'LineWidth',1,'LineStyle','-','EdgeColor','g'),  
end  
hold off  
saveas(gcf, '..\output\figure3.jpg');
figure('name','��ȡ��������');
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
