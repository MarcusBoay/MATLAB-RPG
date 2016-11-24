function varargout = MainMenu(varargin)
% MainMenu MATLAB code for MainMenu.fig
%      MainMenu, by itself, creates a new MainMenu or raises the existing
%      singleton*.
%
%      H = MainMenu returns the handle to a new MainMenu or the handle to
%      the existing singleton*.
%
%      MainMenu('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MainMenu.M with the given input arguments.
%
%      MainMenu('Property','Value',...) creates a new MainMenu or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainMenu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainMenu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainMenu

% Last Modified by GUIDE v2.5 02-Apr-2016 01:03:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainMenu_OpeningFcn, ...
                   'gui_OutputFcn',  @MainMenu_OutputFcn, ...
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


% --- Executes just before MainMenu is made visible.
function MainMenu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainMenu (see VARARGIN)
global Player Weapons Armors Accessories Items

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

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)
set(handles.text7,'String',Player.Strength)
set(handles.text9,'String',Player.Wisdom)
set(handles.text11,'String',Player.Defense)

set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.uipanel4,'Visible','Off')
set(handles.uipanel5,'Visible','Off')
set(handles.listbox1,'Visible','Off')

set(handles.uipanel7,'Visible','Off')
set(handles.uipanel8,'Visible','Off')
set(handles.uipanel9,'Visible','Off')
set(handles.listbox2,'Visible','Off')
set(handles.listbox3,'Visible','Off')
set(handles.listbox4,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.uipanel10,'Visible','Off')
set(handles.uipanel11,'Visible','Off')
set(handles.uipanel12,'Visible','Off')

set(handles.uipanel13,'Visible','Off')
set(handles.uipanel14,'Visible','Off')
set(handles.uipanel15,'Visible','Off')
set(handles.uipanel16,'Visible','Off')
set(handles.uipanel17,'Visible','Off')
set(handles.listbox5,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton9,'Visible','Off')
set(handles.pushbutton10,'Visible','Off')

set(handles.listbox6,'Visible','Off')
set(handles.uipanel18,'Visible','Off')
set(handles.uipanel19,'Visible','Off')
set(handles.pushbutton11,'Visible','Off')

LevelDisplay=sprintf('Level:\n%d',Player.Level);
set(handles.text38,'String',LevelDisplay)
axes(handles.axes1);
if Player.Level<5
    ExpRequired=(Player.Level*10)^3;
    ExpBar=(Player.Experience/ExpRequired)*100;
    if ExpBar~=0;
        image([0 ExpBar],[0 1],imread('exp_bar.png'));
    end
else
    image([0 100],[0 1],imread('exp_bar.png'));
end
axis([0 100 0 1]);
set(gca,'YTickLabel',{''})
set(gca,'XTickLabel',{''})
axes(handles.axes2);
if Player.LimitBar~=0;
	image([0 Player.LimitBar],[0 1],imread('limit_bar.png'));
end
axis([0 100 0 1]);
set(gca,'YTickLabel',{''})
set(gca,'XTickLabel',{''})

% Choose default command line output for MainMenu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainMenu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainMenu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Items ItemUseID

set(handles.listbox1,'Value',1)
ItemUseID=get(handles.listbox1,'Value');

listing=listitems(Items);
set(handles.listbox1,'String',listing)

if strcmp(listing,'Empty')
    set(handles.pushbutton6,'Visible','Off')
else
    set(handles.pushbutton6,'Visible','On')
end

clear listing

if isempty(ItemUseID)==1
    set(handles.pushbutton6,'Visible','Off')
end
clear have

set(handles.togglebutton2,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.togglebutton4,'Value',0)

set(handles.uipanel2,'Visible','On')
set(handles.listbox1,'Visible','On')

set(handles.uipanel3,'Visible','Off')
set(handles.uipanel4,'Visible','Off')
set(handles.uipanel5,'Visible','Off')

set(handles.uipanel7,'Visible','Off')
set(handles.uipanel8,'Visible','Off')
set(handles.uipanel9,'Visible','Off')
set(handles.listbox2,'Visible','Off')
set(handles.listbox3,'Visible','Off')
set(handles.listbox4,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.uipanel10,'Visible','Off')
set(handles.uipanel11,'Visible','Off')
set(handles.uipanel12,'Visible','Off')

set(handles.uipanel13,'Visible','Off')
set(handles.uipanel14,'Visible','Off')
set(handles.uipanel15,'Visible','Off')
set(handles.uipanel16,'Visible','Off')
set(handles.uipanel17,'Visible','Off')
set(handles.listbox5,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton9,'Visible','Off')
set(handles.pushbutton10,'Visible','Off')

set(handles.listbox6,'Visible','Off')
set(handles.uipanel18,'Visible','Off')
set(handles.uipanel19,'Visible','Off')
set(handles.pushbutton11,'Visible','Off')
% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Weapons Armors Accessories WeapEqID ArmorEqID AccEqID

set(handles.listbox2,'Value',1)
WeapEqID=get(handles.listbox1,'Value');

set(handles.listbox3,'Value',1)
ArmorEqID=get(handles.listbox1,'Value');

set(handles.listbox4,'Value',1)
AccEqID=get(handles.listbox1,'Value');

have=find(Weapons.inv==1);
if isempty(have)==0
    for i=1:length(have)
        listing{i,:}=list(Weapons,have,i);
    end
else
    listing=sprintf('Empty');
end
set(handles.listbox2,'String',listing)
if strcmp(listing,'Empty')
    set(handles.pushbutton2,'Visible','Off')
else
    set(handles.pushbutton2,'Visible','On')
end
if isempty(WeapEqID)==1
    set(handles.pushbutton2,'Visible','Off')
end
clear listing have

have=find(Armors.inv==1);
if isempty(have)==0
    for i=1:length(have)
        listing{i,:}=list(Armors,have,i);
    end
else
    listing=sprintf('Empty');
end
set(handles.listbox3,'String',listing)
if strcmp(listing,'Empty')
    set(handles.pushbutton3,'Visible','Off')
else
    set(handles.pushbutton3,'Visible','On')
end
if isempty(ArmorEqID)==1
    set(handles.pushbutton3,'Visible','Off')
end

clear listing have
have=find(Accessories.inv==1);
if isempty(have)==0
    for i=1:length(have)
        listing{i,:}=list(Accessories,have,i);
    end
else
    listing=sprintf('Empty');
end
set(handles.listbox4,'String',listing)
if strcmp(listing,'Empty')
    set(handles.pushbutton4,'Visible','Off')
else
    set(handles.pushbutton4,'Visible','On')
end
if isempty(AccEqID)==1
    set(handles.pushbutton4,'Visible','Off')
end
clear listing have

set(handles.uipanel3,'Visible','On')

set(handles.text12,'String',Weapons.equippedname)
EStats=sprintf('H:%d  S:%d  W:%d  D:%d',Weapons.equipped(1),Weapons.equipped(3),Weapons.equipped(4),Weapons.equipped(5));
set(handles.text13,'String',EStats)
set(handles.text14,'String',Armors.equippedname)
EStats=sprintf('H:%d  S:%d  W:%d  D:%d',Armors.equipped(1),Armors.equipped(3),Armors.equipped(4),Armors.equipped(5));
set(handles.text15,'String',EStats)
set(handles.text16,'String',Accessories.equippedname)
EStats=sprintf('H:%d  S:%d  W:%d  D:%d',Accessories.equipped(1),Accessories.equipped(3),Accessories.equipped(4),Accessories.equipped(5));
set(handles.text17,'String',EStats)
clear EStats

set(handles.text18,'String','')
set(handles.text19,'String','')
set(handles.text20,'String','')
set(handles.text21,'String','')
set(handles.text22,'String','')
set(handles.text23,'String','')

set(handles.uipanel7,'Visible','On')
set(handles.uipanel8,'Visible','On')
set(handles.uipanel9,'Visible','On')
set(handles.listbox2,'Visible','On')
set(handles.listbox3,'Visible','On')
set(handles.listbox4,'Visible','On')
set(handles.uipanel10,'Visible','On')
set(handles.uipanel11,'Visible','On')
set(handles.uipanel12,'Visible','On')

set(handles.togglebutton1,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.togglebutton4,'Value',0)

set(handles.uipanel2,'Visible','Off')
set(handles.uipanel4,'Visible','Off')
set(handles.uipanel5,'Visible','Off')
set(handles.listbox1,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')

set(handles.uipanel13,'Visible','Off')
set(handles.uipanel14,'Visible','Off')
set(handles.uipanel15,'Visible','Off')
set(handles.uipanel16,'Visible','Off')
set(handles.uipanel17,'Visible','Off')
set(handles.listbox5,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton9,'Visible','Off')
set(handles.pushbutton10,'Visible','Off')

set(handles.listbox6,'Visible','Off')
set(handles.uipanel18,'Visible','Off')
set(handles.uipanel19,'Visible','Off')
set(handles.pushbutton11,'Visible','Off')
% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Magic MagicEqID

set(handles.listbox1,'Value',1)
MagicEqID=get(handles.listbox1,'Value');

listing=listmagic(Magic);
set(handles.listbox5,'String',listing)
clear listing

if Magic.Current(1)==0
    set(handles.text24,'String','')
    set(handles.text25,'String','')
else
    switch Magic.Element(Magic.Current(1))
    case 02
        EleText='Normal';
    case 03
        EleText='Fire';
    case 04
        EleText='Earth';
    case 05
        EleText='Lightning';
    case 06
        EleText='Water';
    case 07
        EleText='Light';
    case 08
        EleText='Dark';
    end
    MgcDes=sprintf('Element: %s\nTier: %d\nManaCost: %d',EleText,Magic.Tier(Magic.Current(1)),Magic.ManaCost(Magic.Current(1)));
    set(handles.text24,'String',Magic.Names{Magic.Current(1)})
    set(handles.text25,'String',MgcDes)
    clear MgcDes EleText
end

if Magic.Current(2)==0
    set(handles.text26,'String','')
    set(handles.text27,'String','')
else
    switch Magic.Element(Magic.Current(2))
    case 02
        EleText='Normal';
    case 03
        EleText='Fire';
    case 04
        EleText='Earth';
    case 05
        EleText='Lightning';
    case 06
        EleText='Water';
    case 07
        EleText='Light';
    case 08
        EleText='Dark';
    end
    MgcDes=sprintf('Element: %s\nTier: %d\nManaCost: %d',EleText,Magic.Tier(Magic.Current(2)),Magic.ManaCost(Magic.Current(2)));
    set(handles.text26,'String',Magic.Names{Magic.Current(2)})
    set(handles.text27,'String',MgcDes)
    clear MgcDes EleText
end

if Magic.Current(3)==0
    set(handles.text28,'String','')
    set(handles.text29,'String','')
else
    switch Magic.Element(Magic.Current(3))
    case 02
        EleText='Normal';
    case 03
        EleText='Fire';
    case 04
        EleText='Earth';
    case 05
        EleText='Lightning';
    case 06
        EleText='Water';
    case 07
        EleText='Light';
    case 08
        EleText='Dark';
    end
    MgcDes=sprintf('Element: %s\nTier: %d\nManaCost: %d',EleText,Magic.Tier(Magic.Current(3)),Magic.ManaCost(Magic.Current(3)));
    set(handles.text28,'String',Magic.Names{Magic.Current(3)})
    set(handles.text29,'String',MgcDes)
    clear MgcDes EleText
end

if Magic.Current(4)==0
    set(handles.text30,'String','')
    set(handles.text31,'String','')
else
    switch Magic.Element(Magic.Current(4))
    case 02
        EleText='Normal';
    case 03
        EleText='Fire';
    case 04
        EleText='Earth';
    case 05
        EleText='Lightning';
    case 06
        EleText='Water';
    case 07
        EleText='Light';
    case 08
        EleText='Dark';
    end
    MgcDes=sprintf('Element: %s\nTier: %d\nManaCost: %d',EleText,Magic.Tier(Magic.Current(4)),Magic.ManaCost(Magic.Current(4)));
    set(handles.text30,'String',Magic.Names{Magic.Current(4)})
    set(handles.text31,'String',MgcDes)
    clear MgcDes EleText
end

set(handles.text32,'String','')
set(handles.text33,'String','')

set(handles.togglebutton1,'Value',0)
set(handles.togglebutton2,'Value',0)
set(handles.togglebutton4,'Value',0)

set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.uipanel4,'Visible','On')
set(handles.uipanel5,'Visible','Off')
set(handles.listbox1,'Visible','Off')

set(handles.uipanel7,'Visible','Off')
set(handles.uipanel8,'Visible','Off')
set(handles.uipanel9,'Visible','Off')
set(handles.listbox2,'Visible','Off')
set(handles.listbox3,'Visible','Off')
set(handles.listbox4,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.uipanel10,'Visible','Off')
set(handles.uipanel11,'Visible','Off')
set(handles.uipanel12,'Visible','Off')

set(handles.uipanel13,'Visible','On')
set(handles.uipanel14,'Visible','On')
set(handles.uipanel15,'Visible','On')
set(handles.uipanel16,'Visible','On')
set(handles.uipanel17,'Visible','On')
set(handles.listbox5,'Visible','On')
set(handles.pushbutton7,'Visible','On')
set(handles.pushbutton8,'Visible','On')
set(handles.pushbutton9,'Visible','On')
set(handles.pushbutton10,'Visible','On')

set(handles.listbox6,'Visible','Off')
set(handles.uipanel18,'Visible','Off')
set(handles.uipanel19,'Visible','Off')
set(handles.pushbutton11,'Visible','Off')
% Hint: get(hObject,'Value') returns toggle state of togglebutton3

% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4
global Player LimitNames LimitDes LimitEqID

set(handles.listbox1,'Value',1)
LimitEqID=get(handles.listbox1,'Value');

have=find(Player.UnlockedLimits==1);
LimitNames=[cellstr('Sonic Spike');cellstr('Sword Dance');cellstr('Oblivion Strike')];
LimitDes=[cellstr('Tier 1');cellstr('Tier 2');cellstr('Tier 3')];
for i=1:length(have)
    listing{i,:}=sprintf('%d) %s',i,LimitNames{have(i)});
end
set(handles.listbox6,'String',listing)

set(handles.text34,'String',LimitNames(Player.CurrentLimit))
set(handles.text35,'String',LimitDes(Player.CurrentLimit))

set(handles.text36,'String','')
set(handles.text37,'String','')

set(handles.togglebutton1,'Value',0)
set(handles.togglebutton2,'Value',0)
set(handles.togglebutton3,'Value',0)

set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.uipanel4,'Visible','Off')
set(handles.uipanel5,'Visible','On')
set(handles.listbox1,'Visible','Off')

set(handles.uipanel7,'Visible','Off')
set(handles.uipanel8,'Visible','Off')
set(handles.uipanel9,'Visible','Off')
set(handles.listbox2,'Visible','Off')
set(handles.listbox3,'Visible','Off')
set(handles.listbox4,'Visible','Off')
set(handles.listbox6,'Visible','On')
set(handles.pushbutton2,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.uipanel10,'Visible','Off')
set(handles.uipanel11,'Visible','Off')
set(handles.uipanel12,'Visible','Off')

set(handles.uipanel13,'Visible','Off')
set(handles.uipanel14,'Visible','Off')
set(handles.uipanel15,'Visible','Off')
set(handles.uipanel16,'Visible','Off')
set(handles.uipanel17,'Visible','Off')
set(handles.listbox5,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton9,'Visible','Off')
set(handles.pushbutton10,'Visible','Off')

set(handles.listbox6,'Visible','On')
set(handles.uipanel18,'Visible','On')
set(handles.uipanel19,'Visible','On')
set(handles.pushbutton11,'Visible','On')

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GMSTATE
GMSTATE.overworld=true;
close MainMenu;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
global ItemUseID Items
ItemUseID=get(handles.listbox1,'Value');

listing=listitems(Items);
set(handles.listbox1,'String',listing)

if isempty(ItemUseID)==1
    set(handles.pushbutton6,'Visible','Off')
elseif strcmp(listing,'Empty')
    set(handles.pushbutton6,'Visible','Off')
else
    set(handles.pushbutton6,'Visible','On')
end
clear have listing


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
global WeapEqID Weapons
WeapEqID=get(handles.listbox2,'Value');

have=find(Weapons.inv==1);
if isempty(have)==0
    for i=1:length(have)
        listing{i,:}=list(Weapons,have,i);
    end
else
    listing=sprintf('Empty');
end

if isempty(WeapEqID)==1
    set(handles.pushbutton2,'Visible','Off')
elseif strcmp(listing,'Empty')
    set(handles.pushbutton2,'Visible','Off')
elseif isempty(have)
    set(handles.pushbutton2,'Visible','Off')
else
    have=find(Weapons.inv==1);
    set(handles.text18,'String',Weapons.names{have(WeapEqID)})
    EStats=sprintf('H:%d  S:%d  W:%d  D:%d',Weapons.stats(have(WeapEqID),1),Weapons.stats(have(WeapEqID),3),Weapons.stats(have(WeapEqID),4),Weapons.stats(have(WeapEqID),5));
    set(handles.text19,'String',EStats)
    clear EStats
    set(handles.pushbutton2,'Visible','On')
end
clear have listing


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3
global ArmorEqID Armors
ArmorEqID=get(handles.listbox3,'Value');

have=find(Armors.inv==1);
if isempty(have)==0
    for i=1:length(have)
        listing{i,:}=list(Armors,have,i);
    end
else
    listing=sprintf('Empty');
end

if isempty(ArmorEqID)==1
    set(handles.pushbutton3,'Visible','Off')
elseif strcmp(listing,'Empty')
    set(handles.pushbutton3,'Visible','Off')
elseif isempty(have)
    set(handles.pushbutton3,'Visible','Off')
else
    set(handles.text20,'String',Armors.names{have(ArmorEqID)})
    EStats=sprintf('H:%d M:%d S:%d W:%d D:%d',Armors.stats(have(ArmorEqID),1),Armors.stats(have(ArmorEqID),2),Armors.stats(have(ArmorEqID),3),Armors.stats(have(ArmorEqID),4),Armors.stats(have(ArmorEqID),5));
    set(handles.text21,'String',EStats)
    clear EStats
    set(handles.pushbutton3,'Visible','On')
end
clear have listing

% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4
global AccEqID Accessories
AccEqID=get(handles.listbox4,'Value');

have=find(Accessories.inv==1);
if isempty(have)==0
    for i=1:length(have)
        listing{i,:}=list(Accessories,have,i);
    end
else
    listing=sprintf('Empty');
end

if isempty(AccEqID)==1
    set(handles.pushbutton4,'Visible','Off')
elseif strcmp(listing,'Empty')
    set(handles.pushbutton4,'Visible','Off')
elseif isempty(have)
    set(handles.pushbutton4,'Visible','Off')
else
    set(handles.text22,'String',Accessories.names{have(AccEqID)})
    EStats=sprintf('H:%d  S:%d  W:%d  D:%d',Accessories.stats(have(AccEqID),1),Accessories.stats(have(AccEqID),3),Accessories.stats(have(AccEqID),4),Accessories.stats(have(AccEqID),5));
    set(handles.text23,'String',EStats)
    clear EStats
    set(handles.pushbutton4,'Visible','On')
end
clear have listing

% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Weapons WeapEqID
[Player,Weapons]=equip(Weapons,Player,WeapEqID);
Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)
set(handles.text7,'String',Player.Strength)
set(handles.text9,'String',Player.Wisdom)
set(handles.text11,'String',Player.Defense)

set(handles.text12,'String',Weapons.equippedname)
EStats=sprintf('H:%d  S:%d  W:%d  D:%d',Weapons.equipped(1),Weapons.equipped(3),Weapons.equipped(4),Weapons.equipped(5));
set(handles.text13,'String',EStats)
clear EStats

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Armors ArmorEqID
[Player,Armors]=equip(Armors,Player,ArmorEqID);
Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)
set(handles.text7,'String',Player.Strength)
set(handles.text9,'String',Player.Wisdom)
set(handles.text11,'String',Player.Defense)

set(handles.text14,'String',Armors.equippedname)
EStats=sprintf('H:%d  S:%d  W:%d  D:%d',Armors.equipped(1),Armors.equipped(3),Armors.equipped(4),Armors.equipped(5));
set(handles.text15,'String',EStats)
clear EStats


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Accessories AccEqID
[Player,Accessories]=equip(Accessories,Player,AccEqID);
Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)
set(handles.text7,'String',Player.Strength)
set(handles.text9,'String',Player.Wisdom)
set(handles.text11,'String',Player.Defense)

set(handles.text16,'String',Accessories.equippedname)
EStats=sprintf('H:%d  S:%d  W:%d  D:%d',Accessories.equipped(1),Accessories.equipped(3),Accessories.equipped(4),Accessories.equipped(5));
set(handles.text17,'String',EStats)
clear EStats


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Weapons Armors Accessories Items Magic hardmode
save('RapidFantasySave','Player','Weapons','Armors','Accessories','Items','Magic','hardmode')


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Items ItemUseID

[Player,Items]=useitem(Player,Items,ItemUseID);

listing=listitems(Items);
ItemUseID=get(handles.listbox1,'Value');
if ItemUseID>length(listing)
    set(handles.listbox1,'Value',length(listing))
    ItemUseID=get(handles.listbox1,'Value');
end
set(handles.listbox1,'String',listing)

if strcmp(listing,'Empty')
    set(handles.pushbutton6,'Visible','Off')
else
    set(handles.pushbutton6,'Visible','On')
end
clear listing

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)
set(handles.text7,'String',Player.Strength)
set(handles.text9,'String',Player.Wisdom)
set(handles.text11,'String',Player.Defense)


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5
global MagicEqID Magic
MagicEqID=get(handles.listbox5,'Value');
have=find(Magic.inv==1);
set(handles.text32,'String',Magic.Names{have(MagicEqID)})
switch Magic.Element(have(MagicEqID))
    case 02
        EleText='Normal';
    case 03
        EleText='Fire';
    case 04
        EleText='Earth';
    case 05
        EleText='Lightning';
    case 06
        EleText='Water';
    case 07
        EleText='Light';
    case 08
        EleText='Dark';
end
MgcDes=sprintf('Element: %s\nTier: %d\nManaCost: %d',EleText,Magic.Tier(MagicEqID),Magic.ManaCost(MagicEqID));
set(handles.text33,'String',MgcDes)
clear MgcDes EleText

% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MagicEqID Magic
Slot=1;
Magic=swapmagic(Magic,Slot,MagicEqID);
switch Magic.Element(Magic.Current(Slot))
    case 02
        EleText='Normal';
    case 03
        EleText='Fire';
    case 04
        EleText='Earth';
    case 05
        EleText='Lightning';
    case 06
        EleText='Water';
    case 07
        EleText='Light';
    case 08
        EleText='Dark';
end
MgcDes=sprintf('Element: %s\nTier: %d\nManaCost: %d',EleText,Magic.Tier(Magic.Current(Slot)),Magic.ManaCost(Magic.Current(Slot)));
set(handles.text24,'String',Magic.Names{Magic.Current(Slot)})
set(handles.text25,'String',MgcDes)
clear MgcDes EleText Slot

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MagicEqID Magic
Slot=2;
Magic=swapmagic(Magic,Slot,MagicEqID);
switch Magic.Element(Magic.Current(Slot))
    case 02
        EleText='Normal';
    case 03
        EleText='Fire';
    case 04
        EleText='Earth';
    case 05
        EleText='Lightning';
    case 06
        EleText='Water';
    case 07
        EleText='Light';
    case 08
        EleText='Dark';
end
MgcDes=sprintf('Element: %s\nTier: %d\nManaCost: %d',EleText,Magic.Tier(Magic.Current(Slot)),Magic.ManaCost(Magic.Current(Slot)));
set(handles.text26,'String',Magic.Names{Magic.Current(Slot)})
set(handles.text27,'String',MgcDes)
clear MgcDes EleText Slot


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MagicEqID Magic
Slot=3;
Magic=swapmagic(Magic,Slot,MagicEqID);
switch Magic.Element(Magic.Current(Slot))
    case 02
        EleText='Normal';
    case 03
        EleText='Fire';
    case 04
        EleText='Earth';
    case 05
        EleText='Lightning';
    case 06
        EleText='Water';
    case 07
        EleText='Light';
    case 08
        EleText='Dark';
end
MgcDes=sprintf('Element: %s\nTier: %d\nManaCost: %d',EleText,Magic.Tier(Magic.Current(Slot)),Magic.ManaCost(Magic.Current(Slot)));
set(handles.text28,'String',Magic.Names{Magic.Current(Slot)})
set(handles.text29,'String',MgcDes)
clear MgcDes EleText Slot

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MagicEqID Magic
Slot=4;
Magic=swapmagic(Magic,Slot,MagicEqID);
switch Magic.Element(Magic.Current(Slot))
    case 02
        EleText='Normal';
    case 03
        EleText='Fire';
    case 04
        EleText='Earth';
    case 05
        EleText='Lightning';
    case 06
        EleText='Water';
    case 07
        EleText='Light';
    case 08
        EleText='Dark';
end
MgcDes=sprintf('Element: %s\nTier: %d\nManaCost: %d',EleText,Magic.Tier(Magic.Current(Slot)),Magic.ManaCost(Magic.Current(Slot)));
set(handles.text30,'String',Magic.Names{Magic.Current(Slot)})
set(handles.text31,'String',MgcDes)
clear MgcDes EleText Slot


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close Overworld
close MainMenu
run Introduction

% --- Executes on selection change in listbox6.
function listbox6_Callback(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox6
global LimitEqID LimitNames LimitDes Player
LimitEqID=get(handles.listbox6,'Value');
have=find(Player.UnlockedLimits==1);
set(handles.text36,'String',LimitNames{have(LimitEqID)})
set(handles.text37,'String',LimitDes{have(LimitEqID)})


% --- Executes during object creation, after setting all properties.
function listbox6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player LimitEqID LimitDes LimitNames
Player.CurrentLimit=LimitEqID;
set(handles.text34,'String',LimitNames(Player.CurrentLimit))
set(handles.text35,'String',LimitDes(Player.CurrentLimit))


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global GMSTATE
if eventdata.Key=='m'
    GMSTATE.overworld=true;
    close MainMenu
end