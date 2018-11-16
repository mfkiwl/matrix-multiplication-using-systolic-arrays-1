img=imread('img.jpg');
gimg=rgb2gray(img);
nimg=imresize(gimg,[135,240]);
% op=zeros(3,10800);
% for i=1:3: 133
%     a=(i-1)*80;
%     a=a+1;
%     b=a+240-1;
%     op(1,a:b)=nimg(i,:);
%     op(2,a:b)=nimg(i+1,:);
%     op(3,a:b)=nimg(i+2,:);
% end
cimg=zeros(45,80);
a=[0 0 0 ;0 1 0;0 0 0];
b=zeros(3,3);
for i=1:3:135
    for j=1:3:240
        b(1,1)=nimg(i,j);
        b(2,1)=nimg(i+1,j);
        b(3,1)=nimg(i+2,j);
        b(1,2)=nimg(i,j+1);
        b(2,2)=nimg(i+1,j+1);
        b(3,2)=nimg(i+2,j+1);
        b(1,3)=nimg(i,j+2);
        b(2,3)=nimg(i+1,j+2);
        b(3,3)=nimg(3,j+2);
        b=b*a;
        if i==1 && j==1
            cimg(i,j)=b(2,2);
        elseif i==1 && j>1
            cimg(i,(j-1)/3)=b(2,2);
        elseif i>1 && j==1
            cimg((i-1)/3,j)=b(2,2);
        else
            cimg((i-1)/3,(j-1)/3)=b(2,2);
        end
    end
end