%importante, al actualizar el classpath las variables globales se reincian.
function varargout = Configuracion(varargin)
% CONFIGURACION MATLAB code for Configuracion.fig
%      CONFIGURACION, by itself, creates a new CONFIGURACION or raises the existing
%      singleton*.
%
%      H = CONFIGURACION returns the handle to a new CONFIGURACION or the handle to
%      the existing singleton*.
%
%      CONFIGURACION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIGURACION.M with the given input arguments.
%
%      CONFIGURACION('Property','Value',...) creates a new CONFIGURACION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Configuracion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Configuracion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Configuracion

% Last Modified by GUIDE v2.5 27-Feb-2014 01:53:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Configuracion_OpeningFcn, ...
                   'gui_OutputFcn',  @Configuracion_OutputFcn, ...
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


% --- Executes just before Configuracion is made visible.
function Configuracion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Configuracion (see VARARGIN)

% Choose default command line output for Configuracion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Configuracion wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Esta funcion se ejecuta justo despues de que se hace visible
%Configuracion.fig, la primera parte consta de tomar los JAR que se
%encuentran en la ubicacion C:/jarOCR/ y los agrega al classpath.

% pathJAR = uigetdir;
% % %  pathJAR = 'C:/jarOCR/';
% % %  archivos = strcat(pathJAR,'\*.jar');
% % %   archivos = dir(archivos);
% % %   if isempty(archivos)
% % %   msgbox('Añadir los archivos JAR al directorio C:/jarOCR/');
% % %   else
% % % num_jar=size(archivos,1);
% % % i=1;
% % % %creamos la estructura de datos
% % % field = 'f';
% % % value=0;
% % % s = struct(field,value);
% % % while(i<=num_jar)
% % %     direccionJAR = strcat(pathJAR,'\',archivos(i).name);
% % %     s(i).f=direccionJAR;
% % %     i=i+1;
% % % end
% % % c = struct2cell(s);
% % % javaclasspath(c);
% % % set(handles.edit_dir_jar,'String',strcat('JAR anañadido con exito : ',pathJAR));
% % %   end
  global dir_plantillas_placa resoluciones itemSelected;
%para la direccion de las placas
if isempty(dir_plantillas_placa)
 set(handles.edit1,'String','Sin Path, es necesario elegir el path cada vez que abre la ventana de configuracion');
else
    set(handles.edit1,'String',dir_plantillas_placa);
end

 % para la camara
 wininfo = imaqhwinfo('winvideo');
resoluciones = wininfo.DeviceInfo.SupportedFormats;
set(handles.listbox_Resoluciones,'String',resoluciones);
if ~isempty(itemSelected)
    set(handles.listbox_Resoluciones,'Value',itemSelected);
end




% --- Outputs from this function are returned to the command line.
function varargout = Configuracion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dir_plantillas_placa
    pathname = uigetdir;
    dir_plantillas_placa=pathname;
    set(handles.edit1,'String',dir_plantillas_placa);
   % photo_user = imread(photoUser_dir);
   % axes(handles.axes_alumno);imshow(photo_user);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_CargarOpciones.
function pushbutton_CargarOpciones_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_CargarOpciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global resoluciones;
wininfo = imaqhwinfo('winvideo');
resoluciones = wininfo.DeviceInfo.SupportedFormats;
set(handles.listbox_Resoluciones,'String',resoluciones);

% --- Executes on selection change in listbox_Resoluciones.
function listbox_Resoluciones_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_Resoluciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_Resoluciones contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_Resoluciones


% --- Executes during object creation, after setting all properties.
function listbox_Resoluciones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_Resoluciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_OK.
function pushbutton_OK_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  resolucionSelected dir_plantillas_placa resoluciones itemSelected;
%wininfo = imaqhwinfo('winvideo');
%resoluciones = wininfo.DeviceInfo.SupportedFormats;
itemSelected = get(handles.listbox_Resoluciones,'value');
resolucionSelected = resoluciones(itemSelected);
%set(handles.edit1,'String',resolucionSelected);
if isempty(dir_plantillas_placa)
    msgbox('Selecciona la carpeta con las plantillas de las placas');
else
    msgbox('Path de placas añadido correctamente');
    close (Configuracion)
end




% --- Executes on button press in pushbutton_buscarJar.
function pushbutton_buscarJar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_buscarJar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function edit_dir_jar_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dir_jar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dir_jar as text
%        str2double(get(hObject,'String')) returns contents of edit_dir_jar as a double


% --- Executes during object creation, after setting all properties.
function edit_dir_jar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dir_jar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
