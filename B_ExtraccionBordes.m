function [ imagenBinarizada ] = B_ExtraccionBordes( placa )
%% esta funcion utiliza el algoritmo de SOBEL para substraer los bordes de una imagen dada.
imshow(placa);
[h, w, q] = size(placa);
placa_gray = rgb2gray(placa);
%imshow(placa_gray);
%%
placa = medfilt2(placa_gray,[3 3]); %filtro de la mediana
%placa = ordfilt2(placa,9,ones(3,3)); %filtro maximo
%placa = ordfilt2(placa,1,ones(3,3)); %filtro minimo
%placa = imfilter(placa,fspecial('average',[3,3])); %filtro media aritmetica
%iFiltrada = placa;
%placa=I;
placa = double(placa); %es necesario convertirlo a double para evitar perdida de datos, evitar incompatibilidad de operaciones.
%%%5placa = double(Idilate);
%FiltroGouse=ones(5,5)/5;
%placa=imfilter(placa,FiltroGouse);
%iFiltrada = placa;
Gx = zeros(size(placa)); %se crea una matriz del tamaño de placa llena con ceros
Gy = zeros(size(placa));
Gt = zeros(size(placa));
imagenBinarizada = zeros(size(placa));
iBv=zeros(size(placa)); %imagen Binaria vertical
iBh=zeros(size(placa)); %imagen Binaria horizontal



for i=2:h-1,
    for j=2:w-1,
        s1= placa(i-1,j-1);
        s2= placa(i-1,j);
        s3= placa(i-1,j+1);
        s4= placa(i,j-1);
        s6= placa(i,j+1);
        s7= placa(i+1,j-1);
        s8= placa(i+1,j);
        s9= placa(i+1,j+1);
        
        %magnitud del gradiente en X y en Y
        GX = (s3+2*s6+s9)-(s1+2*s4+s7);
        GY = (s7+2*s8+s9)-(s1+2*s2+s3); 
        GT = sqrt(GX.^2 + GY.^2);
        
        
        if(GT>100);%se compara con un humbral de 100
          imagenBinarizada(i,j) = 1;
        else
          imagenBinarizada(i,j) = 0;
        end
        
        %prueba matriz
        Gx(i,j)=GX;
        Gy(i,j)=GY;
        
    end
end
%% se calculan el gradiente de sobel
Gt= sqrt(Gx.^2 + Gy.^2);%hacer esto es lo mismo que hacerlo dentro de un if, elemento a elemento, como se hizo arriba
%se normaliza el gradiente
vtMax = max(max(Gt));
GtN=(Gt/vtMax)*255;
GtN= uint8(GtN);
%imshow(Gx);%imagen del gradiente Gx antes de mostrar pasarla a uint8

%%
%%%mostramos los bordes verticales y horizontales%%%%%%%%%%%5
vtMax = max(max(Gy));
Gyy=(Gy/vtMax)*255;
Gy=uint8(Gyy);
%imshow(Gy);
vtMax = max(max(Gx));
Gxx=(Gx/vtMax)*255;
Gx=uint8(Gxx);
%figure, imshow(Gx);
ved = Gx;%vertical edge detection ved
hed = Gy; %horizontal edge detection hed
%imshow(Gy);%imagen del gradiente Gy antes de mostrar pasarla a uint8
%imshow(GtN);%imagen del gradiente Gt= sqrt(Gx.^2 + Gy.^2)
%imshow(imagenBinarizada); %imagen binarizada

%% binarizamos los bordes verticles y horizontales
for i=1:h-1,
    for j=1:w-1,
                 %creamos una imagen binarizada de Gx (vertical) 'ved'
                %para poder crear una proyeccion horizontal
        if(ved(i,j)>50)
            iBv(i,j)=1;
        else
            iBv(i,j)=0;
        end
                %creamos una imagen binarizada de Gy (horizontal) 'hed'
                %para poder crear una proyeccion horizontal
        if(hed(i,j)>50)
            iBh(i,j)=1;
        else
            iBh(i,j)=0;
        end
    end
end
%figure, imshow(iBv);
%Py = sum(iBv,2);
%Px = sum(iBh,1);
%Py = sum(imagenBinarizada,2);
%Px = sum(imagenBinarizada,1);
%imshow(imagenBinarizada);

%creo un backup de la imagen binarizada, para ser utilizada despues de
%segmentar la imagen
%imSobel = imagenBinarizada;



end

