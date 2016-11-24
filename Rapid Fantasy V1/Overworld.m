function varargout = Overworld(varargin)
% OVERWORLD MATLAB code for Overworld.fig
%      OVERWORLD, by itself, creates a new OVERWORLD or raises the existing
%      singleton*.
%
%      H = OVERWORLD returns the handle to a new OVERWORLD or the handle to
%      the existing singleton*.
%
%      OVERWORLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OVERWORLD.M with the given input arguments.
%
%      OVERWORLD('Property','Value',...) creates a new OVERWORLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Overworld_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Overworld_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Overworld

% Last Modified by GUIDE v2.5 09-Mar-2016 17:41:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Overworld_OpeningFcn, ...
                   'gui_OutputFcn',  @Overworld_OutputFcn, ...
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


% --- Executes just before Overworld is made visible.
function Overworld_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Overworld (see VARARGIN)

% Choose default command line output for Overworld
handles.output = hObject;

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

global Map Player testobj GMSTATE keynum;
GMSTATE.overworld=true;
Map=setmap(Map,Player);
[Map,Player]=render(Map,Player);
set(handles.figure1,'UserData',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Overworld wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Overworld_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%collision system
function playerguy=collision(playerguy,obj)
    if playerguy.ypos+playerguy.ylength>=obj.ypos&&playerguy.xpos==obj.xpos&&playerguy.ypos<=obj.ypos; %collide at obj's bottom
        playerguy.ypos=obj.ypos-playerguy.ylength;
        playerguy.CollideState=true;
    elseif playerguy.ypos<=obj.ypos+obj.ylength&&playerguy.xpos==obj.xpos&&playerguy.ypos>=obj.ypos; %collide at obj's top
        playerguy.ypos=obj.ypos+obj.ylength;
        playerguy.CollideState=true;
    elseif playerguy.xpos+playerguy.xlength>=obj.xpos&&playerguy.ypos==obj.ypos&&playerguy.xpos<=obj.xpos; %collide at obj's left
        playerguy.xpos=obj.xpos-playerguy.xlength;
        playerguy.CollideState=true;
    elseif playerguy.xpos<=obj.xpos+obj.xlength&&playerguy.ypos==obj.ypos&&playerguy.xpos>=obj.xpos; %collide at obj's right
        playerguy.xpos=obj.xpos+obj.xlength;
        playerguy.CollideState=true;
    else
        playerguy.CollideState=false;
    end
    
%check if player is interacting with object
function interact(playerguy,obj) %Note: Do NOT put files as variables
global GMSTATE keynum Player Mob
if obj.Interactable==true;
    if keynum==5&&playerguy.ypos+playerguy.ylength==obj.ypos&&playerguy.xpos==obj.xpos&&playerguy.Orientation==2 ...
            ||keynum==5&&playerguy.xpos+playerguy.xlength==obj.xpos&&playerguy.ypos==obj.ypos&&playerguy.Orientation==4 ...
            ||keynum==5&&playerguy.xpos==obj.xpos+obj.xlength&&playerguy.ypos==obj.ypos&&playerguy.Orientation==1 ...
            ||keynum==5&&playerguy.ypos==obj.ypos+obj.ylength&&playerguy.xpos==obj.xpos&&playerguy.Orientation==3;%Need AND for strings
        GMSTATE.overworld=false;
        switch obj.ProgNum %Define for different interactable objects
            case 1
                run sign1;
            case 2
                music(4);
                run mobs;
                Mob=Mob12;
                run BattleGUI;
        end
    end
end

%Rendering function
function [Map,playerguy]=render(Map,playerguy)
hold on
image([Map.xpos Map.xpos+Map.xlength],[Map.ypos+Map.ylength Map.ypos],Map.img);
if Map.obj1.Exist==true;
    image([Map.obj1.xpos Map.obj1.xpos+Map.obj1.xlength],[Map.obj1.ypos+Map.obj1.ylength Map.obj1.ypos],Map.obj1.img);
end
if Map.obj2.Exist==true;
    image([Map.obj2.xpos Map.obj2.xpos+Map.obj2.xlength],[Map.obj2.ypos+Map.obj2.ylength Map.obj2.ypos],Map.obj2.img);
end
if Map.obj3.Exist==true;
    image([Map.obj3.xpos Map.obj3.xpos+Map.obj3.xlength],[Map.obj3.ypos+Map.obj3.ylength Map.obj3.ypos],Map.obj3.img);
end
if Map.obj4.Exist==true;
    image([Map.obj4.xpos Map.obj4.xpos+Map.obj4.xlength],[Map.obj4.ypos+Map.obj4.ylength Map.obj4.ypos],Map.obj4.img);
end
if Map.obj5.Exist==true;
    image([Map.obj5.xpos Map.obj5.xpos+Map.obj5.xlength],[Map.obj5.ypos+Map.obj5.ylength Map.obj5.ypos],Map.obj5.img);
end
image([playerguy.xpos playerguy.xpos+playerguy.xlength],[playerguy.ypos+playerguy.ylength playerguy.ypos],playerguy.img);
axis([Map.xpos Map.xpos+Map.xlength Map.ypos Map.ypos+Map.ylength]);
axis off
drawnow
hold off

function mobout=selectmob(Map)
global GMSTATE Player
run mobs
m=randi([0 10]);n=0;
if Map.mapindex==2&&m==10;
    n=randi([1 3]);
elseif Map.mapindex==3&&m==10;
    n=randi([4 5]);
elseif Map.mapindex==4&&m==10;
    n=randi([6 7]);
elseif Map.mapindex==5&&m==10;
    n=randi([8 9]);
elseif Map.mapindex==6&&m==10;
    n=randi([10 11]);
end
switch n
    case 1
        mobout=Mob1;
    case 2
        mobout=Mob2;
    case 3
        mobout=Mob3;
    case 4
        mobout=Mob4;
    case 5
        mobout=Mob5;
    case 6
        mobout=Mob6;
    case 7
        mobout=Mob7;
    case 8
        mobout=Mob8;
    case 9
        mobout=Mob9;
    case 10
        mobout=Mob10;
    case 11
        mobout=Mob11;
    case 0
        mobout=[];
end
    
% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global Map Player GMSTATE keynum Mob;
if GMSTATE.overworld==true;
if get(handles.figure1,'UserData')==1;
set(handles.figure1,'UserData',0);
pause(0.03);
clf;
switch eventdata.Key
    case 'a'
        Player.Orientation=1; %Setting player orientation
        keynum=1; %Converting keypress to scaler numbers so that && and || can be used
    case 'leftarrow' %Player can move on the map by using 'wasd' or arrow keys
        Player.Orientation=1;
        keynum=1;
    case 'w'
        Player.Orientation=2;
        keynum=2;
    case 'uparrow'
        Player.Orientation=2;
        keynum=2;
    case 's'
        Player.Orientation=3;
        keynum=3;
    case 'downarrow'
        Player.Orientation=3;
        keynum=3;
    case 'd'
        Player.Orientation=4;
        keynum=4;
    case 'rightarrow'
        Player.Orientation=4;
        keynum=4;
    case 'space'
        keynum=5;
    case 'm'
        keynum=6;
    otherwise 
        keynum=0; %If any other button is pressed
end
switch keynum
    case 1
        Player.xpos=Player.xpos-5; 
    case 4
        Player.xpos=Player.xpos+5;
    case 2
        Player.ypos=Player.ypos+5;
    case 3
        Player.ypos=Player.ypos-5;
end
Player=checkorient(Player);
Player=collision(Player,Map.obj1);
Player=collision(Player,Map.obj2);
Player=collision(Player,Map.obj3);
Player=collision(Player,Map.obj4);
Player=collision(Player,Map.obj5);
Player=boundplayer(Player,Map);
[Map,Player]=render(Map,Player);
pause(0.03);
clf;
switch keynum
    case 1
        Player.xpos=Player.xpos-5;
    case 4
        Player.xpos=Player.xpos+5;
    case 2
        Player.ypos=Player.ypos+5;
    case 3
        Player.ypos=Player.ypos-5;
end
Player=collision(Player,Map.obj1);
Player=collision(Player,Map.obj2);
Player=collision(Player,Map.obj3);
Player=collision(Player,Map.obj4);
Player=collision(Player,Map.obj5);
Player=boundplayer(Player,Map);
Map=setmap(Map,Player);
[Map,Player]=render(Map,Player);
interact(Player,Map.obj1);
interact(Player,Map.obj2);
interact(Player,Map.obj3);
interact(Player,Map.obj4);
interact(Player,Map.obj5);
if keynum==6;
    GMSTATE.overworld=false;
    run MainMenu;
end
if Player.CollideState==false;
    if keynum==1||keynum==2||keynum==3||keynum==4;
        Mob=selectmob(Map);
        if ~isempty(Mob);
            GMSTATE.overworld=false;
            music(3);
            run BattleGUI
        end
    end
end
set(handles.figure1,'UserData',1);
end
end
