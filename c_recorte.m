%%este scrip se ejecuta desppues de ejecutar regionprps
%este scrip recorta la imagen a partir de su proyeccion el recorte lo hace
%a partir de donde encuentra un valor en la proyeccion de lado izuierto y
%del lado derecho, no muy efectivo puesto aveces se encuentran valores
%desde el inicio
Py=sum(iB,1);
figure, plot(Py);

%%encontramos la posicion en donde la proyeccion toma valores mayor a 0
%%significa que ahi es donde recortaremos
flag = true;
i=1;
while flag
   if(Py(i)>0)
       x1=Py(i) %el valor
       x1=i %posicion
       flag=0;
   end
   i=i+1;
end

flag = true;
i=w; %w contiene la anchura de la placa
while flag
    
   if(Py(i)>0)
       x2=Py(i) %el valor
       x2=i %posicion
       flag=0;
   end
   i=i-1;
end

imSeg = imcrop(imSobel,[x1 0 (x2-x1+10) w]);
imshow(imSeg);
