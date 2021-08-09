function varargout = nuevoUsuario(varargin)
% NUEVOUSUARIO MATLAB code for nuevoUsuario.fig
%      NUEVOUSUARIO, by itself, creates a new NUEVOUSUARIO or raises the existing
%      singleton*.
%
%      H = NUEVOUSUARIO returns the handle to a new NUEVOUSUARIO or the handle to
%      the existing singleton*.
%
%      NUEVOUSUARIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NUEVOUSUARIO.M with the given input arguments.
%
%      NUEVOUSUARIO('Property','Value',...) creates a new NUEVOUSUARIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nuevoUsuario_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nuevoUsuario_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nuevoUsuario

% Last Modified by GUIDE v2.5 31-Jan-2014 02:49:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nuevoUsuario_OpeningFcn, ...
                   'gui_OutputFcn',  @nuevoUsuario_OutputFcn, ...
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


% --- Executes just before nuevoUsuario is made visible.
function nuevoUsuario_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nuevoUsuario (see VARARGIN)

% Choose default command line output for nuevoUsuario
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nuevoUsuario wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nuevoUsuario_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function numControl_txt_Callback(hObject, eventdata, handles)
% hObject    handle to numControl_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numControl_txt as text
%        str2double(get(hObject,'String')) returns contents of numControl_txt as a double


% --- Executes during object creation, after setting all properties.
function numControl_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numControl_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global photoUser_dir
[filename, pathname] = uigetfile({'*.jpg';'*.png'},'File Selector');
    photoUser_dir = strcat(pathname,filename);
    photo_user = imread(photoUser_dir);
    axes(handles.axes_alumno);imshow(photo_user);

        
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in conexionDB.
function pushbutton4_Callback(hObject, eventdata, handles)
%instanceamos la clase de java que se encuentra en el classpath de matlab
conexionJDB = conexion();
%conectamos a la base de datos;
conexionExitosa = conexionJDB.conectar('localhost','33060', 'root', 'toor','parkingdb');
if(conexionExitosa)
    %seguimos
else
    msgbox('Error al hacer la conexion, verifica si se encuentra el driver y los datos son correctos','Error de Conexion');
end

% hObject    handle to conexionDB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function nombre_txt_Callback(hObject, eventdata, handles)
% hObject    handle to nombre_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nombre_txt as text
%        str2double(get(hObject,'String')) returns contents of nombre_txt as a double


% --- Executes during object creation, after setting all properties.
function nombre_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nombre_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function apellido_txt_Callback(hObject, eventdata, handles)
% hObject    handle to apellido_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of apellido_txt as text
%        str2double(get(hObject,'String')) returns contents of apellido_txt as a double


% --- Executes during object creation, after setting all properties.
function apellido_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to apellido_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function placa_txt_Callback(hObject, eventdata, handles)
% hObject    handle to placa_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of placa_txt as text
%        str2double(get(hObject,'String')) returns contents of placa_txt as a double


% --- Executes during object creation, after setting all properties.
function placa_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to placa_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global photoAuto_dir
[filename, pathname] = uigetfile({'*.jpg';'*.png'},'File Selector');
    photoAuto_dir = strcat(pathname,filename);
    photo_auto = imread(photoAuto_dir);
    axes(handles.axes_auto);imshow(photo_auto);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in conexionDB.
function conexionDB_Callback(hObject, eventdata, handles)
global photoUser_dir photoAuto_dir

%instanceamos la clase de java que se encuentra en el classpath de matlab
conexionJDB = conexion();
%conectamos a la base de datos;
conexionExitosa = conexionJDB.conectar('localhost','3306', 'root', 'toor','parkingdb');
if(conexionExitosa)
    msgbox('Conexion exitosa');   
    %seguimos con la primer validacion
data1 = get(handles.numControl_txt, 'string');
data2 = get(handles.nombre_txt, 'string');
data3 = get(handles.apellido_txt, 'string');
data4 = get(handles.modelo_txt, 'string');
data5 = get(handles.color_txt, 'string');
data6 = get(handles.placa_txt, 'string');

if (isempty(photoUser_dir) || isempty(photoAuto_dir))
    msgbox('No olvides agregar las imagenes');
elseif (isempty(data1)|| isempty(data2) || isempty(data3) || isempty(data4) || isempty(data5) || isempty(data6))
    msgbox('Dejaste algun campo vacio');
elseif(size(data6,2)>8 || size(data1,2)~=8)
     msgbox('Numero de control debe contener 8 caracteres y la Placa debe tener 6 o 7 caracteres');
else
    %Pasamos la primera validacion, al ser todo correcto seguimos
val_selected = get(handles.combo_tipo, 'Value');
string_list = get(handles.combo_tipo,'String');
data7 = string_list{val_selected}; %contiene el tipo
%segunda validacion
%exito contendra un string con valor 'true' si todo fue bien, o con una
%excepcion de java si fue algo mal
    exito = conexionJDB.insertarAuto(data6,data4,data5,photoAuto_dir); %falta la dir_img_auto
     if(strcmp(exito,'true'))
         exito2=conexionJDB.insertarUsuario(data1,data7,data2,data3,data6,photoUser_dir); %falta la dir_img_usuario
              if(strcmp(exito2,'true'))
                 msgbox('Se agrego con exito al usuario','Exito');
                 conexionJDB.cerrarConexion();
                 close(nuevoUsuario);
              else
                 %error = strcat('Error',exito2);
                 error = 'Error al insertar datos del Usuario, verificar Datos';
                 msgbox(error,'Error');
              end
     else
         %error = strcat('Error',exito);
         error = 'Error al insertar datos del Automovil, verificar Datos';
             msgbox(error,'Error');   
     end
end
    
    
else
    msgbox('Error al hacer la conexion, verifica si se encuentra el driver y los datos son correctos','Error de Conexion');
end
% hObject    handle to conexionDB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function color_txt_Callback(hObject, eventdata, handles)
% hObject    handle to color_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of color_txt as text
%        str2double(get(hObject,'String')) returns contents of color_txt as a double


% --- Executes during object creation, after setting all properties.
function color_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function modelo_txt_Callback(hObject, eventdata, handles)
% hObject    handle to modelo_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of modelo_txt as text
%        str2double(get(hObject,'String')) returns contents of modelo_txt as a double


% --- Executes during object creation, after setting all properties.
function modelo_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modelo_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in prueba.
function prueba_Callback(hObject, eventdata, handles)
 data1 = get(handles.numControl_txt, 'string');
 data2 = get(handles.nombre_txt, 'string')
 data3 = get(handles.apellido_txt, 'string')
 data4 = get(handles.modelo_txt, 'string')
 data5 = get(handles.color_txt, 'string')
 data6 = get(handles.placa_txt, 'string')
% if isempty (data1)
%     msgbox('esta vacio');
% elseif (data1 == 'hola')
%     data1 ='hola2'
%     end
 global photoUser_dir photoAuto_dir
 

% photoUser_dir
% photoAuto_dir
% val_selected = get(handles.combo_tipo, 'Value');
% string_list = get(handles.combo_tipo,'String');
% selected_string = string_list{val_selected};
%receteamos las variables globales
%photoUser_dir = '';
%photoAuto_dir = '';
% if isempty(photoUser_dir)
%     msgbox('Tienes que agregar la foto del usuario');
% elseif isempty(photoAuto_dir)
%     msgbox('Tienes que añadir la foto del auto');
% else
%     msgbox('Tienes que añadir la to');
%     photoUser_dir 
%     photoAuto_dir
% end






% set(handles.txt_placa, 'string', placaStr);
 %plate = get(handles.txt_placa, 'string')



function tipo_txt_Callback(hObject, eventdata, handles)
% hObject    handle to tipo_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tipo_txt as text
%        str2double(get(hObject,'String')) returns contents of tipo_txt as a double


% --- Executes during object creation, after setting all properties.
function tipo_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tipo_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in combo_tipo.
function combo_tipo_Callback(hObject, eventdata, handles)
% hObject    handle to combo_tipo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns combo_tipo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from combo_tipo


% --- Executes during object creation, after setting all properties.
function combo_tipo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to combo_tipo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
