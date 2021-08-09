function [ caracterVector ] = convercion ( caracter2dimensiones )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%convertirmos el vector de 1 y 0 a uno de 0.5 y -0.5 para la entrada al
%ocr.
caracterVector=zeros(size(35));
caracter = zeros(size(35));
ind=1;
for i=1:size(caracter2dimensiones,1)
for j=1:size(caracter2dimensiones,2)
    caracter(ind) = caracter2dimensiones(i,j);
    if(caracter2dimensiones(i,j)==1)
caracterVector(ind)=0.5;
    else
        caracterVector(ind)=-0.5;
    end
ind=ind+1;
end
end
%caracter
end

