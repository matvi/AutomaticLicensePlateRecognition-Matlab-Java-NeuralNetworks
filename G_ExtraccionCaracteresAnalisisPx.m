%ultima modificacion 24/ene/2014 --
function [ imageChar, placa_trehold ] = G_ExtraccionCaracteresAnalisisPx( placa_Original )
%Esta funcion retorna un arreglo con las imagenes bidimencionales de los
%caracteres, en cada posicion se encuentra un caracter.
%UNTITLED6 Extraemos los caracteres a partir de su analisis de la
%proyeccion en X
%%Este script, a diferencia del E_analisisHistPx, calcula al inicio el
%%adaptative treholding de la placa, la invierte para poder calcular una
%%proyeccion en x con menos ruido, puesto que el adaptative local
%%treholding ayuda a eliminar ruido, como en el ejemplo de la placa con el
%%maguey.

%se calcula el adaptative local treholding a la placa original
placa_Original2 = adaptivethreshold(placa_Original,30,0.1,0);
placa_Original2 = invertir(placa_Original2);
placa_trehold = placa_Original2;
%figure;imshow(placa_Original2);
%figure;
%imshow(placa_Original2);
%figure;imshow(placa_Original2);
%%
Px = sum(placa_Original2,1);
%figure;
%plot(Px);

%% Calculamos el promedio del valor del histograma de la placa Px
[i, y] = size(Px); %x contiene el tamaño del arrglo Py
med =0;
for i=1:y
    med= med+Px(i);%contiene todos los valores de Py
end
med = med/y; %obtenemos el promedio de valores en Py
medUmbral = med*.2; %umbral calculado, equivale al 20% de la altura promedio del histograma de la imagen.
%% Creamos un histograma donde los valores menores al umbral (med) son borrados
histX=zeros(size(Px));
for i=1:y
   if( Px(i)>medUmbral)
       histX(i)=Px(i);
   end
end
%figure; plot(histX);

%% Se calculan las anchuras del histograma 'histX' 

%se crea una estructura que contendra un arreglo de arreglos, es decir un
%arrglo que contendra en cada posicion un caracter de la placa.
field = 'char';
value =0;
imageChar = struct(field,value);
p=1; %position


[altura, x] = size (placa_Original2); %en el original se usaba iLetrasSeg, ahora se utiliza placa_Original2, que tiene las mismas dimensiones por ello no se cambia la variable
i=1;
H = x;
while(i<H)
    if(histX(i)>0)
        %se colococa i>1 && para evitar que si i=1, histX(i-1) cause un
        %error por tratar de acceder a histX(0) que no existe
        if(i>1 && (histX(i-1)==0) && (histX(i+1)>0))
            xi=i ;%punto inicial
            % Para evitar que i desborde histX aqui tambien colocamos i<H
            while(i<H && histX(i)>0) %%avanzamos hasta que encuentra puntos donde lo hacemos el punto final, siempre y cuando i<H
                i=i+1;
            end
            xf=i; %anchura final
            %esto es para evitar que caracteres juntos sean cortados
            if(xf-xi>80) %entonces el area a cortar contiene 2 caracteres, esto en una imagen de 5mpx
                xf1= (xf)-((xf-xi)/2);
                 iLetrasNumeros = imcrop(placa_Original2,[xi-5 0 (xf1-xi)+5 altura ]);
                 iLetrasNumeros = NormalizarCaracter2(iLetrasNumeros);
                 xi=xf1+10;
                 iLetrasNumeros = imcrop(placa_Original2,[xi-5 0 (xf-xi)+5 altura ]);
                 iLetrasNumeros = NormalizarCaracter2(iLetrasNumeros);
            else
            %recortamos la imagen para segmentar las letras y  numeros de la placa
            %para evitar perdidas por el histograma recortado simplemente
            %añadimos pixeles del lado izquierdo y del derecho en cada
            %recorte.
            %Aplicavamos el corte a la placa_Original, puesto esta contiene
            %una mejor resolucion de los numeros al aplicarle el
            %adaptivethrehshold que iLetrasSeg.
            %Pero como ya trabajamos con la placa_Original, ya no cortamos
            %la placa original
           % iLetrasNumeros = imcrop(placa_Original,[xi-5 0 (xf-xi)+5 altura ]);
             iLetrasNumeros = imcrop(placa_Original2,[xi-5 0 (xf-xi)+5 altura ]);
             
              
             %La funcin NormalizarCaracter2 recibe una imagen binaria, esta
             %imagen binaria, contiene un caracter recortado, con o sin
             %basura. Dentro de esta funcion se calcula si el caracter es
             %lo suficientemente ancho para ser procesado, si lo es se
             %elimina la basura, esta basura es cualquier objeto con un
             %area menor a la de un caracter. Despues se hace un
             %downsampling y ya despues se eskeletiza el caracter.
             charTemp = NormalizarCaracter2(iLetrasNumeros);
            % imageChar(p).char=NormalizarCaracter2(iLetrasNumeros);
             if(charTemp==0)
                 %p no cambia de tamaño para que la posicion no se
                 %desperdice
             else
                 imageChar(p).char=charTemp;
                 p=p+1; 
             end
                           

                    


                end
                

        end
    end
    i=i+1;
end




end

