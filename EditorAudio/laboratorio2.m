function varargout = laboratorio2(varargin)
% LABORATORIO2 MATLAB code for laboratorio2.fig
%      LABORATORIO2, by itself, creates a new LABORATORIO2 or raises the existing
%      singleton*.
%
%      H = LABORATORIO2 returns the handle to a new LABORATORIO2 or the handle to
%      the existing singleton*.
%
%      LABORATORIO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LABORATORIO2.M with the given input arguments.
%
%      LABORATORIO2('Property','Value',...) creates a new LABORATORIO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before laboratorio2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to laboratorio2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help laboratorio2

% Last Modified by GUIDE v2.5 04-Sep-2019 13:16:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @laboratorio2_OpeningFcn, ...
                   'gui_OutputFcn',  @laboratorio2_OutputFcn, ...
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


% --- Executes just before laboratorio2 is made visible.
function laboratorio2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to laboratorio2 (see VARARGIN)

% Choose default command line output for laboratorio2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes laboratorio2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = laboratorio2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function Grabar(handles)

    global Fs audio audioeditado
    %Ventana emergente 
    prompt = {'ingrese Frecuncia de muestreo:','Ingrese el Tiempo de grabación:'};
    dlgtitle = 'Parametros';
    dims = [1 35];
    definput = {'8000','5'};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
 
    tiempo= str2double(answer (2));
    Fs = str2double(answer(1)) ;
    nBits = 16 ; 
    nChannels = 1 ; 
    recObj = audiorecorder(Fs,nBits,nChannels);
    
    
    recordblocking(recObj,tiempo);
    audio = getaudiodata(recObj);
    audio = audio/max(audio);
    
    if(audioeditado == 0)   
        audioeditado = zeros(length(audioeditado), 1);
    end 
    axes(handles.Grafica1);
    plot(audio);
    
    
    axes(handles.Grafica2);
    plot(audioeditado, 'red');
    xlim([0 length(audioeditado)-1]);



% --- Executes on button press in BotonGrabar.
function BotonGrabar_Callback(hObject, eventdata, handles)
% hObject    handle to BotonGrabar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Grabar(handles);
% --- Executes on button press in BotonPlay.
function BotonPlay_Callback(hObject, eventdata, handles)
% hObject    handle to BotonPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Fs audio

sound(audio,Fs);


% --- Executes on button press in BotonPlay2.
function BotonPlay2_Callback(hObject, eventdata, handles)
% hObject    handle to BotonPlay2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Fs audioeditado
sound(audioeditado,Fs);

% --------------------------------------------------------------------
function archivo_Callback(hObject, eventdata, handles)
% hObject    handle to archivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function herramientas_Callback(hObject, eventdata, handles)
% hObject    handle to herramientas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Beditar_Callback(hObject, eventdata, handles)
% hObject    handle to Beditar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global audio audioeditado

    
    [x,y] = ginput(3);
    
    audiocortado = audio(x(1):x(2));
    %%Conforma el nuevo objeto de audio
    parteinicial = audioeditado(0:x(3));
    parterestante = audioeditado(x(3): length(audioeditado)- 1);
    
    if(length(audiocortado)>length(parterestante))
        audioeditado = [parteinicial;audiocortado];
    end
    
    if(length(audiocortado)<length(parterestante))
        faltante = parterestante(length(audiocortado): length(parterestante)-1);
        audioeditado = [parteinicial;audiocortado;faltante];
    end;
    
    axes(handles.Grafica2);
    plot(audioeditado, 'red');
    xlim([0 length(audioeditado)-1]);




% --------------------------------------------------------------------
function Bmezclar_Callback(hObject, eventdata, handles)
% hObject    handle to Bmezclar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global audio audioeditado

%%Lectura de los valores de cursor
[x,y] = ginput(3)
%% Audio cortado original
audiomezcla = audio (x(1):x(2));  
%% Audio cortado editado
audiocortadoeditado = audioeditado(x(3): length(audioeditado)-1);

%% Overflow del vector de audio base
if(length(audiomezcla) > length(audiocortadoeditado))
    diferencia = length(audiomezcla)-length(audiocortadoeditado);
    audiocortadoeditado = [audiocortadoeditado;zeros(diferencia,1)];
    
    mezcla = audiocortadoeditado + audiomezcla;
    audioeditado = [audioeditado(0:x(3));mezcla];
end
%% Oveflow del vector recortado
if(length(audiomezcla) <= length(audiocortadoeditado))
    diferencia = length(audiocortadoeditado) - length(audiomezcla);
    audiomezcla = [audiomezcla;zeros(diferencia,1)];
    
    mezcla = audiocortadoeditado + audiomezcla;
    audioeditado = [audioeditado(0:x(3));mezcla];
end


axes(handles.Grafica2);
plot(audioeditado, 'red');
xlim([0 length(audioeditado)-1]);

% --------------------------------------------------------------------
function Bamplificar_Callback(hObject, eventdata, handles)
% hObject    handle to Bamplificar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global audioeditado

    multiplicador = inputdlg('Ingrese la magnitud de amplificación:','Magnitud', 1);
    [x,y] = ginput(2);
    
    audioamplificado = audioeditado(x(1):x(2));
    audioamplificado = str2double(multiplicador) * audioamplificado ;

    %%Conforma el nuevo objeto de audio
    audioeditado = [audioeditado(0:x(1));audioamplificado;audioeditado(x(2):length(audioeditado)-1)];
    axes(handles.Grafica2);
    plot(audioeditado, 'red');
    xlim([0 length(audioeditado)-1]);

    
% --------------------------------------------------------------------
function Binsertar_Callback(hObject, eventdata, handles)
% hObject    handle to Binsertar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global audio audioeditado
%%Lectura de los valores de cursor
[x,y] = ginput(3)
%% Audio cortado original
audiocorte = audio (x(1):x(2));  

audioeditado = [audioeditado(0:x(3));audiocorte;audioeditado(x(3):length(audioeditado) - 1)];
axes(handles.Grafica2);
plot(audioeditado, 'red');
xlim([0 length(audioeditado)-1]);

% --------------------------------------------------------------------
function Bgrabar_Callback(hObject, eventdata, handles)
% hObject    handle to Bgrabar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Grabar(handles);
% --------------------------------------------------------------------
function Bguardar_Callback(hObject, eventdata, handles)
% hObject    handle to Bguardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global audio Fs
load handel.mat

filename = 'audio.wav';
audiowrite(filename,audio,Fs);




% --------------------------------------------------------------------
function Bsalir_Callback(hObject, eventdata, handles)
% hObject    handle to Bsalir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear all; 
clc;
close();


% --------------------------------------------------------------------
function uitoggletool6_OnCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.Grafica1);    
grid on 
axes(handles.Grafica2);
grid on
% --------------------------------------------------------------------
function uitoggletool6_OffCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.Grafica1);    
grid off 
axes(handles.Grafica2);
grid off


% --- Executes on button press in limpiar.
function limpiar_Callback(hObject, eventdata, handles)
% hObject    handle to limpiar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio audioeditado
audio = zeros(length(audio)-1,1);
audioeditado = zeros(length(audioeditado)-1,1 );

axes(handles.Grafica1);
plot(audioeditado);
xlim([0 length(audio)-1]);

axes(handles.Grafica2);
plot(audioeditado, 'red');
xlim([0 length(audioeditado)-1]);


