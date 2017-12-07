%迭代式阈值分割  otsu阈值分割  二值化
close all;%关闭所有窗口
clear;%清除变量的状态数据
clc;%清除命令行
I=imread('rice.png');
subplot(2,2,1);
imshow(I);
title('1 rice的原图');
%迭代式阈值分割 
zmax=max(max(I));%取出最大灰度值
zmin=min(min(I));%取出最小灰度值
tk=(zmax+zmin)/2;
bcal=1;
[m,n]=size(I);
while(bcal)
    %定义前景和背景数
    iforeground=0;
    ibackground=0;
    %定义前景和背景灰度总和
    foregroundsum=0;
    backgroundsum=0;
    for i=1:m
        for j=1:n
            tmp=I(i,j);
            if(tmp>=tk)
                %前景灰度值
                iforeground=iforeground+1;
                foregroundsum=foregroundsum+double(tmp);
            else
                ibackground=ibackground+1;
                backgroundsum=backgroundsum+double(tmp);
            end
        end
    end
    %计算前景和背景的平均值
    z1=foregroundsum/iforeground;
    z2=foregroundsum/ibackground;
    tktmp=uint8((z1+z2)/2);
    if(tktmp==tk)
        bcal=0;
    else
        tk=tktmp;
    end
    %当阈值不再变化时,说明迭代结束
end
disp(strcat('迭代的阈值:',num2str(tk)));%在command window里显示出 :迭代的阈值:阈值
newI=im2bw(I,double(tk)/255);%函数im2bw使用阈值（threshold）变换法把灰度图像（grayscale image）
     %转换成二值图像。所谓二值图像， 一般意义上是指只有纯黑（0）、纯白（255）两种颜色的图像。
     %语法
    %BW = im2bw(I, level)
    %BW = im2bw(X, map, level)
    %BW = im2bw(RGB, level)
    %其中level就是设置阈值的。level取值范围[0, 1]。
subplot(2,2,2);
imshow(newI);
title('2 rice的迭代法分割效果图');
%otsu阈值分割
bw=graythresh(I);
disp(strcat('otsu阈值分割的阈值:',num2str(bw*255)));%在command window里显示出 :迭代的阈值:阈值
newII=im2bw(I,bw);
subplot(2,2,3);
imshow(newII);
title('3 rice的otsu阈值分割');
%二值化 阈值为135
[width,height,bmsize]=size(I);
for i=1:width
    for j=1:height
        if I(i,j)>135
            I(i,j)=255;
        else 
            I(i,j)=0;
        end
    end
end   
subplot(2,2,4);
imshow(I);
title('4 rice的二值阈值分割');