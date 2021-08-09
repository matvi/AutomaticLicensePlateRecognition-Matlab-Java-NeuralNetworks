ref_img = imread('C:\Users\David\Desktop\snapshot jal\triangulo.png');
ref_img = rgb2gray(ref_img);
imshow(ref_img);
rotate_image = zeros(size(ref_img));
rotate_image = int16(rotate_image);
grados=70;
r = pi/180*grados;
rotationMatrix= [cos(r) -sin(r); sin(r) cos(r)];
%t_matrix = [cos(r), -sin(r), 0; sin(r), cos(r), 0; 0, 0, 1];
%t_matrix2 = [1, -tan(r), 0; 0, 1, 0; 0, 0, 1];
%%
for x=1:size(ref_img,1)
    for y=1:size(ref_img,2)
        point = [x;y];
        producto = rotationMatrix * point;
        producto = int16(producto);
        newx=producto(1,1);
        newy=producto(2,1);
       
       % homo_matrix = [m, n, 0; 0, 0, 0; 0, 0, 0];
       % new_matrix = t_matrix*homo_matrix;
      %  x = round( m*cos(r)- n * sin(r));
      %  y = round(m*sin(r)+ n * cos(r));
        if(newx<=0)
            newx=1;
        else if(newy<=0)
                newy=1;
            end
        end
         rotate_image(newx,newy)=ref_img(x,y);
      %  rotate_image(x,y) = ref_img(m,n);
    end
end
%rotate_image = uint8(rotate_image);
figure;
imshow(rotate_image);

%%
clear all; close all;
im1 = imread('C:\Users\David\Desktop\snapshot jal\DSC_0627.JPG');imshow(im1);    
[m,n,p]=size(im1);
grados=70;
r = pi/180*grados;
thet = r;
m1=m*cos(thet)+n*sin(thet);
n1=m*sin(thet)+n*cos(thet);    

for i=1:m
    for j=1:n
       t = uint16((i-m/2)*cos(thet)-(j-n/2)*sin(thet)+m1/2);
       s = uint16((i-m/2)*sin(thet)+(j-n/2)*cos(thet)+n1/2);
       if t~=0 && s~=0           
        im2(t,s,:)=im1(i,j,:);
       end
    end
end
figure;
imshow(im2);

%%
im1 = imread('C:\Users\David\Desktop\snapshot jal\DSC_0627.JPG');imshow(im1); 
[m,n,p]=size(im1);
thet = rand(1);
mm = m*sqrt(2);
nn = n*sqrt(2);
for t=1:mm
   for s=1:nn
      i = uint16((t-mm/2)*cos(thet)+(s-nn/2)*sin(thet)+m/2);
      j = uint16(-(t-mm/2)*sin(thet)+(s-nn/2)*cos(thet)+n/2);
      if i>0 && j>0 && i<=m && j<=n           
         im2(t,s,:)=im1(i,j,:);
      end
   end
end
figure;
imshow(im2);
        