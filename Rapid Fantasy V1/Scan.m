function varargout = Scan(varargin)
% SCAN MATLAB code for Scan.fig
%      SCAN, by itself, creates a new SCAN or raises the existing
%      singleton*.
%
%      H = SCAN returns the handle to a new SCAN or the handle to
%      the existing singleton*.
%
%      SCAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCAN.M with the given input arguments.
%
%      SCAN('Property','Value',...) creates a new SCAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Scan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Scan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Scan

% Last Modified by GUIDE v2.5 27-Mar-2016 16:49:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Scan_OpeningFcn, ...
                   'gui_OutputFcn',  @Scan_OutputFcn, ...
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


% --- Executes just before Scan is made visible.
function Scan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Scan (see VARARGIN)
global Mob

%centering GUI
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);

    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);

set(handles.text2,'String',Mob.Name)
image([0 10],[0 10],Mob.Image);
axis off
switch Mob.Element
    case 02
        MobElement='Normal';
    case 03
        MobElement='Fire';
    case 04
        MobElement='Earth';
    case 05
        MobElement='Lightning';
    case 06
        MobElement='Water';
    case 07
        MobElement='Light';
    case 08
        MobElement='Dark';
end

MobStats=sprintf('Health: %d\nMana: %d\nStrength: %d\nWisdom: %d\nDefense: %d\nElement: %s\nLevel: %d\n',Mob.Health,Mob.Mana,Mob.Strength,Mob.Wisdom,Mob.Defense,MobElement,Mob.Level);

set(handles.text3,'String',MobStats)


switch Mob.ID
    case 1
        MobDes=sprintf('I wonder if it''s edible?');
    case 2
        MobDes=sprintf('He''s a bit of a blockhead.');
    case 3
        MobDes=sprintf('Shrooms will mess you up, that is why they are illegal.');
    case 4
        MobDes=sprintf('He''s a blast in the bath!');
    case 5
        MobDes=sprintf('Nobody likes triple A batteries.');
    case 6
        MobDes=sprintf('Never skip leg day.');
    case 7
        MobDes=sprintf('An underappreciated mixtape, spits straight fire.');
    case 8
        MobDes=sprintf('');
    case 9
        MobDes=sprintf('');
    case 10
        MobDes=sprintf('');
    case 11
        MobDes=sprintf('');
    case 12
        MobDes=sprintf('');
    case 13
        MobDes=sprintf('');
    case 14
        MobDes=sprintf('');
end
set(handles.text4,'String',MobDes)

% Choose default command line output for Scan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Scan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Scan_OutputFcn(hObject, eventdata, handles) 
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
close Scan
