function varargout = fractalGui(varargin)
% FRACTALGUI MATLAB code for fractalGui.fig
%      FRACTALGUI, by itself, creates a new FRACTALGUI or raises the existing
%      singleton*.
%
%      H = FRACTALGUI returns the handle to a new FRACTALGUI or the handle to
%      the existing singleton*.
%
%      FRACTALGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRACTALGUI.M with the given input arguments.
%
%      FRACTALGUI('Property','Value',...) creates a new FRACTALGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fractalGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fractalGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fractalGui

% Last Modified by GUIDE v2.5 08-Jul-2020 22:15:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fractalGui_OpeningFcn, ...
                   'gui_OutputFcn',  @fractalGui_OutputFcn, ...
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


% --- Executes just before fractalGui is made visible.
function fractalGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fractalGui (see VARARGIN)

% Choose default command line output for fractalGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fractalGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
init_gui_data(handles);

% --- Outputs from this function are returned to the command line.
function varargout = fractalGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start_anim.
function start_anim_Callback(hObject, eventdata, handles)
% hObject    handle to start_anim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop_anim_flag;

if(get(handles.start_anim,'String') == '动画')
    stop_anim_flag=0;
    
    set(handles.start_anim,'String','停止');
    set(handles.zoom_level,'String','1');
    set(handles.resolution,'String','512');

    set(handles.center_x,'Enable','off');
    set(handles.center_y,'Enable','off');
    set(handles.zoom_level,'Enable','off');
    set(handles.resolution,'Enable','off');
    set(handles.iter_num,'Enable','off');
    set(handles.switch_plot,'Enable','off');
    set(handles.reset,'Enable','off');

    xc = get(handles.center_x,'String');
    yc = get(handles.center_y,'String');
    iter = get(handles.iter_num,'String');
    res = get(handles.resolution,'String');

    xc = str2double(xc);
    yc = str2double(yc);
    iter = str2double(iter);
    res = str2double(res);
    axis=handles.plot_axis;

    zoom_num_list=[];
    scale_start=str2double(get(handles.scale_start,'String'));
    scale_radio=str2double(get(handles.scale_radio,'String'));
    scale_end=str2double(get(handles.scale_end,'String'));
    zoom_num_list(1)=scale_start;
    tmp=scale_start;
    while(tmp<scale_end)
        tmp=floor(tmp*scale_radio+1);
        zoom_num_list=[zoom_num_list,tmp];
    end
    
    for i=1:length(zoom_num_list)
        if(stop_anim_flag)
            break;
        end
        xoom=zoom_num_list(i);
        set(handles.error_text,'String',['开始运算第',num2str(i),'帧,放大倍数为',num2str(xoom)]);
        set(handles.zoom_level,'String',num2str(xoom));
        pause(0.2);
        MandelbrotColor(res,iter,xc ,yc,xoom,axis);
    end
    set(handles.error_text,'String','准备');
    set(handles.start_anim,'String','动画');
    set(handles.center_x,'Enable','on');
    set(handles.center_y,'Enable','on');
    set(handles.zoom_level,'Enable','on');
    set(handles.resolution,'Enable','on');
    set(handles.iter_num,'Enable','on');
%     set(handles.switch_plot,'Enable','on');
    set(handles.reset,'Enable','on');
else
    stop_anim_flag=1;
    set(handles.start_anim,'String','动画');
end

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
init_gui_data(handles);
% pause(0.3);


function center_x_Callback(hObject, eventdata, handles)
% hObject    handle to center_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of center_x as text
%        str2double(get(hObject,'String')) returns contents of center_x as a double
tmp = str2double(get(handles.iter_num,'String'));
if isnan(tmp)
    set(handles.error_text,'String','center x is not a num!');
else
    set(handles.error_text,'String','');
    my_auto_plot_func(handles);
end

% --- Executes during object creation, after setting all properties.
function center_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to center_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function center_y_Callback(hObject, eventdata, handles)
% hObject    handle to center_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of center_y as text
%        str2double(get(hObject,'String')) returns contents of center_y as a double
tmp = str2double(get(handles.iter_num,'String'));
if isnan(tmp)
    set(handles.error_text,'String','center y is not a num!');
else
    set(handles.error_text,'String','');
    my_auto_plot_func(handles);
end


% --- Executes during object creation, after setting all properties.
function center_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to center_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zoom_level_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zoom_level as text
%        str2double(get(hObject,'String')) returns contents of zoom_level as a double
tmp = str2double(get(handles.iter_num,'String'));
if isnan(tmp)
    set(handles.error_text,'String','zoom level is not a num!');
else
    set(handles.error_text,'String','');
    my_auto_plot_func(handles);
end


% --- Executes during object creation, after setting all properties.
function zoom_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zoom_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function resolution_Callback(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of resolution as text
%        str2double(get(hObject,'String')) returns contents of resolution as a double
tmp = str2double(get(handles.iter_num,'String'));
if isnan(tmp)
    set(handles.error_text,'String','resolution is not a num!');
else
    set(handles.error_text,'String','');
    my_auto_plot_func(handles);
end

% --- Executes during object creation, after setting all properties.
function resolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iter_num_Callback(hObject, eventdata, handles)
% hObject    handle to iter_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iter_num as text
%        str2double(get(hObject,'String')) returns contents of iter_num as a double
tmp = str2double(get(handles.iter_num,'String'));
if isnan(tmp)
    set(handles.error_text,'String','iter num is not a num!');
else
    set(handles.error_text,'String','');
    my_auto_plot_func(handles);
end

% --- Executes during object creation, after setting all properties.
function iter_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iter_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in switch_plot.
function switch_plot_Callback(hObject, eventdata, handles)
% hObject    handle to switch_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns switch_plot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from switch_plot


% --- Executes during object creation, after setting all properties.
function switch_plot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to switch_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function plot_axis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate plot_axis


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function my_auto_plot_func(handles)
xc = get(handles.center_x,'String');
yc = get(handles.center_y,'String');
xoom = get(handles.zoom_level,'String');
res = get(handles.resolution,'String');
iter = get(handles.iter_num,'String');

xc = str2double(xc);
yc = str2double(yc);
xoom = str2double(xoom);
res = str2double(res);
iter = str2double(iter);
axis=handles.plot_axis;
set(handles.error_text,'String','开始运算...');
pause(0.2);

tic
MandelbrotColor(res,iter,xc ,yc,xoom,axis);
set(handles.error_text,'String',['计算用了',num2str(toc),'秒']);

function init_gui_data(handles)
set(handles.center_x,'String','-0.7879777');
set(handles.center_y,'String','0.1499986688');
set(handles.scale_end,'String','1000000000');
set(handles.zoom_level,'String','1');
set(handles.resolution,'String','512');
set(handles.iter_num,'String','100');
set(handles.error_text,'String','准备');
axis=handles.plot_axis;
set(axis,'YDir','reverse');
my_auto_plot_func(handles);

% Julia(-0.8-0.21i,512,200,0,0,1)
% --------------------------------------------------------------------
function about_menu_Callback(hObject, eventdata, handles)
% hObject    handle to about_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function scale_start_Callback(hObject, eventdata, handles)
% hObject    handle to scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scale_start as text
%        str2double(get(hObject,'String')) returns contents of scale_start as a double


% --- Executes during object creation, after setting all properties.
function scale_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scale_radio_Callback(hObject, eventdata, handles)
% hObject    handle to scale_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scale_radio as text
%        str2double(get(hObject,'String')) returns contents of scale_radio as a double


% --- Executes during object creation, after setting all properties.
function scale_radio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scale_end_Callback(hObject, eventdata, handles)
% hObject    handle to scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scale_end as text
%        str2double(get(hObject,'String')) returns contents of scale_end as a double


% --- Executes during object creation, after setting all properties.
function scale_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
