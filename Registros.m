function varargout = Registros(varargin)
% REGISTROS MATLAB code for Registros.fig
%      REGISTROS, by itself, creates a new REGISTROS or raises the existing
%      singleton*.
%
%      H = REGISTROS returns the handle to a new REGISTROS or the handle to
%      the existing singleton*.
%
%      REGISTROS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTROS.M with the given input arguments.
%
%      REGISTROS('Property','Value',...) creates a new REGISTROS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Registros_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Registros_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Registros

% Last Modified by GUIDE v2.5 21-Feb-2014 17:57:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Registros_OpeningFcn, ...
                   'gui_OutputFcn',  @Registros_OutputFcn, ...
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


% --- Executes just before Registros is made visible.
function Registros_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Registros (see VARARGIN)

% Choose default command line output for Registros
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Registros wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Registros_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%se crea la estructura, para contener los datos.
field = 'f';
value=0;
s=struct(field,value);
numColum= 6;
%numFilas =9;
%num_elem = cell(numFilas,numColum);
%num_elem(:,:)={'0'};
%set(handles.tabla_registros, 'Data',5,'ColumnName','Num de Registro');
%set(handles.tabla_registros,'ColumnEditable',false(1,numColum));

conexionJDB = conexion();
 conexionExitosa = conexionJDB.conectar('localhost','3306', 'root', 'toor','parkingdb');
if(conexionExitosa)
    numRegistros = get(handles.edit_numRegistros, 'string');
    if isempty(numRegistros)
        %hacer la consulata entera
        datos = conexionJDB.getRegistroData();
        %pasamos los datos a una estructura, ya que en datos estan como
        %tipo java.lang.string y en la estructura estan como string de
        %matlab.
         for i=1:size(datos,1)
            for j=1:6
            s(i,j).f = char(datos(i,j)); %con char hacemos la conversion a string de matlab
            char(datos(i,j))
            end
         end
         %colamos la estructura en un celda de datos, pero como la
         %estructura era una estructura de 2 dimensiones, dataCellarray es
         %de 3 dimensiones
         dataCellArray3D = struct2cell(s);
         %convertirmos a un arreglo de 2D
         [~,fil,col] = size(dataCellArray3D);
         data2D = ones(fil,col); %llenamos con unos
         data2D = num2cell(data2D); %convertimos a un arreglo de celdas
         for i=1:fil
            for j=1:col
                data2D(i,j)=dataCellArray3D(1,i,j);
            %data2D(i,j)=dataCellArray3D(1,i,j);
            %ele = data2D(i,j)
            end
         end
         
         set(handles.tabla_registros,'Data',data2D);

    else
        %hacer la consulta solo con el numero de los ultimos registros
        datos = conexionJDB.getRegistroData(str2num(numRegistros));
         for i=1:size(datos,1)
            for j=1:6
            s(i,j).f = char(datos(i,j)); %con char hacemos la conversion a string de matlab
            char(datos(i,j))
            end
         end
         dataCellArray3D = struct2cell(s);
         [~,fil,col] = size(dataCellArray3D);
         data2D = ones(fil,col); %llenamos con unos
         data2D = num2cell(data2D); %convertimos a un arreglo de celdas
         for i=1:fil
            for j=1:col
                data2D(i,j)=dataCellArray3D(1,i,j);
            end
         end
         
         set(handles.tabla_registros,'Data',data2D);
        
    end
else
    msgbox('conexion fallida');
end

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_numRegistros_Callback(hObject, eventdata, handles)
% hObject    handle to edit_numRegistros (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_numRegistros as text
%        str2double(get(hObject,'String')) returns contents of edit_numRegistros as a double


% --- Executes during object creation, after setting all properties.
function edit_numRegistros_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_numRegistros (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
conexionJDB = conexion();
conexionJDB.conectar('localhost','3306', 'root', 'toor','parkingdb');
datos = conexionJDB.getRegistroData();
%
for i=1:size(datos,1)
            for j=1:6
            s(i,j).f = char(datos(i,j)); %con char hacemos la conversion a string de matlab
            char(datos(i,j))
            end
end

 
