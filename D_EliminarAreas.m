function [ iLetras ] = D_EliminarAreas( placa_Alineada )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%encontrar figuras dentro de la imgagen con la funcion region proprs
%para ejecutar este scrip es necesario primero ejecutar soble scrip
iB = zeros(size(placa_Alineada));
iLetras= zeros(size(placa_Alineada));
%iB=imSobel;
iB = placa_Alineada;
imagenBinarizada=placa_Alineada;
%imshow(iB);
%% etiqueta elementos conectados
[L Ne] = bwlabel(placa_Alineada,4); %Ne numero de elemenots% L identificador
%%calcular propiedades de los objetos
propied= regionprops(L);
%hold on
%%graficar las cajas de frontera de los objetos
%for n=1:size(propied,1)
%    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2);
%end
%pause(1)

%% buscar reas menores a 1050
s=find([propied.Area]<1050); %2000fotos todamas con el xperia necesita 5000

%%Marcar areas menoreas a 500
%for n=1:size(s,2)
%    rectangle('Position',propied(s(n)).BoundingBox,'EdgeColor','r','LineWidth',2);
%end
%pause(1)
%% eliminamos areas menores a 500
for n=1:size(s,2)
    d=round(propied(s(n)).BoundingBox);
   iB(d(2):d(2)+d(4),d(1):d(1)+d(3))=0;
end
%al eliminar areas pequeñas como las letras, iB contiene solo la placa sin
%las letras.
%%
%imshow(iB);
%en cambio imagenBinarizada contiene lo que nos interesa
%% Se compara la imagenBinarizada (contiene todo), con la la iB (contiene objetos que no nos interezan)
% donde iLetas contendra los objetos que imagenBinarizada contenga que iB no.
[h2, w2] = size(iB);
for i=1:h2
    for j=1:w2
        if(imagenBinarizada(i,j)== iB(i,j))
            iLetras(i,j)=0;
        else
            iLetras(i,j)=1;
        end
    end
end
%figure; imshow(iLetras);
%% Se calcula la proyeccion de la placa segementada
Py = sum(iLetras,2);
Px = sum(iLetras,1);
%figure; plot(Py);
%figure; plot(Px);
%% Todo lo que sigue sera comentado, para evitar perdidas de datos importantes
%en otras placas distintas o dañadas, que pueda recortar por error una
%letra y perder la identificacion de la placa
% iLetrasBU = iLetras;
% imshow(iLetras);
% [L Ne] = bwlabel(iLetras,8); %Ne numero de elemenots% L identificador
% %%calcular propiedades de los objetos
% propied= regionprops(L);
% hold on
% %%graficar las cajas de frontera de los objetos
% for n=1:size(propied,1)
%     rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2);
% end
% pause(1)
% 
% %% buscar reas menores a 500
% s=find([propied.Area]<20); %2000fotos todamas con el xperia necesita 5000
% 
% %%Marcar areas menoreas a 500
% for n=1:size(s,2)
%     rectangle('Position',propied(s(n)).BoundingBox,'EdgeColor','r','LineWidth',2);
% end
% pause(1)
% %% eliminamos areas menores a 500
% for n=1:size(s,2)
%     d=round(propied(s(n)).BoundingBox);
%    iLetrasBU(d(2):d(2)+d(4),d(1):d(1)+d(3))=0;
% end
% figure;imshow(iLetrasBU);

end

