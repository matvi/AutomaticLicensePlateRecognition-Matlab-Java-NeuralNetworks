Im= imread('C:\Users\David\Desktop\hello.png');
Im = rgb2gray(Im);
[m n] = size(Im);
Im = double(Im);
Gx = zeros(size(Im));
Gy = zeros(size(Im));

for r=2:m-1,
    for c=2:n-1,
        Gx(r,c)= -1*Im(r-1,c-1)-2*Im(r-1,c)-Im(r-1,c+1)+Im(r+1,c-1)+2*Im(r+1,c)+Im(r+1,c+1);
        Gy(r,c)= -1*Im(r-1,c-1)+Im(r-1,c+1)-2*Im(r,c-1)+2*Im(r,c+1)-Im(r+1,c-1)+Im(r+1,c+1);
    end
end
Gt = sqrt(Gx.^2+Gy.^2);
%Gt = uint8(Gt);
%imshow(Gt);

VmaxGt = max(max(Gt)) %Vmax = 1.1404e+03 en este caso
GtN = (Gt/VmaxGt)*255;

GtN = uint8(GtN);
B= GtN>100;

VminGx = min(min(Gx))
VminGy = min(min(Gy))
GradOffx= Gx-(VminGx);
GradOffy= Gy-(VminGy);
VmaxGx = max(max(GradOffx));
VmaxGy = max(max(GradOffy));


GxN=(GradOffx/VmaxGx)*255;
GyN=(GradOffy/VmaxGy)*255;
%GxN = uint8(GxN);
%GyN = uint8(GyN);
%max(max(GxN))
%max(max(GyN))
Gt = sqrt(GxN.^2+GyN.^2);
Gt=uint8(Gt);
[m n] = size(Gt);
for r=1:m,
    for c=1:n,
        if(Gt(r,c)>190)
            Gt(r,c)=255;
        else
            Gt(r,c)=0;
        end
    end
end
imshow(Gt);



