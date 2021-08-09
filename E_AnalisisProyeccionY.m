function [ hif  wHistPx hff ] = E_AnalisisProyeccionY( iLetras )
%Esta funcion recorta la placa a partir del histograma en Y, es una
%evolucion del algoritmo c_recorte.m, Este algoritmo recorta la placa donde
%la anchura de su proyeccion sea maxima, las otras las descarta
%   Detailed explanation goes here
Py = sum(iLetras,2);
Px = sum(iLetras,1);
%figure;plot(Py)
%% Calculamos el promedio del valor del histograma de la placa Py
[x i] = size(Py); %x contiene el tamaño del arrglo Py
med =0;
for i=1:x
    med= med+Py(i);%contiene todos los valores de Py
end
med = med/x; %obtenemos el promedio de valores en Py
med = med*.6;
%% Creamos un histograma donde los valores menores al umbral (med) son borrados
histY=zeros(size(Py));
for i=1:x
   if( Py(i)>med)
       histY(i)=Py(i);
   end
end
%figure; plot(histY);

%% Se calculan las anchuras del histograma 'histY'
i=1;
hMax=0;%representa la maxima anchura
H = x;
while(i<H)
    if(histY(i)>0)
        if((histY(i-1)==0) && (histY(i+1)>0))
            hi=i;%anchura inicial
            while(histY(i)>0)
                i=i+1;
            end
            hf=i;%anchura final
            hTemp = hf-hi; %la anchura temporal
            if(hTemp > hMax)
                hMax = hTemp;
                hif=hi;
                hff=hf;
            end
        end
    end
    i=i+1;
end

%% Recortamos la imagen iLetras, para obtener solo las letras
[i wHistPx] = size(Px); %anchura del histograma en el eje de las x, obtenemos la anchura de iLetras
iLetrasSeg = imcrop(iLetras,[0 hif  wHistPx (hff-hif)]);
%figure; imshow(iLetrasSeg);

%% se hace el mismo recorte a la placa original, puesto que sera utilizada mas adelante
%placa_Original = imcrop(placa_Original,[0 hif wHistPx (hff-hif)]);


end

