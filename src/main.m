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
% 1.ͨ����ֵ����ǰ�󾰷ָ��������A4ֽ�ֿ���
thresh_result = thresholding(input_img);
subplot(1,2,2);
imshow(thresh_result);
title('��ֵǰ�󾰷ָ�');
% 2.�������
% �������֮һ����̬ѧͼ�������͸�ʴ��
imdilate_result = imdilate_imerode(thresh_result);
figure(2);
subplot(1,2,1);
imshow(imdilate_result);
title('���͸�ʴ');
% �������

% 3.ͨ��ROI��ÿ��ͼƬ���

