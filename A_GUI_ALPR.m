%ultima modificacion. 01/feb/2014
%ultima modificacion: 25/ene/2014 --
function varargout = A_GUI_ALPR(varargin)
% A_GUI_ALPR MATLAB code for A_GUI_ALPR.fig
%      A_GUI_ALPR, by itself, creates a new A_GUI_ALPR or raises the existing
%      singleton*.
%
%      H = A_GUI_ALPR returns the handle to a new A_GUI_ALPR or the handle to
%      the existing singleton*.
%
%      A_GUI_ALPR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in A_GUI_ALPR.M with the given input arguments.
%
%      A_GUI_ALPR('Property','Value',...) creates a new A_GUI_ALPR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before A_GUI_ALPR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to A_GUI_ALPR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help A_GUI_ALPR

% Last Modified by GUIDE v2.5 28-Feb-2014 02:11:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @A_GUI_ALPR_OpeningFcn, ...
                   'gui_OutputFcn',  @A_GUI_ALPR_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before A_GUI_ALPR is made visible.
function A_GUI_ALPR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to A_GUI_ALPR (see VARARGIN)

% Choose default command line output for A_GUI_ALPR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes A_GUI_ALPR wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%%Esta funcion se hace llamar cuando se inicia el programa y carga al
%%classpath los JAR necesarios para correr el sistema
 pathJAR = 'C:/jarOCR/';
 archivos = strcat(pathJAR,'\*.jar');
  archivos = dir(archivos);
  if isempty(archivos)
  msgbox('Añadir los archivos JAR al directorio C:/jarOCR/ y reinicie el programa');
  else
num_jar=size(archivos,1);
i=1;
%creamos la estructura de datos
field = 'f';
value=0;
s = struct(field,value);
while(i<=num_jar)
    direccionJAR = strcat(pathJAR,'\',archivos(i).name);
    s(i).f=direccionJAR;
    i=i+1;
end
c = struct2cell(s);
javaclasspath(c);
%set(handles.edit_dir_jar,'String',strcat('JAR anañadido con exito : ',pathJAR));
  end


% --- Outputs from this function are returned to the command line.
function varargout = A_GUI_ALPR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in StartCamara.
function StartCamara_Callback(hObject, eventdata, handles)

global winvid ;
% hObject    handle to button_iniciar_Camara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%im = imread('C:\Users\David\Desktop\snapshot jal\placa.jpg');
%imshow(im);

 wininfo = imaqhwinfo('winvideo');
 winvid = videoinput('winvideo',1,'MJPG_1280x1024');
 winvid.FramesPerTrigger = 1;
 winvid.ReturnedColorSpace = 'rgb';
 triggerconfig(winvid, 'manual');
 vidRes = get(winvid, 'VideoResolution');
 imWidth = vidRes(1);
 imHeight = vidRes(2);
 nBands = get(winvid, 'NumberOfBands');
 hImage = image(zeros(imHeight, imWidth, nBands), 'parent', handles.camaraFront);
 preview(winvid, hImage);

% --- Executes on button press in TakeSnapshot.
function TakeSnapshot_Callback(hObject, eventdata, handles)
% hObject    handle to TakeSnapshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global winvid Img2recognize;
Img2recognize = getsnapshot(winvid); %ya esta en escala de grises
%imshow(Img2recognize);title('esta a color?');
%I = imread('C:\Users\David\Desktop\snapshot jal\DSC_0633.jpg');C:\Users\david\Dropbox\proyecto LPR\snapshot jal
%%%Img2recognize = imread('C:\Users\david\Dropbox\proyecto LPR\snapshot jal\DSC_0650.jpg');
%funciona:
%0621,0624,0626,0627,0629,0633,0637,0638,0639,0640,0642,0648,0650,0651
%no funciona:0619,0620,0622,0623,0625,0628,0631,0632,0634,0635,0636,0643,0644,0645,0646,0647,0641, 0627
axes(handles.axe_car);imshow(Img2recognize);axis off;
Img2recognize_gray = rgb2gray(Img2recognize);%es necesaria mandarla a escala de grises
[x1, y1, alto, ancho] = A_SURFPLATE(Img2recognize_gray); 
placa=imcrop(Img2recognize, [x1 y1 alto ancho]);axes(handles.axe_plate);imshow(placa);axis off;
placaBordes = B_ExtraccionBordes(placa); axes(handles.axe_plate_sobel);imshow(placaBordes);axis off;
[placaAlineada, tetha]= C_EnderezarPlaca(placaBordes);axes(handles.axe_plate_alineada);imshow(placaAlineada);axis off;
placa = imrotate(placa, -tetha);
 %figure;imshow(placa);
 iLetras = D_EliminarAreas(placaAlineada);axes(handles.axe_plate_area);imshow(iLetras);axis off;
 [hif, wHistPx, hff] = E_AnalisisProyeccionY(iLetras);
 iLetrasSeg = imcrop(iLetras,[0 hif  wHistPx (hff-hif)]);axes(handles.axe_plate_seg);imshow(iLetrasSeg);axis off;
 placa = imcrop(placa,[0 hif  wHistPx (hff-hif)]); %igualmente se corta la imagen original
 [x1, x2, h] = F_recorte(iLetrasSeg);
 placa = imcrop(placa,[x1 0 (x2-x1) h]);axes(handles.axe_placa_rec);imshow(placa);axis off;
 %figure;imshow(placa);
 [imageChar, im_threhold] = G_ExtraccionCaracteresAnalisisPx(placa); axes(handles.axe_threhold);imshow(im_threhold);
 
 
 %ploteamos imageChar, sabiendo que su contenido debe ser igual a 7
 %caracteres
 %a excepcion de las placas del distrito que tienen 6 caracteres
 if(size(imageChar,2)==7)
 axes(handles.axes1);imshow(imageChar(1).char);
 axes(handles.axes2);imshow(imageChar(2).char);
 axes(handles.axes3);imshow(imageChar(3).char);
 axes(handles.axes4);imshow(imageChar(4).char);
 axes(handles.axes5);imshow(imageChar(5).char);
 axes(handles.axes6);imshow(imageChar(6).char);
 axes(handles.axes7);imshow(imageChar(7).char);
 else
 axes(handles.axes1);imshow(imageChar(1).char);
 axes(handles.axes2);imshow(imageChar(2).char);
 axes(handles.axes3);imshow(imageChar(3).char);
 axes(handles.axes4);imshow(imageChar(4).char);
 axes(handles.axes5);imshow(imageChar(5).char);
 axes(handles.axes6);imshow(imageChar(6).char);
 end
 
 %instanceamos la clase OCRSimple2() de java, consultar documentacion.
 ocr = OCRSimple2();
 placaStr = '';
 for i=1:size(imageChar,2)
     %%figure;imshow(imageChar(i).char);
     %primer paso convertirmos a un vector de 1 dimension imageChar que contiene un vector de 2 dimensiones
     %tambien convertimos el los datos a double 0.5 o -0.5 si su valor era
     %1 o -1 porque es lo que la RNA recibe como entrada.
     inputVector = convercion(imageChar(i).char);
     %asignamos el tamaño del tamaño del vector para trabajar con arrays en
     %java
     ocr.setSizeInputVector(inputVector);
     %asignamos el contenido de la matriz de matlab 'inputVector' que
     %contiene un vector de una dimension con valores de 0.5 o -0.5 que a
     %su vez refleja un caracter, este es asignado a un arreglo doble de 1
     %dimension en java
     ocr.setInformationInputVector(inputVector);
     %retorna el caracter reconocido
     caracterFromOCR = ocr.start();
     placaStr = strcat(placaStr,caracterFromOCR);
     
    % axes(handles.axes(i));imshow(imageChar(i).char);axis off;
 end
 set(handles.txt_placa, 'string', placaStr);
 
 
 %Apartir de aqui se establece la conexion a la base de datos, las
 %instancia a las clases conexion() son a las clases de java, agregando al
 %classpath el jar de esas clases.
 conexionJDB = conexion();
 conexionExitosa = conexionJDB.conectar('localhost','3306', 'root', 'toor','parkingdb');
if(conexionExitosa)
 dataUsuario = conexionJDB.getUsuariosData(placaStr);
 dataAuto    = conexionJDB.getAutoData(placaStr);
 %dataUsuario estara vacia si no encontro coincidencias en la base de datos
 %para ello consultamos el primer valor para verficar si esta vacio
 if (isempty(dataUsuario(1)) || isempty(dataAuto(1)))
     %no hay concidencia, usuario no en la lista
     msgbox('No existe usuario en el Registro');
 else
     %asignamos los valores, dataUsuario es un java.lang.string, para
     %convertirlo a un string de matlab usamos el metodo char
     set(handles.numControl_label,'String',char(dataUsuario(1)));
     set(handles.nombre_label,'String',char(dataUsuario(3)));
     set(handles.apellido_label,'String',char(dataUsuario(4)));
     set(handles.tipo_label,'String',char(dataUsuario(2)));
     dir_photoUser = char(dataUsuario(5));
     im_photoUser = imread(dir_photoUser);
     axes(handles.axe_photoUser);imshow(im_photoUser);
     %asignamos los valores de los datos del automovil
     set(handles.modelo_label, 'String',char(dataAuto(1)));
     set(handles.color_label, 'String', char(dataAuto(2)));
     dir_photoAuto = char(dataAuto(3));
     im_photoAuto = imread(dir_photoAuto);
     axes(handles.axe_photoAuto);imshow(im_photoAuto);
     %llenamos la tabla de registro de entrada con este nuevo usuario que
     %entro.
     conexionJDB.insertarTablaRegistro(placaStr,char(dataUsuario(1)));
 end
else
    msgbox('Conexion mala');
end

%plate = get(handles.txt_placa, 'string')
%figure;imshow(placa);
% figure; imshow(iLetrasSeg);
% figure; imshow(placa);


% --- Executes on button press in Movimiento.
function Movimiento_Callback(hObject, eventdata, handles)
global winvid;
num = 1; %controla el nombre de la imagen
control = 1; %maneja el cambio de imagen por ejemplo que sea de noche
% hObject    handle to button_Take_photo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imageBase = getsnapshot(winvid);
while(true)
    movimiento = false;
    nuevaImage = getsnapshot(winvid);
    rango = 10;%pixeles
    for i=1:size(nuevaImage,1)
        for j=1:size(nuevaImage,2)
            pixelBase = imageBase(i,j);
            pixelNuevo = nuevaImage(i,j);
            if((pixelBase-80)<pixelNuevo && (pixelBase+80)>pixelNuevo)
               
            else

                movimiento = true;
            end
        end
    end
    if(movimiento == true)
        control=control+1;
        numStr = num2str(num);
        extencion = '.jpg';
        dir ='C:\Users\Cornell\Desktop\movimiento\';
        nombre = 'mov';
        nombre = strcat(nombre,numStr,extencion);
        %imshow(nuevaImage);
        imwrite(nuevaImage,nombre,'jpg');
        num = num+1;
        if(control>10)
            imageBase=nuevaImage;
            control=1;
        end
    else
        %im = imread('C:\Users\Cornell\Desktop\tarjeta.png');
%imshow(im);
    end
end


% --- Executes on button press in plottable.
function plottable_Callback(hObject, eventdata, handles)
% hObject    handle to plottable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = imread('C:\Users\David\Desktop\snapshot jal\DSC_0621.jpg');
%x=(1:1:10);
axes(handles.axe_plate)
imshow(I);
axis off;

pause(2);
axes(handles.camaraFront);
imshow(I);
axis off;



function txt_placa_Callback(hObject, eventdata, handles)
% hObject    handle to txt_placa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_placa as text
%        str2double(get(hObject,'String')) returns contents of txt_placa as a double


% --- Executes during object creation, after setting all properties.
function txt_placa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_placa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
fig=nuevoUsuario;
h_table=uicontrol('style','text','parent',fig);
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function uipushtool3_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global plantilla;
[filename, pathname] = uigetfile({'*.jpg';'*.png'},'File Selector');
    photoPlate_dir = strcat(pathname,filename);
    photo_plate = imread(photoPlate_dir);
    imtool(photo_plate);
   % axes(handles.axes_placaAreconocer);imshow(photo_plate);
    %plantilla = photo_plate;


% --------------------------------------------------------------------
function uipushtool6_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global winvid resolucionSelected;
% hObject    handle to button_iniciar_Camara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%im = imread('C:\Users\David\Desktop\snapshot jal\placa.jpg');
%imshow(im);

 wininfo = imaqhwinfo('winvideo');
 if isempty(resolucionSelected)
     msgbox('Resolucion Predefinida, vaya a configuracion y seleccione la resolucion de camara');
     resolucionSelected =  wininfo.DeviceInfo.DefaultFormat;
 end
 winvid = videoinput('winvideo',1,char(resolucionSelected));
 winvid.FramesPerTrigger = 1;
 winvid.ReturnedColorSpace = 'rgb';
 triggerconfig(winvid, 'manual');
 vidRes = get(winvid, 'VideoResolution');
 imWidth = vidRes(1);
 imHeight = vidRes(2);
 nBands = get(winvid, 'NumberOfBands');
 hImage = image(zeros(imHeight, imWidth, nBands), 'parent', handles.camaraFront);
 preview(winvid, hImage);


% --------------------------------------------------------------------
function uipushtool5_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%fig=Registros;
%uicontrol('style','text','parent',fig);
Registros;


% --------------------------------------------------------------------
function uipushtool7_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Configuracion;


% --------------------------------------------------------------------
function uitoggletool_startCamara_OffCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool_startCamara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global winvid
closepreview(winvid)
stoppreview(winvid)

cla(handles.camaraFront,'reset')
axes(handles.camaraFront);axis off;



% --------------------------------------------------------------------
function uitoggletool_startCamara_OnCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool_startCamara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global winvid resolucionSelected;


 wininfo = imaqhwinfo('winvideo');
 if isempty(resolucionSelected)
     msgbox('Resolucion Predefinida, vaya a configuracion y seleccione la resolucion de camara');
     resolucionSelected =  wininfo.DeviceInfo.DefaultFormat;
 end
 winvid = videoinput('winvideo',1,char(resolucionSelected));
 winvid.FramesPerTrigger = 1;
 winvid.ReturnedColorSpace = 'rgb';
 triggerconfig(winvid, 'manual');
 vidRes = get(winvid, 'VideoResolution');
 imWidth = vidRes(1);
 imHeight = vidRes(2);
 nBands = get(winvid, 'NumberOfBands');
 hImage = image(zeros(imHeight, imWidth, nBands), 'parent', handles.camaraFront);
 preview(winvid, hImage);


% --- Executes on button press in pushbutton_Probar.
function pushbutton_Probar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Probar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global winvid Img2recognize;
%Img2recognize = getsnapshot(winvid); %ya esta en escala de grises
%imshow(Img2recognize);title('esta a color?');
%I = imread('C:\Users\David\Desktop\snapshot jal\DSC_0633.jpg');C:\Users\david\Dropbox\proyecto LPR\snapshot jal
[filename, pathname] = uigetfile({'*.jpg';'*.png'},'File Selector');
    dir_car = strcat(pathname,filename);
    Img2recognize = imread(dir_car);
%%%Img2recognize = imread('C:\Users\david\Dropbox\proyecto LPR\snapshot jal\DSC_0650.jpg');
%funciona:
%0621,0624,0626,0627,0629,0633,0637,0638,0639,0640,0642,0648,0650,0651
%no funciona:0619,0620,0622,0623,0625,0628,0631,0632,0634,0635,0636,0643,0644,0645,0646,0647,0641, 0627
axes(handles.axe_car);imshow(Img2recognize);axis off;
Img2recognize_gray = rgb2gray(Img2recognize);%es necesaria mandarla a escala de grises
[x1, y1, alto, ancho] = A_SURFPLATE(Img2recognize_gray); 
placa=imcrop(Img2recognize, [x1 y1 alto ancho]);axes(handles.axe_plate);imshow(placa);axis off;
placaBordes = B_ExtraccionBordes(placa); axes(handles.axe_plate_sobel);imshow(placaBordes);axis off;
[placaAlineada, tetha]= C_EnderezarPlaca(placaBordes);axes(handles.axe_plate_alineada);imshow(placaAlineada);axis off;
placa = imrotate(placa, -tetha);
 %figure;imshow(placa);
 iLetras = D_EliminarAreas(placaAlineada);axes(handles.axe_plate_area);imshow(iLetras);axis off;
 [hif, wHistPx, hff] = E_AnalisisProyeccionY(iLetras);
 iLetrasSeg = imcrop(iLetras,[0 hif  wHistPx (hff-hif)]);axes(handles.axe_plate_seg);imshow(iLetrasSeg);axis off;
 placa = imcrop(placa,[0 hif  wHistPx (hff-hif)]); %igualmente se corta la imagen original
 [x1, x2, h] = F_recorte(iLetrasSeg);
 placa = imcrop(placa,[x1 0 (x2-x1) h]);axes(handles.axe_placa_rec);imshow(placa);axis off;
 %figure;imshow(placa);
 [imageChar, im_threhold] = G_ExtraccionCaracteresAnalisisPx(placa); axes(handles.axe_threhold);imshow(im_threhold);
 
 
 %ploteamos imageChar, sabiendo que su contenido debe ser igual a 7
 %caracteres
 %a excepcion de las placas del distrito que tienen 6 caracteres
 if(size(imageChar,2)==7)
 axes(handles.axes1);imshow(imageChar(1).char);
 axes(handles.axes2);imshow(imageChar(2).char);
 axes(handles.axes3);imshow(imageChar(3).char);
 axes(handles.axes4);imshow(imageChar(4).char);
 axes(handles.axes5);imshow(imageChar(5).char);
 axes(handles.axes6);imshow(imageChar(6).char);
 axes(handles.axes7);imshow(imageChar(7).char);
 else
 axes(handles.axes1);imshow(imageChar(1).char);
 axes(handles.axes2);imshow(imageChar(2).char);
 axes(handles.axes3);imshow(imageChar(3).char);
 axes(handles.axes4);imshow(imageChar(4).char);
 axes(handles.axes5);imshow(imageChar(5).char);
 axes(handles.axes6);imshow(imageChar(6).char);
 end
 
 %instanceamos la clase OCRSimple2() de java, consultar documentacion.
 ocr = OCRSimple2();
 placaStr = '';
 for i=1:size(imageChar,2)
     %%figure;imshow(imageChar(i).char);
     %primer paso convertirmos a un vector de 1 dimension imageChar que contiene un vector de 2 dimensiones
     %tambien convertimos el los datos a double 0.5 o -0.5 si su valor era
     %1 o -1 porque es lo que la RNA recibe como entrada.
     inputVector = convercion(imageChar(i).char);
     %asignamos el tamaño del tamaño del vector para trabajar con arrays en
     %java
     ocr.setSizeInputVector(inputVector);
     %asignamos el contenido de la matriz de matlab 'inputVector' que
     %contiene un vector de una dimension con valores de 0.5 o -0.5 que a
     %su vez refleja un caracter, este es asignado a un arreglo doble de 1
     %dimension en java
     ocr.setInformationInputVector(inputVector);
     %retorna el caracter reconocido
     caracterFromOCR = ocr.start();
     placaStr = strcat(placaStr,caracterFromOCR);
     
    % axes(handles.axes(i));imshow(imageChar(i).char);axis off;
 end
 set(handles.txt_placa, 'string', placaStr);
 
 
 %Apartir de aqui se establece la conexion a la base de datos, las
 %instancia a las clases conexion() son a las clases de java, agregando al
 %classpath el jar de esas clases.
 conexionJDB = conexion();
 conexionExitosa = conexionJDB.conectar('localhost','3306', 'root', 'toor','parkingdb');
if(conexionExitosa)
 dataUsuario = conexionJDB.getUsuariosData(placaStr);
 dataAuto    = conexionJDB.getAutoData(placaStr);
 %dataUsuario estara vacia si no encontro coincidencias en la base de datos
 %para ello consultamos el primer valor para verficar si esta vacio
 if (isempty(dataUsuario(1)) || isempty(dataAuto(1)))
     %no hay concidencia, usuario no en la lista
     msgbox('No existe usuario en el Registro');
 else
     %asignamos los valores, dataUsuario es un java.lang.string, para
     %convertirlo a un string de matlab usamos el metodo char
     set(handles.numControl_label,'String',char(dataUsuario(1)));
     set(handles.nombre_label,'String',char(dataUsuario(3)));
     set(handles.apellido_label,'String',char(dataUsuario(4)));
     set(handles.tipo_label,'String',char(dataUsuario(2)));
     dir_photoUser = char(dataUsuario(5));
     im_photoUser = imread(dir_photoUser);
     axes(handles.axe_photoUser);imshow(im_photoUser);
     %asignamos los valores de los datos del automovil
     set(handles.modelo_label, 'String',char(dataAuto(1)));
     set(handles.color_label, 'String', char(dataAuto(2)));
     dir_photoAuto = char(dataAuto(3));
     im_photoAuto = imread(dir_photoAuto);
     axes(handles.axe_photoAuto);imshow(im_photoAuto);
     %llenamos la tabla de registro de entrada con este nuevo usuario que
     %entro.
     conexionJDB.insertarTablaRegistro(placaStr,char(dataUsuario(1)));
 end
else
    msgbox('Conexion mala');
end
