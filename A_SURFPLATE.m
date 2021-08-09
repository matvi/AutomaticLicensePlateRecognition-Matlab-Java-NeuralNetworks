function [ x1, y1, alto, ancho ] = A_SURFPLATE( I )
global dir_plantillas_placa
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%% load reference image, and compute surf features
%ref_img = imread('C:\Users\David\Desktop\snapshot jal\placa2.jpg');C:\Users\david\Dropbox\proyecto LPR\snapshot jal
%ref_img = imread('C:\Users\david\Dropbox\proyecto LPR\snapshot jal\placa2.jpg');
%dir_p = dir('C:\Users\david\Dropbox\proyecto LPR\snapshot jal\placas\*.jpg');
dir_p = strcat(dir_plantillas_placa,'\*.jpg');
%dir_p = dir('./plantillas-placas/*.jpg');
dir_p = dir(dir_p);
num_placas=size(dir_p,1);
seguir=true;
i=1;
while(seguir)
   % d = 'C:\Users\david\Dropbox\proyecto LPR\snapshot jal\placas\';
    %direccionP = strcat(d,'placa',int2str(i),'.jpg');
    %d = 'C:\Users\david\Dropbox\proyecto LPR\snapshot jal\placas\';
    % d = './plantillas-placas/';
    
    direccionP = strcat(dir_plantillas_placa,'\',dir_p(i).name);
ref_img = imread( direccionP);
%figure; imshow(ref_img); title('imagen de referencia');
ref_img_gray = rgb2gray(ref_img);
ref_pts = detectSURFFeatures(ref_img_gray);
[ref_features, ref_validPts] = extractFeatures(ref_img_gray, ref_pts);

% figure; imshow(ref_img);
% hold on; plot(ref_pts.selectStrongest(50));
% 
% %visual 25 SURF features
% figure;
% subplot(5,5,3); title('First 25 Features');
% for i=1:25
%    scale = ref_pts(i).Scale;
%     image = imcrop(ref_img,[ref_pts(i).Location-10*scale 20*scale 20*scale]);
%     subplot(5,5,i);
%     imshow(image);
%     hold on;
%     rectangle('Position',[5*scale 5*scale 10*scale 10*scale], 'Curvature',1, 'EdgeColor', 'blue');
% end

%% compare to video frame

%image = imread('C:\Users\David\Desktop\snapshot jal\DSC_0626.jpg');
%figure; imshow(I);title('imagen I');
%image = I;
%imshow(image); title('imagen a comparar');
%I = rgb2gray(image);
%imshow(I);
%Global I;

%% Detectt features

I_pts = detectSURFFeatures(I);
[I_features, I_validPts]= extractFeatures(I, I_pts);
% figure, imshow(image);
% hold on; plot(I_pts.selectStrongest(50));
 

%% Compare fist image to second image
index_pairs = matchFeatures(ref_features, I_features);
ref_matched_pts = ref_validPts(index_pairs(:,1)).Location;
I_matched_pts = I_validPts(index_pairs(:,2)).Location;
%figure, showMatchedFeatures(image, ref_img, I_matched_pts, ref_matched_pts, 'montage');
%title('Showing all matches');

%% Define Geometric Transformation Objects
gte = vision.GeometricTransformEstimator;
gte.Method = 'Random Sample Consensus (RANSAC)';

if(size(ref_matched_pts,1) >3 &&  size(I_matched_pts,1) >3)
[tform_matrix, inlierIdx] = step(gte, ref_matched_pts, I_matched_pts);
size(inlierIdx)%normalmente entre es menor a 16,1 si no coincide la placa, mayor a 15,1 si coincide

ref_inlier_pts = ref_matched_pts(inlierIdx,:);
size(ref_inlier_pts);%del mismo tamaño ** es menor a 8 si no coincide la placa, pero mayor si coincide
I_inlier_pts = I_matched_pts(inlierIdx,:);
size(I_inlier_pts);%del mismo tamaño ** es menor a 8 si no coincide la placa, pero mayor si coincide
  if(size(inlierIdx,1)>16 || size(index_pairs,1)>20)%considerando las observaciones superiores se considera este if, i es el numero de placas
    placaCoincide = true;
  else
    placaCoincide = false;
  end
  
end
i=i+1;
    if(placaCoincide || i>num_placas)
     seguir=false;
    end
end

%Drax the lines to matched points
% figure; showMatchedFeatures(image, ref_img, I_inlier_pts, ref_inlier_pts, 'montage');
% title('Showing match only Inliers');

%como tenemos una transformacion geometrica podemos quedarnos con las
%esquinas

%%Transform the corner points
%This will show where the object is located inthe image
if(placaCoincide)
tform = maketform('affine', double(tform_matrix));
[width, height,~] = size(ref_img);
corners = [0,0;height,0;height, width;0,width];
new_corners = tformfwd(tform, corners(:,1), corners(:,2));
%figure;imshow(I);
%patch(new_corners(:,1), new_corners(:,2), [0 1 0], 'FaceAlpha', 0.5);





%% se segmenta la imagen
 x1=new_corners(1,1);
y1=new_corners(1,2);
ancho = new_corners(4,2)-y1;
alto = new_corners(2,1)-x1;
else
    msgbox('error, ninguna placa coincide, revisar base de datos de placas');
end
%placa=imcrop(image, [x1 y1 alto ancho]);
%figure;imshow(placa);
%imshow(placa);

%pause(3);
% Se gurarda un respaldo de la placa segemntada
%placa_Original = placa;
%figure; imshow(placa_Original);



end

