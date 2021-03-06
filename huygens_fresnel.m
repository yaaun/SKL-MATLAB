function varargout = huygens_fresnel(varargin)
% HUYGENS_FRESNEL MATLAB code for huygens_fresnel.fig
%      HUYGENS_FRESNEL, by itself, creates a new HUYGENS_FRESNEL or raises the existing
%      singleton*.
%
%      H = HUYGENS_FRESNEL returns the handle to a new HUYGENS_FRESNEL or the handle to
%      the existing singleton*.
%
%      HUYGENS_FRESNEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HUYGENS_FRESNEL.M with the given input arguments.
%
%      HUYGENS_FRESNEL('Property','Value',...) creates a new HUYGENS_FRESNEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before huygens_fresnel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to huygens_fresnel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help huygens_fresnel

% Last Modified by GUIDE v2.5 13-Jan-2017 15:40:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @huygens_fresnel_OpeningFcn, ...
                   'gui_OutputFcn',  @huygens_fresnel_OutputFcn, ...
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


% --- Executes just before huygens_fresnel is made visible.
function huygens_fresnel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to huygens_fresnel (see VARARGIN)

% Choose default command line output for huygens_fresnel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes huygens_fresnel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = huygens_fresnel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function amplitude_edit_Callback(hObject, eventdata, handles)
% hObject    handle to amplitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amplitude_edit as text
%        str2double(get(hObject,'String')) returns contents of amplitude_edit as a double
DEFAULT = 1;
d = str2double(get(hObject, 'String'));

if isnan(d)
    set(hObject, 'String', num2str(DEFAULT));
end


% --- Executes during object creation, after setting all properties.
function amplitude_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amplitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in run_toggle.
function run_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to run_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_toggle



% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[x, y] = ginput(1);
disp([x, y]);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hob, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

