%ultima modificacion 24/01/2014 --
function [ iLetrasNumeros ] = NormalizarCaracter2( iLetrasNumeros )
%Normalizar caracter 2, es una funcion para el uso de
%E_analisisProyeccionX.m
%La funcin NormalizarCaracter2 recibe una imagen binaria, esta
             %imagen binaria, contiene un caracter recortado, con o sin
             %basura. Dentro de esta funcion se calcula si el caracter es
             %lo suficientemente ancho para ser procesado, si lo es se
             %elimina la basura, esta basura es cualquier objeto con un
             %area menor a la de un caracter. Despues se hace un
             %downsampling y ya despues se eskeletiza el caracter.

%el caracter menos ancho es el '1' ente 19 y 21 pixeles de ancho
                %con esto evitamos que caracteres falsos se infiltren, solo
                %si son menores a 19 pixeles de ancho
                retornar = false; %-- cada que se llame esta funcion, no retornara nada (0) a menos que cumpla la condicion de tamaño de 19px
                [altoCar, anchoCar] = size(iLetrasNumeros);
                if(anchoCar >19)
                    retornar = true;%--
                   % figure; imshow(iLetrasNumeros);
                    areaCaracter = altoCar*anchoCar/6; %suponemos que el caracter tiene la 6 parte del area de la imagen total
                   %figure;imshow(iLetrasNumeros);
                    iLetrasNumeros = eliminarArea(iLetrasNumeros,areaCaracter);
                    %figure; imshow(iLetrasNumeros);
                      % we downsample de caracter crop
                       caracter = imresize(iLetrasNumeros,[7 5], 'nearest');%the original size was 25*20
                       %iLetrasNumeros= imresize(iLetrasNumeros,[7 5], 'lanczos3');
                       %figure; imshow(caracter);
                      iLetrasNumeros = bwmorph(caracter,'skel',inf);
                      %iLetrasNumeros = stentifordThining(caracter);
                      %figure; imshow(iLetrasNumeros); 
                       %que pasa si primero esquletizamos y  despues
                       %hacemos un imresize
                       %caracter = stentifordThining(iLetrasNumeros);
                       %figure;imshow(caracter);
                       %iLetrasNumeros = imresize(caracter,[7 5], 'nearest');
                       
                       %caracter = bwmorph(iLetrasNumeros,'skel',inf);
                       %iLetrasNuemros = imresize(caracter, [7 5], 'nearest');
                       %iLetrasNumeros = bwmorph(caracter,'skel',inf);
                       
                       
                       
                        %figure; imshow(iLetrasNumeros);
                       % pause(2);
%                       figure; imshow(caracter);
%                       caracter = imresize(iLetrasNumeros,[15 10], 'bilinear')
%                       figure; imshow(caracter);
%                       caracter = imresize(iLetrasNumeros,[15 10], 'bicubic')
%                       figure; imshow(caracter);
%                       caracter = imresize(iLetrasNumeros,[15 10], 'box')
%                       figure; imshow(caracter);
%                       caracter = imresize(iLetrasNumeros,[15 10], 'triangle')
%                       figure; imshow(caracter);
%                       caracter = imresize(iLetrasNumeros,[15 10], 'cubic')
%                       figure; imshow(caracter);
%                       caracter = imresize(iLetrasNumeros,[15 10], 'lanczos2')
%                       figure; imshow(caracter);
%                       caracter = imresize(iLetrasNumeros,[15 10], 'lanczos3')
%                       figure; imshow(caracter);
%                       %pause(2);
%                       close all;
                
                end
                if(retornar==false)%--
                    iLetrasNumeros =0;
                end

end

