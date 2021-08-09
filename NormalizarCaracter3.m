function [ iLetrasNumeros ] = NormalizarCaracter3( iLetrasNumeros )
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
                [altoCar anchoCar] = size(iLetrasNumeros);
                if(anchoCar >19)
                   % figure; imshow(iLetrasNumeros);
                    areaCaracter = altoCar*anchoCar/6; %suponemos que el caracter tiene la 6 parte del area de la imagen total
                    iLetrasNumeros = eliminarArea(iLetrasNumeros,areaCaracter);
                   % figure; imshow(iLetrasNumeros);
                      % we downsample de caracter crop
                     %%%%%%%%%%%%%%%%%% % a diferencia de normalizarChar2 estas dos lineas
                      % siguientes se comentaran
                      % caracter = imresize(iLetrasNumeros,[25 20], 'nearest')
                      esref = strel('square',5);
                      iLetrasNumeros = imdilate(iLetrasNumeros,esref);
                      iLetrasNumeros = invertir(iLetrasNumeros);
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

end



