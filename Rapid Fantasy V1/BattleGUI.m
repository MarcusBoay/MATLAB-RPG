function varargout = BattleGUI(varargin)
% TEST_BATTLEGUI MATLAB code for BattleGUI.fig
%      TEST_BATTLEGUI, by itself, creates a new TEST_BATTLEGUI or raises the existing
%      singleton*.
%
%      H = TEST_BATTLEGUI returns the handle to a new TEST_BATTLEGUI or the handle to
%      the existing singleton*.
%
%      TEST_BATTLEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST_BATTLEGUI.M with the given input arguments.
%
%      TEST_BATTLEGUI('Property','Value',...) creates a new TEST_BATTLEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BattleGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BattleGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BattleGUI

% Last Modified by GUIDE v2.5 28-Mar-2016 17:39:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BattleGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @BattleGUI_OutputFcn, ...
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


% --- Executes just before BattleGUI is made visible.
function BattleGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BattleGUI (see VARARGIN)
global Player Block CloseCheck Mob

Block=0;
CloseCheck=0;

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
axes(handles.axes1);
image([0 10],[0 10],imread('limit_bar_empty.png'));
axis off
axes(handles.axes2);
image([0 10],[0 10],imread('player_battle.png'));
axis off
axes(handles.axes3);
image([0 10],[0 10],Mob.Image);
axis off
axes(handles.axes4);
if Player.LimitBar~=0;
    image([0 Player.LimitBar],[0 1],imread('limit_bar.png'));
end
axis([0 100 0 1]);
set(gca,'YTickLabel',{''})
set(gca,'XTickLabel',{''})
set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.listbox1,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')

if Mob.ID==12
    set(handles.text10,'String','Behold the conquerer of the skies')
    pause(2.0)
    set(handles.text10,'String','')
end
% Choose default command line output for BattleGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BattleGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BattleGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function [defender,attacker,handles]=mobphysdmg(defender,attacker,handles)
global Damage CloseCheck Magic
    Damage=(1.5)*attacker.Strength;
    Damage=Damage-(((defender.Defense)/300)*Damage+defender.Defense);
    Damage=round(Damage);
    if Damage>0
        defender.Health=defender.Health-Damage;
    else
        Damage=0;
    end
    if defender.Health<0
        defender.Health=0;
    end
    set(handles.text10,'String',['You Dealt ' num2str(round(Damage)) ' To Enemy'])
    pause(1.0)
    if defender.Health==0
        [attacker,defender,Magic,CloseCheck,handles]=WinOrDefeat(defender,attacker,Magic,handles);
    else
        CloseCheck=0;
    end

function [defender,attacker,handles]=LimitBreak(defender,attacker,handles)
global CloseCheck Magic
    switch attacker.CurrentLimit
        case 1
            Damage=40+1.5*attacker.Strength;
            LimitName='Sonic Spike';
        case 2
            Damage=80+2.0*attacker.Strength;
            LimitName='Sword Dance';
        case 3
            Damage=120+2.5*attacker.Strength;
            LimitName='Oblivion Strike';
    end
    if (Damage-defender.Defense)>0
        FinalDamage=Damage-(((defender.Defense)/300)*Damage+defender.Defense);
    else
        FinalDamage=0;
    end
    FinalDamage=round(FinalDamage);
    defender.Health=defender.Health-FinalDamage;
    LimitMessage=sprintf('You used %s and dealt %d to enemy!',LimitName,round(FinalDamage));
    attacker.LimitBar=0;
    axes(handles.axes4);
    if attacker.LimitBar~=0;
        image([0 attacker.LimitBar],[0 1],imread('limit_bar.png'));
    else 
        image([0 100],[0 1],imread('limit_bar_empty.png'));
    end
    axis([0 100 0 1]);
    set(gca,'YTickLabel',{''})
    set(gca,'XTickLabel',{''})
    if defender.Health<0
        defender.Health=0;
    end
    set(handles.text10,'String',LimitMessage)
    set(handles.pushbutton1,'String','Attack')
    pause(1.0)
    if defender.Health==0
        [attacker,defender,Magic,CloseCheck,handles]=WinOrDefeat(defender,attacker,Magic,handles);
    else
        CloseCheck=0;
    end
    

function [defender,attacker,handles]=playerphysdmg(defender,attacker,handles)
global Block Damage CloseCheck Magic
AtkSelect=0;
    if Block==1
        AtkSelectCounter=0;
        while AtkSelect==0
        AtkNumber=randi(10);
        AtkSelectCounter=AtkSelectCounter+1;
        if AtkSelectCounter>5
            AtkNumber=1;
        end
        switch AtkNumber
            case 1
                if isempty(attacker.Atk1)
                    AtkSelect=0;
                else
                    AtkSelect=1;
                    if (attacker.Mana-attacker.Atk1.MPuse)>=0
                        if attacker.Atk1.MPuse>0
                            attacker.Mana=attacker.Mana-attacker.Atk1.MPuse;
                            if attacker.Mana<0
                                attacker.Mana=0;
                            end
                            Damage=attacker.Atk1.Damage;
                            Damage=Damage-.4*(((defender.Defense)/300)*Damage+defender.Defense);
                        else
                            Damage=attacker.Atk1.Damage;
                            Damage=Damage-2*(((defender.Defense)/300)*Damage+defender.Defense);
                        end
                        if Damage<0
                            Damage=0;
                        else
                            Damage=round(Damage);
                        end
                        BattleMessage=sprintf('%s used %s\nYou took %d damage',attacker.Name,attacker.Atk1.Name,Damage);
                        set(handles.text10,'String',BattleMessage)
                    else
                        AtkSelect=0;
                    end
                end
              case 2
                if isempty(attacker.Atk2)
                    AtkSelect=0;
                else
                    AtkSelect=1;
                   if (attacker.Mana-attacker.Atk2.MPuse)>=0
                        if attacker.Atk2.MPuse>0
                            attacker.Mana=attacker.Mana-attacker.Atk2.MPuse;
                            if attacker.Mana<0
                                attacker.Mana=0;
                            end
                            Damage=attacker.Atk2.Damage;
                            Damage=Damage-.4*(((defender.Defense)/300)*Damage+defender.Defense);
                        else
                            Damage=attacker.Atk2.Damage;
                            Damage=Damage-2*(((defender.Defense)/300)*Damage+defender.Defense);
                        end
                      if Damage<0
                            Damage=0;
                      else
                          Damage=round(Damage);
                      end
                      BattleMessage=sprintf('%s used %s\nYou took %d damage',attacker.Name,attacker.Atk2.Name,Damage);
                      set(handles.text10,'String',BattleMessage)
                   else
                        AtkSelect=0;
                   end
                end
                case 3
                if isempty(attacker.Atk3)
                    AtkSelect=0;
                else
                    AtkSelect=1;
                    if (attacker.Mana-attacker.Atk3.MPuse)>=0
                        if attacker.Atk3.MPuse>0
                            attacker.Mana=attacker.Mana-attacker.Atk3.MPuse;
                            if attacker.Mana<0
                                attacker.Mana=0;
                            end
                            Damage=attacker.Atk3.Damage;
                            Damage=Damage-.4*(((defender.Defense)/300)*Damage+defender.Defense);
                        else
                            Damage=attacker.Atk3.Damage;
                            Damage=Damage-2*(((defender.Defense)/300)*Damage+defender.Defense);
                        end
                        if Damage<0
                            Damage=0;
                        else
                            Damage=round(Damage);
                        end
                        BattleMessage=sprintf('%s used %s\nYou took %d damage',attacker.Name,attacker.Atk3.Name,Damage);
                        set(handles.text10,'String',BattleMessage)
                    else
                        AtkSelect=0;
                    end
                end
                case 4
                if isempty(attacker.Atk4)
                    AtkSelect=0;
                else
                    AtkSelect=1;
                    if (attacker.Mana-attacker.Atk4.MPuse)>=0
                        if attacker.Atk4.MPuse>0
                            attacker.Mana=attacker.Mana-attacker.Atk4.MPuse;
                            if attacker.Mana<0
                                attacker.Mana=0;
                            end
                            Damage=attacker.Atk4.Damage;
                            Damage=Damage-.4*(((defender.Defense)/300)*Damage+defender.Defense);
                        else
                            Damage=attacker.Atk4.Damage;
                            Damage=Damage-2*(((defender.Defense)/300)*Damage+defender.Defense);
                        end
                        if Damage<0
                            Damage=0;
                        else
                            Damage=round(Damage);
                        end
                        BattleMessage=sprintf('%s used %s\nYou took %d damage',attacker.Name,attacker.Atk4.Name,Damage);
                        set(handles.text10,'String',BattleMessage)
                    else
                        AtkSelect=0;
                    end
                end
                case 5
                if isempty(attacker.Atk5)
                    AtkSelect=0;
                else
                    AtkSelect=1;
                    if (attacker.Mana-attacker.Atk5.MPuse)>=0
                        if attacker.Atk5.MPuse>0
                            attacker.Mana=attacker.Mana-attacker.Atk5.MPuse;
                            if attacker.Mana<0
                                attacker.Mana=0;
                            end
                            Damage=attacker.Atk5.Damage;
                            Damage=Damage-.4*(((defender.Defense)/300)*Damage+defender.Defense);
                        else
                            Damage=attacker.Atk5.Damage;
                            Damage=Damage-2*(((defender.Defense)/300)*Damage+defender.Defense);
                        end
                        if Damage<0
                            Damage=0;
                        else
                            Damage=round(Damage);
                        end
                        BattleMessage=sprintf('%s used %s\nYou took %d damage',attacker.Name,attacker.Atk5.Name,Damage);
                        set(handles.text10,'String',BattleMessage)
                    else
                        AtkSelect=0;
                    end
                end
        end
        end
    else
        AtkSelectCounter=0;
        while AtkSelect==0
        AtkNumber=randi(10);
        AtkSelectCounter=AtkSelectCounter+1;
        if AtkSelectCounter>5
            AtkNumber=1;
        end
        switch AtkNumber
            case 1
                if isempty(attacker.Atk1)
                    AtkSelect=0;
                else
                    AtkSelect=1;
                    if (attacker.Mana-attacker.Atk1.MPuse)>=0
                        if attacker.Atk1.MPuse>0
                            attacker.Mana=attacker.Mana-attacker.Atk1.MPuse;
                            if attacker.Mana<0
                                attacker.Mana=0;
                            end
                            Damage=attacker.Atk1.Damage;
                            Damage=Damage-.2*(((defender.Defense)/300)*Damage+defender.Defense);
                        else
                            Damage=attacker.Atk1.Damage;
                            Damage=Damage-(((defender.Defense)/300)*Damage+defender.Defense);
                        end
                        if Damage<0
                            Damage=0;
                        else
                            Damage=round(Damage);
                        end
                        BattleMessage=sprintf('%s used %s\nYou took %d damage',attacker.Name,attacker.Atk1.Name,Damage);
                        set(handles.text10,'String',BattleMessage)
                    else
                        AtkSelect=0;
                    end
                end
              case 2
                if isempty(attacker.Atk2)
                    AtkSelect=0;
                else
                    AtkSelect=1;
                   if (attacker.Mana-attacker.Atk2.MPuse)>=0
                         if attacker.Atk2.MPuse>0
                            attacker.Mana=attacker.Mana-attacker.Atk2.MPuse;
                            if attacker.Mana<0
                                attacker.Mana=0;
                            end
                            Damage=attacker.Atk2.Damage;
                            Damage=Damage-.2*(((defender.Defense)/300)*Damage+defender.Defense);
                        else
                            Damage=attacker.Atk2.Damage;
                            Damage=Damage-(((defender.Defense)/300)*Damage+defender.Defense);
                        end
                      if Damage<0
                            Damage=0;
                      else
                          Damage=round(Damage);
                      end
                      BattleMessage=sprintf('%s used %s\nYou took %d damage',attacker.Name,attacker.Atk2.Name,Damage);
                      set(handles.text10,'String',BattleMessage)
                   else
                        AtkSelect=0;
                   end
                end
                case 3
                if isempty(attacker.Atk3)
                    AtkSelect=0;
                else
                    AtkSelect=1;
                    if (attacker.Mana-attacker.Atk3.MPuse)>=0
                        if attacker.Atk3.MPuse>0
                            attacker.Mana=attacker.Mana-attacker.Atk3.MPuse;
                            if attacker.Mana<0
                                attacker.Mana=0;
                            end
                            Damage=attacker.Atk3.Damage;
                            Damage=Damage-.2*(((defender.Defense)/300)*Damage+defender.Defense);
                        else
                            Damage=attacker.Atk3.Damage;
                            Damage=Damage-(((defender.Defense)/300)*Damage+defender.Defense);
                        end
                        if Damage<0
                            Damage=0;
                        else
                            Damage=round(Damage);
                        end
                        BattleMessage=sprintf('%s used %s\nYou took %d damage',attacker.Name,attacker.Atk3.Name,Damage);
                        set(handles.text10,'String',BattleMessage)
                    else
                        AtkSelect=0;
                    end
                end
                case 4
                if isempty(attacker.Atk4)
                    AtkSelect=0;
                else
                    AtkSelect=1;
                    if (attacker.Mana-attacker.Atk4.MPuse)>=0
                        if attacker.Atk4.MPuse>0
                            attacker.Mana=attacker.Mana-attacker.Atk4.MPuse;
                            if attacker.Mana<0
                                attacker.Mana=0;
                            end
                            Damage=attacker.Atk4.Damage;
                            Damage=Damage-.2*(((defender.Defense)/300)*Damage+defender.Defense);
                        else
                            Damage=attacker.Atk4.Damage;
                            Damage=Damage-(((defender.Defense)/300)*Damage+defender.Defense);
                        end
                        if Damage<0
                            Damage=0;
                        else
                            Damage=round(Damage);
                        end
                        BattleMessage=sprintf('%s used %s\nYou took %d damage',attacker.Name,attacker.Atk4.Name,Damage);
                        set(handles.text10,'String',BattleMessage)
                    else
                        AtkSelect=0;
                    end
                end
                case 5
                if isempty(attacker.Atk5)
                    AtkSelect=0;
                else
                    AtkSelect=1;
                    if (attacker.Mana-attacker.Atk5.MPuse)>=0
                        if attacker.Atk5.MPuse>0
                            attacker.Mana=attacker.Mana-attacker.Atk5.MPuse;
                            if attacker.Mana<0
                                attacker.Mana=0;
                            end
                            Damage=attacker.Atk5.Damage;
                            Damage=Damage-.2*(((defender.Defense)/300)*Damage+defender.Defense);
                        else
                            Damage=attacker.Atk5.Damage;
                            Damage=Damage-(((defender.Defense)/300)*Damage+defender.Defense);
                        end
                        if Damage<0
                            Damage=0;
                        else
                            Damage=round(Damage);
                        end
                        BattleMessage=sprintf('%s used %s\nYou took %d damage',attacker.Name,attacker.Atk5.Name,Damage);
                        set(handles.text10,'String',BattleMessage)
                    else
                        AtkSelect=0;
                    end
                end
        end
        end
    end
    defender.Health=defender.Health-Damage;
    if defender.Health<0
        defender.Health=0;
    end
    pause(1.0)
    if defender.Health==0
        [attacker,defender,Magic,CloseCheck,handles]=WinOrDefeat(defender,attacker,Magic,handles);
    end
    
function [attacker,defender,playmagic,CloseCheck,handles]=WinOrDefeat(defender,attacker,playmagic,handles)
global Map Items Weapons Armors Accessories Mob Player
if isa(defender,'mob')
    if defender.ID<12
    
    WinMessage=sprintf('You have defeated %s!',defender.Name);
    set(handles.text10,'String',WinMessage)
    
    pause(1.0)
    
    WinMessage=sprintf('You gained %d experience',defender.Experience);
    set(handles.text10,'String',WinMessage)
    
    pause(0.5)
    
    attacker.Experience=attacker.Experience+defender.Experience;
    
    [attacker,playmagic,WinMessage]=levelup(attacker,playmagic);
    if ~strcmp(WinMessage,'No Level Up')
        set(handles.text10,'String',WinMessage)
        pause(1.0)
        switch attacker.Level
            case 2
                WinMessage=sprintf('You have grown stronger!\nYou can now use Tier 2 Magic');
            case 3
                WinMessage=sprintf('You have broken to new limits!\nYou have unlocked "Sword Dance"\n');
            case 4
                WinMessage=sprintf('You have grown stronger!\nYou can now use Tier 3 Magic');
            case 5
                WinMessage=sprintf('You have broken to new limits!\nYou have unlocked "Oblivion Strike"\n');
        end
        set(handles.text10,'String',WinMessage)
        Hdisp=sprintf('%d/%d',attacker.Health,attacker.MaxHealth);
        set(handles.text3,'String',Hdisp)
        Mdisp=sprintf('%d/%d',attacker.Mana,attacker.MaxMana);
        set(handles.text5,'String',Mdisp)
    end

    pause(1.0)
    
    switch Map.mapindex
        case 2
            if randi(3)>1
                switch randi(10)
                    case {1 6}
                        ItemDropID=1;
                    case {7 10}
                        ItemDropID=2;
                    otherwise
                        ItemDropID=1;
                end
                [Items,GainItemMessage]=gainitems(Items,ItemDropID,randi([1 5]));
                set(handles.text10,'String',GainItemMessage)
            end
        case 3
            if randi(3)>1
                switch randi(10)
                    case {1 6}
                        ItemDropID=3;
                    case {7 10}
                        ItemDropID=4;
                    otherwise
                        ItemDropID=3;
                end
                [Items,GainItemMessage]=gainitems(Items,ItemDropID,randi([1 5]));
                set(handles.text10,'String',GainItemMessage)
            end
        case 4
            if randi(3)>1
                switch randi(10)
                    case {1 6}
                        ItemDropID=5;
                    case {7 10}
                        ItemDropID=6;
                    otherwise
                        ItemDropID=5;
                end
                [Items,GainItemMessage]=gainitems(Items,ItemDropID,randi([1 5]));
                set(handles.text10,'String',GainItemMessage)
            end
        case 5
            if randi(3)>1
                switch randi(10)
                    case {1 6}
                        ItemDropID=7;
                    case {7 10}
                        ItemDropID=8;
                    otherwise
                        ItemDropID=7;
                end
                [Items,GainItemMessage]=gainitems(Items,ItemDropID,randi([1 5]));
                set(handles.text10,'String',GainItemMessage)
            end
        case 6
            if randi(3)>1
                switch randi(10)
                    case {1 6}
                        ItemDropID=9;
                    case {7 10}
                        ItemDropID=10;
                    otherwise
                        ItemDropID=9;
                end
                [Items,GainItemMessage]=gainitems(Items,ItemDropID,randi([1 5]));
                set(handles.text10,'String',GainItemMessage)
            end
    end
    
    pause(1.0)
    switch Map.mapindex
        case 2
            if randi(10)>=7
                switch randi(3)
                    case 1
                        EquipmentDropID=randi([1 3]);
                        if Weapons.inv(EquipmentDropID)==0
                        [Weapons,GainEquipmentMessage]=gain(Weapons,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                    case 2
                        EquipmentDropID=randi([1 3]);
                        if Armors.inv(EquipmentDropID)==0
                        [Armors,GainEquipmentMessage]=gain(Armors,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                    case 3
                        EquipmentDropID=randi([1 3]);
                        if Accessories.inv(EquipmentDropID)==0
                        [Accessories,GainEquipmentMessage]=gain(Accessories,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                end
            end
        case 3
            if randi(10)>=7
                switch randi(3)
                    case 1
                        EquipmentDropID=randi([1 3]);
                        if Weapons.inv(EquipmentDropID)==0
                        [Weapons,GainEquipmentMessage]=gain(Weapons,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                    case 2
                        EquipmentDropID=randi([1 3]);
                        if Armors.inv(EquipmentDropID)==0
                        [Armors,GainEquipmentMessage]=gain(Armors,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                    case 3
                        EquipmentDropID=randi([1 3]);
                        if Accessories.inv(EquipmentDropID)==0
                        [Accessories,GainEquipmentMessage]=gain(Accessories,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                end
            end
        case 4
            if randi(10)>=7
                switch randi(3)
                    case 1
                        EquipmentDropID=randi([4 6]);
                        if Weapons.inv(EquipmentDropID)==0
                        [Weapons,GainEquipmentMessage]=gain(Weapons,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                    case 2
                        EquipmentDropID=randi([4 6]);
                        if Armors.inv(EquipmentDropID)==0
                        [Armors,GainEquipmentMessage]=gain(Armors,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                    case 3
                        EquipmentDropID=randi([4 6]);
                        if Accessories.inv(EquipmentDropID)==0
                        [Accessories,GainEquipmentMessage]=gain(Accessories,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                end
            end
        case 5
            if randi(10)>=7
                switch randi(3)
                    case 1
                        EquipmentDropID=randi([4 6]);
                        if Weapons.inv(EquipmentDropID)==0
                        [Weapons,GainEquipmentMessage]=gain(Weapons,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                    case 2
                        EquipmentDropID=randi([4 6]);
                        if Armors.inv(EquipmentDropID)==0
                        [Armors,GainEquipmentMessage]=gain(Armors,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                    case 3
                        EquipmentDropID=randi([4 6]);
                        if Accessories.inv(EquipmentDropID)==0
                        [Accessories,GainEquipmentMessage]=gain(Accessories,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                end
            end
        case 6
            if randi(10)>=7
                switch randi(3)
                    case 1
                        EquipmentDropID=randi([7 9]);
                        if Weapons.inv(EquipmentDropID)==0
                        [Weapons,GainEquipmentMessage]=gain(Weapons,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                    case 2
                        EquipmentDropID=randi([7 9]);
                        if Armors.inv(EquipmentDropID)==0
                        [Armors,GainEquipmentMessage]=gain(Armors,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                    case 3
                        EquipmentDropID=randi([7 9]);
                        if Accessories.inv(EquipmentDropID)==0
                        [Accessories,GainEquipmentMessage]=gain(Accessories,EquipmentDropID);
                        set(handles.text10,'String',GainEquipmentMessage)
                        end
                end
            end
    end          
    CloseCheck=1;
    elseif defender.ID==12
        mobs
        defender=Mob13;
        axes(handles.axes3);
        image([0 10],[0 10],defender.Image);
        axis off
        BossMessage=sprintf('Plan B stands for Balloon');
        set(handles.text10,'String',BossMessage)
        pause(1.5)
        CloseCheck=0;
    elseif defender.ID==13
        mobs
        defender=Mob14;
        axes(handles.axes3);
        image([0 10],[0 10],defender.Image);
        axis off
        BossMessage=sprintf('I''ll settle for conquerer of the land');
        set(handles.text10,'String',BossMessage)
        pause(1.5)
        CloseCheck=0;
    elseif defender.ID==14
        BossMessage=sprintf('You Beat The Game!');
        set(handles.text10,'String',BossMessage)
        pause(1.5)
        CloseCheck=3;
    end
elseif isa(defender,'player')
    set(handles.text10,'String','You have died')
    pause(1.0)
    CloseCheck=2;
end

function Damage=ElementSystem(defender,MagicDamage,Slot)
global Magic
%ElementSystem
%01 = dummy value
%02=normal, 03=fire, 04=earth, 05=lightning, 06=water, 07=light, 08=dark
%20=no effect, 21=damage x1, 22=damage x2.0,23=absorb x1,24=damage x0.5
ElementTable=...
  [01 02 03 04 05 06 07 08;
   02 21 21 21 21 21 21 21;...
   03 21 23 22 21 24 21 21;...
   04 21 24 23 22 21 21 21;...
   05 21 21 24 23 22 21 21;...
   06 21 22 21 24 23 21 21;...
   07 21 21 21 21 21 23 22;...
   08 21 21 21 21 21 22 23];
ElementCheckPlayer=ElementTable(Magic.Element(Magic.Current(Slot)),defender.Element);
switch ElementCheckPlayer
    case 20
        Damage=0;
    case 21
        Damage=MagicDamage;
    case 22
        Damage=MagicDamage*2.0;
    case 23
        Damage=MagicDamage*-1;
    case 24
        Damage=MagicDamage*0.5;
end


function [defender,attacker,handles]=usemagic(defender,attacker,handles,Slot)
global Magic Damage CloseCheck
if Magic.Current(Slot)==1
    run Scan
    attacker.Mana=attacker.Mana-Magic.ManaCost(Magic.Current(Slot));
    waitfor(Scan)
    if defender.Health==0
        [attacker,defender,Magic,CloseCheck,handles]=WinOrDefeat(defender,attacker,Magic,handles);
    end
else
    switch Magic.Tier(Magic.Current(Slot))
        case 1
            attacker.Mana=attacker.Mana-Magic.ManaCost(Magic.Current(Slot));
            MagicDamage=5+0.8*attacker.Wisdom;
            Damage=ElementSystem(defender,round(MagicDamage),Slot);
        case 2
            attacker.Mana=attacker.Mana-Magic.ManaCost(Magic.Current(Slot));
            MagicDamage=15+1.0*attacker.Wisdom;
            Damage=ElementSystem(defender,round(MagicDamage),Slot);
        case 3
            attacker.Mana=attacker.Mana-Magic.ManaCost(Magic.Current(Slot));
            MagicDamage=45+1.2*attacker.Wisdom;
            Damage=ElementSystem(defender,round(MagicDamage),Slot);
    end
    Damage=Damage-.2*(((defender.Defense)/300)*Damage+defender.Defense);
    Damage=round(Damage);
    if Damage>=0
    	MagicMessage=sprintf('You used %s\nYou dealt %d to %s\n',Magic.Names{Magic.Current(Slot)},Damage,defender.Name);
    else
    	MagicMessage=sprintf('You used %s\nYou healed %d to %s\n',Magic.Names{Magic.Current(Slot)},Damage*-1,defender.Name);
    end
    defender.Health=defender.Health-Damage;
    if defender.Health<0
        defender.Health=0;
    end
    if defender.Health>defender.MaxHealth
        defender.Health=defender.MaxHealth;
    end
    set(handles.text10,'String',MagicMessage)
    pause(1.0)
    if defender.Health==0
        [attacker,defender,Magic,CloseCheck,handles]=WinOrDefeat(defender,attacker,Magic,handles);
    end
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Mob Block Damage CloseCheck GMSTATE
Block=0;
set(handles.pushbutton1,'Visible','Off')
set(handles.togglebutton3,'Visible','Off')
set(handles.togglebutton1,'Visible','Off')
set(handles.togglebutton2,'Visible','Off')
set(handles.togglebutton1,'Value',0)
set(handles.togglebutton2,'Value',0)
set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.listbox1,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')

if Player.LimitBar==100
    [Mob,Player,handles]=LimitBreak(Mob,Player,handles);
else
    [Mob,Player,handles]=mobphysdmg(Mob,Player,handles);
end

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Mob.Health>0
    [Player,Mob,handles]=playerphysdmg(Player,Mob,handles);
    Player.LimitBar=Player.LimitBar+round(2*(Damage/Player.MaxHealth)*100);
    if Player.LimitBar>100
        Player.LimitBar=100;
    end
    axes(handles.axes4);
    
    image([0 Player.LimitBar],[0 1],imread('limit_bar.png'));
    axis([0 100 0 1]);
    set(gca,'YTickLabel',{''})
    set(gca,'XTickLabel',{''})
end

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)
pause(1.0)

if Player.LimitBar==100
    set(handles.pushbutton1,'String','Limit Break!')
end
set(handles.text10,'String','')
set(handles.pushbutton1,'Visible','On')
set(handles.togglebutton3,'Visible','On')
set(handles.togglebutton1,'Visible','On')
set(handles.togglebutton2,'Visible','On')

switch CloseCheck
    case 1
        GMSTATE.overworld=true;
        music(2);        
        close BattleGUI
    case 2
        close Overworld
        close BattleGUI
        run GameOver
        music(5)
    case 3
        close Overworld
        close BattleGUI
        run Credits
end


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Items Player ItemUseID Block

Block=0;

set(handles.listbox1,'Value',1)
ItemUseID=get(handles.listbox1,'Value');

listing=listitems(Items);
if strcmp(listing,'Empty')
    set(handles.pushbutton8,'Visible','Off')
else
    set(handles.pushbutton8,'Visible','On')
end
set(handles.listbox1,'String',listing)
clear listing

if isempty(find(Items.amount>0))==1
    set(handles.pushbutton8,'Visible','Off')
end

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

set(handles.uipanel2,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.uipanel3,'Visible','On')    
set(handles.listbox1,'Visible','On')
set(handles.togglebutton1,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.pushbutton2,'Visible','On')


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
guidata(hObject,handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Magic

if Magic.Current(1)==0
    set(handles.pushbutton3,'String','')
else
    MgcDes=sprintf('%s     Cost: %d',Magic.Names{Magic.Current(1)},Magic.ManaCost(Magic.Current(1)));
    set(handles.pushbutton3,'String',MgcDes)
    clear MgcDes
end
if Magic.Current(2)==0
    set(handles.pushbutton4,'String','')
else
    MgcDes=sprintf('%s     Cost: %d',Magic.Names{Magic.Current(2)},Magic.ManaCost(Magic.Current(2)));
    set(handles.pushbutton4,'String',MgcDes)
    clear MgcDes
end
if Magic.Current(3)==0
    set(handles.pushbutton5,'String','')
else
    MgcDes=sprintf('%s     Cost: %d',Magic.Names{Magic.Current(3)},Magic.ManaCost(Magic.Current(3)));
    set(handles.pushbutton5,'String',MgcDes)
end
if Magic.Current(4)==0
    set(handles.pushbutton6,'String','')
else
    MgcDes=sprintf('%s     Cost: %d',Magic.Names{Magic.Current(4)},Magic.ManaCost(Magic.Current(4)));
    set(handles.pushbutton6,'String',MgcDes)
end


set(handles.uipanel2,'Visible','On')
set(handles.pushbutton3,'Visible','On')
set(handles.pushbutton4,'Visible','On')
set(handles.pushbutton5,'Visible','On')
set(handles.pushbutton6,'Visible','On')
set(handles.uipanel3,'Visible','Off')    
set(handles.listbox1,'Visible','Off')
set(handles.togglebutton2,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')

% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Items Player ItemUseID

set(handles.listbox1,'Value',1)
ItemUseID=get(handles.listbox1,'Value');

listing=listitems(Items);
if strcmp(listing,'Empty')
    set(handles.pushbutton7,'Visible','Off')
else
    set(handles.pushbutton7,'Visible','On')
end
set(handles.listbox1,'String',listing)
clear listing

if isempty(find(Items.amount>0))==1
    set(handles.pushbutton7,'Visible','Off')
end

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

set(handles.uipanel2,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.uipanel3,'Visible','On')    
set(handles.listbox1,'Visible','On')
set(handles.togglebutton1,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.pushbutton2,'Visible','Off')

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Magic Mob Damage CloseCheck GMSTATE Block
Slot=1;
if Magic.Current(Slot)~=0 && (Player.Mana-Magic.ManaCost(Magic.Current(Slot)))>=0
set(handles.pushbutton1,'Visible','Off')
set(handles.togglebutton3,'Visible','Off')
set(handles.togglebutton1,'Visible','Off')
set(handles.togglebutton2,'Visible','Off')
set(handles.togglebutton1,'Value',0)
set(handles.togglebutton2,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.listbox1,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')

Block=0;

[Mob,Player]=usemagic(Mob,Player,handles,Slot);

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Mob.Health>0
    [Player,Mob,handles]=playerphysdmg(Player,Mob,handles);
    Player.LimitBar=Player.LimitBar+round(2*(Damage/Player.MaxHealth)*100);
    if Player.LimitBar>100
        Player.LimitBar=100;
    end
    axes(handles.axes4);
    
    image([0 Player.LimitBar],[0 1],imread('limit_bar.png'));
    axis([0 100 0 1]);
    set(gca,'YTickLabel',{''})
    set(gca,'XTickLabel',{''})
end

if Player.LimitBar==100
    set(handles.pushbutton1,'String','Limit Break!')
end
set(handles.text10,'String','')
set(handles.pushbutton1,'Visible','On')
set(handles.togglebutton3,'Visible','On')
set(handles.togglebutton1,'Visible','On')
set(handles.togglebutton2,'Visible','On')

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

switch CloseCheck
    case 1
        GMSTATE.overworld=true;
        music(2);
        close BattleGUI
    case 2
        close Overworld
        close BattleGUI
        run GameOver
        music(5)
    case 3
        close Overworld
        close BattleGUI
        run Credits
end
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Magic Mob Damage CloseCheck GMSTATE Block
Slot=2;
if Magic.Current(Slot)~=0 && (Player.Mana-Magic.ManaCost(Magic.Current(Slot)))>=0
set(handles.pushbutton1,'Visible','Off')
set(handles.togglebutton3,'Visible','Off')
set(handles.togglebutton1,'Visible','Off')
set(handles.togglebutton2,'Visible','Off')
set(handles.togglebutton1,'Value',0)
set(handles.togglebutton2,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.listbox1,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')

Block=0;

[Mob,Player]=usemagic(Mob,Player,handles,Slot);

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Mob.Health>0
    [Player,Mob,handles]=playerphysdmg(Player,Mob,handles);
    Player.LimitBar=Player.LimitBar+round(2*(Damage/Player.MaxHealth)*100);
    if Player.LimitBar>100
        Player.LimitBar=100;
    end
    axes(handles.axes4);
    
    image([0 Player.LimitBar],[0 1],imread('limit_bar.png'));
    axis([0 100 0 1]);
    set(gca,'YTickLabel',{''})
    set(gca,'XTickLabel',{''})
end

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Player.LimitBar==100
    set(handles.pushbutton1,'String','Limit Break!')
end
set(handles.text10,'String','')
set(handles.pushbutton1,'Visible','On')
set(handles.togglebutton3,'Visible','On')
set(handles.togglebutton1,'Visible','On')
set(handles.togglebutton2,'Visible','On')

switch CloseCheck
    case 1
        GMSTATE.overworld=true;
        music(2);
        close BattleGUI
    case 2
        close Overworld
        close BattleGUI
        run GameOver
        music(5)
    case 3
        close Overworld
        close BattleGUI
        run Credits
end
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Magic Mob Damage CloseCheck GMSTATE Block
Slot=3;
if Magic.Current(Slot)~=0 && (Player.Mana-Magic.ManaCost(Magic.Current(Slot)))>=0
set(handles.pushbutton1,'Visible','Off')
set(handles.togglebutton3,'Visible','Off')
set(handles.togglebutton1,'Visible','Off')
set(handles.togglebutton2,'Visible','Off')
set(handles.togglebutton1,'Value',0)
set(handles.togglebutton2,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.listbox1,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')

Block=0;

[Mob,Player]=usemagic(Mob,Player,handles,Slot);

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Mob.Health>0
    [Player,Mob,handles]=playerphysdmg(Player,Mob,handles);
    Player.LimitBar=Player.LimitBar+round(2*(Damage/Player.MaxHealth)*100);
    if Player.LimitBar>100
        Player.LimitBar=100;
    end
    axes(handles.axes4);
    
    image([0 Player.LimitBar],[0 1],imread('limit_bar.png'));
    axis([0 100 0 1]);
    set(gca,'YTickLabel',{''})
    set(gca,'XTickLabel',{''})
end

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Player.LimitBar==100
    set(handles.pushbutton1,'String','Limit Break!')
end
set(handles.text10,'String','')
set(handles.pushbutton1,'Visible','On')
set(handles.togglebutton3,'Visible','On')
set(handles.togglebutton1,'Visible','On')
set(handles.togglebutton2,'Visible','On')

switch CloseCheck
    case 1
        GMSTATE.overworld=true;
        music(2);
        close BattleGUI
    case 2
        close Overworld
        close BattleGUI
        run GameOver
        music(5)
    case 3
        close Overworld
        close BattleGUI
        run Credits
end
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Magic Mob Damage CloseCheck GMSTATE Block
Slot=4;
if Magic.Current(Slot)~=0 && (Player.Mana-Magic.ManaCost(Magic.Current(Slot)))>=0
set(handles.pushbutton1,'Visible','Off')
set(handles.togglebutton3,'Visible','Off')
set(handles.togglebutton1,'Visible','Off')
set(handles.togglebutton2,'Visible','Off')
set(handles.togglebutton1,'Value',0)
set(handles.togglebutton2,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.listbox1,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')

Block=0;

[Mob,Player]=usemagic(Mob,Player,handles,Slot);

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Mob.Health>0
    [Player,Mob,handles]=playerphysdmg(Player,Mob,handles);
    Player.LimitBar=Player.LimitBar+round(2*(Damage/Player.MaxHealth)*100);
    if Player.LimitBar>100
        Player.LimitBar=100;
    end
    axes(handles.axes4);
    
    image([0 Player.LimitBar],[0 1],imread('limit_bar.png'));
    axis([0 100 0 1]);
    set(gca,'YTickLabel',{''})
    set(gca,'XTickLabel',{''})
end

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Player.LimitBar==100
    set(handles.pushbutton1,'String','Limit Break!')
end
set(handles.text10,'String','')
set(handles.pushbutton1,'Visible','On')
set(handles.togglebutton3,'Visible','On')
set(handles.togglebutton1,'Visible','On')
set(handles.togglebutton2,'Visible','On')

switch CloseCheck
    case 1
        GMSTATE.overworld=true;
        music(2);
        close BattleGUI
    case 2
        close Overworld
        close BattleGUI
        run GameOver
        music(5)
    case 3
        close Overworld
        close BattleGUI
        run Credits
end
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
global ItemUseID Items Block
ItemUseID=get(handles.listbox1,'Value');
have=find(Items.amount>0);
if Block==1
    if isempty(have(ItemUseID))==1
        set(handles.pushbutton8,'Visible','Off')
    else
        set(handles.pushbutton8,'Visible','On')
    end
else
    if isempty(have(ItemUseID))==1
        set(handles.pushbutton7,'Visible','Off')
    else
        set(handles.pushbutton7,'Visible','On')
    end
end
clear have

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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Items ItemUseID Damage Mob CloseCheck GMSTATE Block

Block=0;

set(handles.pushbutton1,'Visible','Off')
set(handles.togglebutton3,'Visible','Off')
set(handles.togglebutton1,'Visible','Off')
set(handles.togglebutton2,'Visible','Off')
set(handles.togglebutton1,'Value',0)
set(handles.togglebutton2,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.listbox1,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')

[Player,Items,Message]=useitembattle(Player,Items,Block,ItemUseID);
set(handles.text10,'String',Message)

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

pause(1.0)

listing=listitems(Items);
ItemUseID=get(handles.listbox1,'Value');
if ItemUseID>length(listing)
    set(handles.listbox1,'Value',length(listing))
    ItemUseID=get(handles.listbox1,'Value');
end
set(handles.listbox1,'String',listing)
clear listing

if Mob.Health>0
    [Player,Mob,handles]=playerphysdmg(Player,Mob,handles);
    Player.LimitBar=Player.LimitBar+round(2*(Damage/Player.MaxHealth)*100);
    if Player.LimitBar>100
        Player.LimitBar=100;
    end
    axes(handles.axes4);
    
    image([0 Player.LimitBar],[0 1],imread('limit_bar.png'));
    axis([0 100 0 1]);
    set(gca,'YTickLabel',{''})
    set(gca,'XTickLabel',{''})
end

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Player.LimitBar==100
    set(handles.pushbutton1,'String','Limit Break!')
end
set(handles.text10,'String','')
set(handles.pushbutton1,'Visible','On')
set(handles.togglebutton3,'Visible','On')
set(handles.togglebutton1,'Visible','On')
set(handles.togglebutton2,'Visible','On')

switch CloseCheck
    case 1
        GMSTATE.overworld=true;
        music(2);
        close BattleGUI
    case 2
        close Overworld
        close BattleGUI
        run GameOver
        music(5)
    case 3
        close Overworld
        close BattleGUI
        run Credits
end


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Items ItemUseID Damage Mob CloseCheck GMSTATE Block

Block=1;

set(handles.pushbutton1,'Visible','Off')
set(handles.togglebutton3,'Visible','Off')
set(handles.togglebutton1,'Visible','Off')
set(handles.togglebutton2,'Visible','Off')
set(handles.togglebutton1,'Value',0)
set(handles.togglebutton2,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.listbox1,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')


[Player,Items,Message]=useitembattle(Player,Items,Block,ItemUseID);
set(handles.text10,'String',Message)

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

pause(1.0)

listing=listitems(Items);
ItemUseID=get(handles.listbox1,'Value');
if ItemUseID>length(listing)
    set(handles.listbox1,'Value',length(listing))
    ItemUseID=get(handles.listbox1,'Value');
end
set(handles.listbox1,'String',listing)
clear listing

if Mob.Health>0
    [Player,Mob,handles]=playerphysdmg(Player,Mob,handles);
    Player.LimitBar=Player.LimitBar+round(2*(Damage/Player.MaxHealth)*100);
    if Player.LimitBar>100
        Player.LimitBar=100;
    end
    axes(handles.axes4);
    
    image([0 Player.LimitBar],[0 1],imread('limit_bar.png'));
    axis([0 100 0 1]);
    set(gca,'YTickLabel',{''})
    set(gca,'XTickLabel',{''})
end

Block=0;

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Player.LimitBar==100
    set(handles.pushbutton1,'String','Limit Break!')
end
set(handles.text10,'String','')
set(handles.pushbutton1,'Visible','On')
set(handles.togglebutton3,'Visible','On')
set(handles.togglebutton1,'Visible','On')
set(handles.togglebutton2,'Visible','On')

switch CloseCheck
    case 1
        GMSTATE.overworld=true;
        music(2);
        close BattleGUI
    case 2
        close Overworld
        close BattleGUI
        run GameOver
        music(5)
    case 3
        close Overworld
        close BattleGUI
        run Credits
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Player Items ItemUseID Damage Mob CloseCheck GMSTATE Block

Block=1;

set(handles.pushbutton1,'Visible','Off')
set(handles.togglebutton3,'Visible','Off')
set(handles.togglebutton1,'Visible','Off')
set(handles.togglebutton2,'Visible','Off')
set(handles.togglebutton1,'Value',0)
set(handles.togglebutton2,'Value',0)
set(handles.togglebutton3,'Value',0)
set(handles.uipanel2,'Visible','Off')
set(handles.uipanel3,'Visible','Off')
set(handles.pushbutton3,'Visible','Off')
set(handles.pushbutton4,'Visible','Off')
set(handles.pushbutton5,'Visible','Off')
set(handles.pushbutton6,'Visible','Off')
set(handles.listbox1,'Visible','Off')
set(handles.pushbutton7,'Visible','Off')
set(handles.pushbutton8,'Visible','Off')
set(handles.pushbutton2,'Visible','Off')

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

listing=listitems(Items);
ItemUseID=get(handles.listbox1,'Value');
if ItemUseID>length(listing)
    set(handles.listbox1,'Value',length(listing))
    ItemUseID=get(handles.listbox1,'Value');
end
set(handles.listbox1,'String',listing)
clear listing

if Mob.Health>0
    [Player,Mob,handles]=playerphysdmg(Player,Mob,handles);
    Player.LimitBar=Player.LimitBar+round(2*(Damage/Player.MaxHealth)*100);
    if Player.LimitBar>100
        Player.LimitBar=100;
    end
    axes(handles.axes4);
    
    image([0 Player.LimitBar],[0 1],imread('limit_bar.png'));
    axis([0 100 0 1]);
    set(gca,'YTickLabel',{''})
    set(gca,'XTickLabel',{''})
end

Block=0;

Hdisp=sprintf('%d/%d',Player.Health,Player.MaxHealth);
set(handles.text3,'String',Hdisp)
Mdisp=sprintf('%d/%d',Player.Mana,Player.MaxMana);
set(handles.text5,'String',Mdisp)

if Player.LimitBar==100
    set(handles.pushbutton1,'String','Limit Break!')
end
set(handles.text10,'String','')
set(handles.pushbutton1,'Visible','On')
set(handles.togglebutton3,'Visible','On')
set(handles.togglebutton1,'Visible','On')
set(handles.togglebutton2,'Visible','On')

switch CloseCheck
    case 1
        GMSTATE.overworld=true;
        music(2);
        close BattleGUI
    case 2
        close Overworld
        close BattleGUI
        run GameOver
        music(5)
    case 3
        close Overworld
        close BattleGUI
        run Credits
end