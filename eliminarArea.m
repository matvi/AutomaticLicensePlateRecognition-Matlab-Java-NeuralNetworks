function [ iN ] = eliminarArea( i,area )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
iN = zeros(size(i));
iN=i;
[L] = bwlabel(i,4);
propiedad = regionprops(L);
%area debe ser un aprox 1400px^2
basura = find([propiedad.Area]<area);
for n=1: size(basura,2)
     d=round(propiedad(basura(n)).BoundingBox);
   iN(d(2):d(2)+d(4),d(1):d(1)+d(3))=0;
end

end

