function RapidFantasy()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% A simple RPG made by Wing Chuen Boay and Dat Nguyen. 
% Click the 'Start Game' button to play the game!
% 
% Acknowledgements:
% Arjun Kalburgi and Nicholas Kraemer for the MATLAB game Runner_Runner.
% Steven Tian for the illustrations in this game.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;clc;close all;clear sound;
global IntroMusic MapMusic BattleMusic BattleFinalMusic GameOverMusic EndMusic
fprintf('%s\n','Loading...');
[IntroMusic_y,IntroMusic_Fs]=audioread('588731_-Legendary-heroes-.mp3');
IntroMusic=audioplayer(IntroMusic_y,IntroMusic_Fs,24);
[MapMusic_y,MapMusic_Fs]=audioread('654553_-Everybody-Bounce-.mp3');
MapMusic=audioplayer(MapMusic_y,MapMusic_Fs,24);
[BattleMusic_y,BattleMusic_Fs]=audioread('607081_-Electroman-Adventures-V2-.mp3');
BattleMusic=audioplayer(BattleMusic_y,BattleMusic_Fs,24);
[BattleFinalMusic_y,BattleFinalMusic_Fs]=audioread('129910_Waterflame___Damage_contro.mp3');
BattleFinalMusic=audioplayer(BattleFinalMusic_y,BattleFinalMusic_Fs,24);
[GameOverMusic_y,GameOverMusic_Fs]=audioread('News of Sorrow.mp3');
GameOverMusic=audioplayer(GameOverMusic_y,GameOverMusic_Fs,24);
[EndMusic_y,EndMusic_Fs]=audioread('550054_-Swirl-.mp3');
EndMusic=audioplayer(EndMusic_y,EndMusic_Fs,24);
fprintf('%s\n','Loaded!');
run Introduction
end