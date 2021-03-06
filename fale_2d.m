function varargout = fale_2d(varargin)
% FALE_2D MATLAB code for fale_2d.fig
%      FALE_2D, by itself, creates a new FALE_2D or raises the existing
%      singleton*.
%
%      H = FALE_2D returns the handle to a new FALE_2D or the handle to
%      the existing singleton*.
%
%      FALE_2D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FALE_2D.M with the given input arguments.
%
%      FALE_2D('Property','Value',...) creates a new FALE_2D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fale_2d_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fale_2d_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fale_2d

% Last Modified by GUIDE v2.5 18-Jan-2017 01:02:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fale_2d_OpeningFcn, ...
                   'gui_OutputFcn',  @fale_2d_OutputFcn, ...
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



% --- Executes just before fale_2d is made visible.
function fale_2d_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fale_2d (see VARARGIN)

% Choose default command line output for fale_2d
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fale_2d wait for user response (see UIRESUME)
% uiwait(handles.figure1);

handles.App = WaveApp();
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = fale_2d_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in run_toggle.
function run_toggle_Callback(hobj, eventdata, handles)
% hObject    handle to run_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_toggle


if hobj.Value == 0
    hobj.String = 'Uruchom';
else
    hobj.String = 'Zatrzymaj';
    xlims = handles.axs.XLim;
    ylims = handles.axs.YLim;
    xdim = xlims(2) - xlims(1);
    ydim = ylims(2) - ylims(1);
    
    
    conf = struct(...
        'SourceAmplitude', str2double(handles.amp_edit.String), ...
        'WaveSpeed', str2double(handles.speed_edit.String), ...
        'WaveLength', str2double(handles.len_edit.String), ...
        'Width', str2double(handles.dim_edit.String), ...
        'Height', str2double(handles.dim_edit.String), ...
        'Iterations', str2double(handles.iterations_edit.String), ...
        'AxisHandle', handles.axs, ...
        'RunButtonHandle', handles.run_toggle, ...
        'FramesPerSecond', str2double(handles.fps_edit.String) ...
    );
    
    
    handles.App.configure(conf);
    handles.App.start();
end



function speededit_Callback(hObject, eventdata, handles)
% hObject    handle to speededit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speededit as text
%        str2double(get(hObject,'String')) returns contents of speededit as a double


% --- Executes during object creation, after setting all properties.
function speededit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speededit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function speedslider_Callback(hobj, eventdata, handles)
% hObject    handle to speedslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.speededit.String = num2str(hobj.Value, '%.1f');

% --- Executes during object creation, after setting all properties.
function speedslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speedslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function iterations_edit_Callback(hobj, eventdata, handles)
% hObject    handle to iterations_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterations_edit as text
%        str2double(get(hObject,'String')) returns contents of iterations_edit as a double
v = round(str2double(hobj.String));
sl = handles.iterations_slider;

if v >= sl.Min && v <= sl.Max
    sl.Value = v;
    hobj.String = num2str(v, '%.0f');
else
    hobj.String = num2str(sl.Value, '%.0f');
end


% --- Executes on slider movement.
function iterations_slider_Callback(hobj, eventdata, handles)
% hObject    handle to iterations_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ed = handles.iterations_edit;
ed.String = num2str(hobj.Value, '%.0f');

% --- Executes during object creation, after setting all properties.
function iterations_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterations_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



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



function dim_edit_Callback(hobj, eventdata, handles)
% hObject    handle to dim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim_edit as text
%        str2double(get(hObject,'String')) returns contents of dim_edit as a double
v = round(str2double(hobj.String));
hobj.String = num2str(v, '%.0f');

% --- Executes during object creation, after setting all properties.
function dim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function height_edit_Callback(hObject, eventdata, handles)
% hObject    handle to height_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of height_edit as text
%        str2double(get(hObject,'String')) returns contents of height_edit as a double
v = round(str2double(hobj.String));
hobj.String = num2str(v, '%.0f');

% --- Executes during object creation, after setting all properties.
function height_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to height_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dispersion_check.
function dispersion_check_Callback(hObject, eventdata, handles)
% hObject    handle to dispersion_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dispersion_check


% --- Executes on mouse press over axes background.
function axs_ButtonDownFcn(hobj, eventdata, handles)
% hObject    handle to axs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[xs, ys] = ginput(2);
%s = guidata(hobj);

%s.ClickCoords = [xs, ys];

disp(hobj.CurrentPoint);


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.run_toggle.Value = 0;
handles.run_toggle.String = 'Uruchom';
handles.App.reset();

w = round(str2double(handles.dim_edit.String));

handles.axs.XLim = [-w / 2 , w / 2];
handles.axs.YLim = [-w / 2 , w / 2];



% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp(handles.axs.CurrentPoint);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in source_mark_btn.
function source_mark_btn_Callback(hObject, eventdata, handles)
% hObject    handle to source_mark_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of source_mark_btn
[xs , ys] = ginput(1);
v = round([xs, ys]);
handles.source_vec_edit.String = mat2str(v);
handles.App.addSource(v, str2double(handles.amp_edit.String));

function source_vec_edit_Callback(hObject, eventdata, handles)
% hObject    handle to source_vec_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of source_vec_edit as text
%        str2double(get(hObject,'String')) returns contents of source_vec_edit as a double


% --- Executes during object creation, after setting all properties.
function source_vec_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to source_vec_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function speed_slider_Callback(hobj, eventdata, handles)
% hObject    handle to speed_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ed = handles.speed_edit;
ed.String = num2str(hobj.Value, '%.1f');

% --- Executes during object creation, after setting all properties.
function speed_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function speed_edit_Callback(hobj, eventdata, handles)
% hObject    handle to speed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speed_edit as text
%        str2double(get(hObject,'String')) returns contents of speed_edit as a double
v = str2double(hobj.String);
sl = handles.speed_slider;

if v >= sl.Min && v <= sl.Max
    sl.Value = v;
else
    hobj.String = num2str(sl.Value, '%.1f');
end

% --- Executes during object creation, after setting all properties.
function speed_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amp_edit_Callback(hObject, eventdata, handles)
% hObject    handle to amp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp_edit as text
%        str2double(get(hObject,'String')) returns contents of amp_edit as a double


% --- Executes during object creation, after setting all properties.
function amp_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fps_edit_Callback(hobj, eventdata, handles)
% hObject    handle to fps_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fps_edit as text
%        str2double(get(hObject,'String')) returns contents of fps_edit as a double
v = round(str2double(hobj.String));
sl = handles.fps_slider;

if v >= sl.Min && v <= sl.Max
    sl.Value = v;
    hobj.String = num2str(v, '%.0f');
else
    hobj.String = num2str(sl.Value, 0);
end

% --- Executes during object creation, after setting all properties.
function fps_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fps_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function fps_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fps_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.fps_edit.String = num2str(round(hObject.Value));

% --- Executes during object creation, after setting all properties.
function fps_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fps_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function len_slider_Callback(hobj, eventdata, handles)
% hObject    handle to len_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ed = handles.len_edit;
ed.String = num2str(hobj.Value, '%.1f');

% --- Executes during object creation, after setting all properties.
function len_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to len_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function len_edit_Callback(hobj, eventdata, handles)
% hObject    handle to len_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of len_edit as text
%        str2double(get(hObject,'String')) returns contents of len_edit as a double
v = str2double(hobj.String);
sl = handles.len_slider;

if v >= sl.Min && v <= sl.Max
    sl.Value = v;
else
    hobj.String = num2str(sl.Value, '%.1f');
end


% --- Executes during object creation, after setting all properties.
function len_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to len_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in type_select.
function type_select_Callback(hObject, eventdata, handles)
% hObject    handle to type_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns type_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from type_select


% --- Executes during object creation, after setting all properties.
function type_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axs
colormap(hObject, 'jet');
