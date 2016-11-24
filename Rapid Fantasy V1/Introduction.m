function varargout = Introduction(varargin)
% INTRODUCTION MATLAB code for Introduction.fig
%      INTRODUCTION, by itself, creates a new INTRODUCTION or raises the existing
%      singleton*.
%
%      H = INTRODUCTION returns the handle to a new INTRODUCTION or the handle to
%      the existing singleton*.
%
%      INTRODUCTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTRODUCTION.M with the given input arguments.
%
%      INTRODUCTION('Property','Value',...) creates a new INTRODUCTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Introduction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Introduction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Introduction

% Last Modified by GUIDE v2.5 30-Mar-2016 17:09:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Introduction_OpeningFcn, ...
                   'gui_OutputFcn',  @Introduction_OutputFcn, ...
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


% --- Executes just before Introduction is made visible.
function Introduction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Introduction (see VARARGIN)

% Choose default command line output for Introduction
handles.output = hObject;
global secretcode hardmode
secretcode=0;hardmode=0;
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

image([0 10],[0 10],imread('Intro_img.png'));
axis off
music(1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Introduction wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Introduction_OutputFcn(hObject, eventdata, handles) 
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
global Map Player GMSTATE keynum Weapons Armors Accessories Items Magic secretcode
if secretcode==3;
    Player=player(9999,9999,9999,9999,999,999,999,0,[1,0,0],1,1,0,10,10,10,10,4,false,imread('player_right.png'));
else
    Player=player(100,100,100,100,12,12,5,0,[1,0,0],1,1,0,10,10,10,10,4,false,imread('player_right.png'));
end
Map=map(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
keynum=4;

equipped=[0,0,0,0,0];
equippedname=[cellstr('Empty')];
weaponstats=[0,0,20,0,0;...
    25,0,5,0,6;...
    0,0,2,10,0;...
    0,0,35,0,0;...
    50,0,10,0,9;...
    0,0,4,20,0;...
    0,0,50,0,0;...
    75,0,15,0,12;...
    0,0,6,30,0];
weaponnames=[cellstr('Steel Sword');...
    cellstr('Steel Shield');...
    cellstr('Amethyst Wand');...
    cellstr('Doomblade');...
    cellstr('Obsidian Barrier');...
    cellstr('Ancient Staff');...
    cellstr('Cataclysm');...
    cellstr('PeaceKeeper');...
    cellstr('Blind Justice')];
weaponinv=[0,0,0,0,0,0,0,0,0];
armorstats=[10,0,10,0,3;...
    50,0,0,0,9;...
    5,0,0,10,2;...
    20,0,20,0,6;...
    100,0,0,0,18;...
    10,0,0,20,4;...
    40,0,30,0,9;...
    200,0,0,0,36;...
    15,0,0,30,6];
armornames=[cellstr('Cactus Armor');...
    cellstr('Steel Armor');...
    cellstr('Enchanted Robes');
    cellstr('Spiked Armor');...
    cellstr('Mythril Armor');...
    cellstr('Spectre Robes');...
    cellstr('Gladiator Armor');...
    cellstr('Titan Armor');...
    cellstr('Ethereal Robes')];
armorinv=[0,0,0,0,0,0,0,0,0];
accessorystats=[0,0,10,2,0;...
    25,0,0,5,6;...
    0,0,0,20,0;...
    0,0,20,4,0;...
    50,0,0,10,9;...
    0,0,0,35,0;...
    0,0,30,6,0;...
    75,0,0,15,12;...
    0,0,0,50,0];
accessorynames=[cellstr('Power Ring');...
    cellstr('Hard Bracelet');...
    cellstr('Wise Necklace');
    cellstr('Mighty Ring');...
    cellstr('Sagacious Necklace');...
    cellstr('Resistant Bracelet');...
    cellstr('Ultimate Ring');...
    cellstr('Ultimate Necklace');...
    cellstr('Ultimate Bracelet')];
accessoryinv=[0,0,0,0,0,0,0,0,0];
Weapons=equipment(weaponnames,weaponstats,weaponinv,equipped,equippedname);
Armors=equipment(armornames,armorstats,armorinv,equipped,equippedname);
Accessories=equipment(accessorynames,accessorystats,accessoryinv,equipped,equippedname);

Items=items();

Magic=magic();

close(handles.output);
music(2);
run Overworld
GMSTATE.overworld=false;
run Tutorial

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load game script

global Player Weapons Armors Accessories Items Magic Map hardmode
try
Map=map(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
load('RapidFantasySave','Player','Weapons','Armors','Accessories','Items','Magic','hardmode')
music(2);
run Overworld
close Introduction
catch
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GMSTATE
music(0);
close(handles.output);


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global secretcode hardmode
if secretcode==0;
    if eventdata.Key=='o'
        secretcode=1;
    elseif eventdata.Key=='h'
        secretcode=4;
    else
        secretcode=0;
    end
elseif secretcode==1;
    if eventdata.Key=='p'
        secretcode=2;
    else
        secretcode=0;
    end
elseif secretcode==2;
    if eventdata.Key=='m'
        secretcode=3;
        music(3);
    else
        secretcode=0;
    end
elseif secretcode==3;
elseif secretcode==4;
    if eventdata.Key=='m'
        secretcode=5;
        hardmode=1;
        music(4);
    end
elseif secretcode==5;
else
    secretcode=0;
end
