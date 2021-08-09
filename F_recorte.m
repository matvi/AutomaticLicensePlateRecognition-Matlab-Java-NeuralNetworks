%editada el 06/feb/2014 --
function [ x1, x2, h] = F_recorte( iB )
%la funcion regresa el punto 1, el punto 2 y la altura de la imagen
%esta funcion recorre la imagen de izquierda a derecha para encontrar el
%punto 1 y de derecha a izquierda para encontrar el punto 2.
%Solo hacemos la placa un poco menos ancha, esto es para que contenga solo
%los numeros
%figure; imshow(iB);
Px=sum(iB,1);
%figure;plot(Px);
[h, w] = size(iB);
alturaPorc = h*.1; % el 10 porciento de la altura de la imagen sera tomada como el valor que puede ser superado antes de ser contado como caracter
%si la altura son 79px, entonces 7.9 sera el valor, entonces debe haber mas
%de 7.9px para que en esa posicion se haga el primer corte, el
%inconveniente es que puede recortar de mas un caracter.
%figure, plot(Px);

%%encontramos la posicion en donde la proyeccion toma valores mayor a 0
%%significa que ahi es donde recortaremos
flag = true;
i=1;
while flag
   if(Px(i)>alturaPorc)%valor original 0 --
       x1=Px(i); %el valor
       x1=i; %posicion
       flag=0;
   end
   i=i+1;
end
x1 = x1-5; %se le restan 5 pixeles, por evitar recortar de mas un caracter --
flag = true;
i=w; %w contiene la anchura de la placa
while flag
    
   if(Px(i)>alturaPorc)%valor original 0 --
       x2=Px(i); %el valor
       x2=i; %posicion
       flag=0;
   end
   i=i-1;
end
% figure;
% imSeg = imcrop(iB,[x1 0 (x2-x1) h]);
% imshow(imSeg);
x2=x2+5; %--



end

