function [ placa_Alineada, tetha ] = C_EnderezarPlaca( bw )
%devuelve la placa alineada y el angulo de rotacion
%UNTITLED3 Summary of this function goes here
%  Este algoritmo utliza la transformada de hough para encontrar la linea
%  mas grande de la imagen, calcula su angulo y endereza la imagen.
%bw = imSobel;
%Para mayor informacion buscar procesamiento digital de imagenes con matlab
%y simulink.

% La funci�n hough calcula la transformada de hough, donde el par�metro BW es
% una imagen binaria a la cual se quiere encontrar las l�neas. Y devuelve la matriz 
% de registros H, y los vectores theta y rho, donde theta esta dividido linealmente 
% en 180 valores y  rho esta dividido en 1997 valores.
[H, theta, rho] = hough(bw);
%Hu= uint8(H);
%imshow(Hu);
%pause(1);
% La funci�n houghpeaks permite localizar los m�ximos en la matriz de acomulacion. 
% Donde le pasamos par�metros H, que es la matriz de acumulaci�n, numpeaks que es un 
% escalar que especifica el numero de valores m�ximos a identificar en H. Y �Threshold� 
% es un escalar que especifica el umbral a partir del cual los valores de H son conciderados m�ximos. 
% Una forma sencilla de determinar un umbral que sea correcto y adecuado del valor m�ximo encontrado.
% Un ejemplo lo representa la expresi�n 0.5*max(H(:)), la cual implica que el umbral definido, es el 50 del registro de valor m�ximo.

P = houghpeaks(H,8,'threshold',ceil(0.3*max(H(:))));
%hold on
%x=theta(P(:,2));
%y=rho(P(:,1));
%plot(x,y,'s');
%pause(1);
% La funci�n houghlines extrae las l�neas asociadas a la imagen BW calculadas por la Transormada de Hough,
% implementada a partir de la combinaci�n de las funciones hough y houghpeaks. La sintaxis de esta funci�n es definida por:
% lines=houghlines(BW,theta,rho,peaks)
% Donde BW es la imagen binaria a la cual se le ddetectaron las l�neas a trav�s de la transformada de hough, 
% theta y rho son los vectores que definen la forma en como linealmente fue dividida la matriz de registros acumuladores 
% y a la vez ambos calculados por la funci�n hough. Por otra parte peaks es una matriz que fue calculada por la funci�n 
% houghpeaks de dimensi�n QX2, donde Q es el numero de l�neas detectadas y 2 los �ndices que corresponden a los par�metros r y tetha.
% La funci�n houghlines regresa como resultado un arreglo de estructuras llamado lines. 

lines = houghlines(bw,theta,rho,P);
%imshow(bw);
%pause(1);
%hold on
max_len =0;
for k=1:length(lines);
xy= [lines(k).point1; lines(k).point2];
%plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','yellow');

%plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
len = norm(lines(k).point1 - lines(k).point2);
if(len>max_len)
max_len = len;
xy_long = xy;
end
end
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
%figure,
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');

%% Encontramos el angulo en grados cexagecimales
m = (xy_long(1,2)-xy_long(2,2))/(xy_long(2,1)-xy_long(1,1));
tetha = atan(m);
tetha=(tetha*180)/pi; 

%% Rotamos la imagen
%figure;imshow(bw);
placa_Alineada = imrotate(bw, -tetha);
%figure;imshow(placa_Alineada);

%Rotamos tambien la placa original, puesto es la que nos interasa usar mas
%adelante

%placa_Original = imrotate(placa_Original, -tetha);


end

