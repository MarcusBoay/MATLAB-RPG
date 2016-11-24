function music(musicID)
global IntroMusic MapMusic BattleMusic BattleFinalMusic GameOverMusic EndMusic
switch musicID
    case 0 %Stop all music
        stop(IntroMusic);
        stop(MapMusic);
        stop(BattleMusic);
        stop(BattleFinalMusic);
        stop(GameOverMusic);
        stop(EndMusic);
    case 1 %Introduction music
        play(IntroMusic);
        stop(MapMusic);
        stop(BattleMusic);
        stop(BattleFinalMusic);
        stop(GameOverMusic);
        stop(EndMusic);
    case 2 %Map music
        stop(IntroMusic);
        resume(MapMusic);
        stop(BattleMusic);
        stop(BattleFinalMusic);
        stop(GameOverMusic);
        stop(EndMusic);
    case 3 %Battle music
        stop(IntroMusic);
        pause(MapMusic);
        play(BattleMusic);
        stop(BattleFinalMusic);
        stop(GameOverMusic);
        stop(EndMusic);
    case 4 %Final battle music
        stop(IntroMusic);
        pause(MapMusic);
        stop(BattleMusic);
        play(BattleFinalMusic);
        stop(GameOverMusic);
        stop(EndMusic);
    case 5 %Game over music
        stop(IntroMusic);
        stop(MapMusic);
        stop(BattleMusic);
        stop(BattleFinalMusic);
        play(GameOverMusic);
        stop(EndMusic);
    case 6 %Ending music
        stop(IntroMusic);
        stop(MapMusic);
        stop(BattleMusic);
        stop(BattleFinalMusic);
        stop(GameOverMusic);
        play(EndMusic);
end
end