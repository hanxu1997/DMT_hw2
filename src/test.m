%����ʽ��ֵ�ָ�  otsu��ֵ�ָ�  ��ֵ��
close all;%�ر����д���
clear;%���������״̬����
clc;%���������
I=imread('rice.png');
subplot(2,2,1);
imshow(I);
title('1 rice��ԭͼ');
%����ʽ��ֵ�ָ� 
zmax=max(max(I));%ȡ�����Ҷ�ֵ
zmin=min(min(I));%ȡ����С�Ҷ�ֵ
tk=(zmax+zmin)/2;
bcal=1;
[m,n]=size(I);
while(bcal)
    %����ǰ���ͱ�����
    iforeground=0;
    ibackground=0;
    %����ǰ���ͱ����Ҷ��ܺ�
    foregroundsum=0;
    backgroundsum=0;
    for i=1:m
        for j=1:n
            tmp=I(i,j);
            if(tmp>=tk)
                %ǰ���Ҷ�ֵ
                iforeground=iforeground+1;
                foregroundsum=foregroundsum+double(tmp);
            else
                ibackground=ibackground+1;
                backgroundsum=backgroundsum+double(tmp);
            end
        end
    end
    %����ǰ���ͱ�����ƽ��ֵ
    z1=foregroundsum/iforeground;
    z2=foregroundsum/ibackground;
    tktmp=uint8((z1+z2)/2);
    if(tktmp==tk)
        bcal=0;
    else
        tk=tktmp;
    end
    %����ֵ���ٱ仯ʱ,˵����������
end
disp(strcat('��������ֵ:',num2str(tk)));%��command window����ʾ�� :��������ֵ:��ֵ
newI=im2bw(I,double(tk)/255);%����im2bwʹ����ֵ��threshold���任���ѻҶ�ͼ��grayscale image��
     %ת���ɶ�ֵͼ����ν��ֵͼ�� һ����������ָֻ�д��ڣ�0�������ף�255��������ɫ��ͼ��
     %�﷨
    %BW = im2bw(I, level)
    %BW = im2bw(X, map, level)
    %BW = im2bw(RGB, level)
    %����level����������ֵ�ġ�levelȡֵ��Χ[0, 1]��
subplot(2,2,2);
imshow(newI);
title('2 rice�ĵ������ָ�Ч��ͼ');
%otsu��ֵ�ָ�
bw=graythresh(I);
disp(strcat('otsu��ֵ�ָ����ֵ:',num2str(bw*255)));%��command window����ʾ�� :��������ֵ:��ֵ
newII=im2bw(I,bw);
subplot(2,2,3);
imshow(newII);
title('3 rice��otsu��ֵ�ָ�');
%��ֵ�� ��ֵΪ135
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
title('4 rice�Ķ�ֵ��ֵ�ָ�');