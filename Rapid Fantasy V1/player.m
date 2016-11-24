%Player
classdef player
    properties
        Health
        MaxHealth
        Mana
        MaxMana
        Strength
        Wisdom
        Defense
        LimitBar
        UnlockedLimits
        CurrentLimit
        Level
        Experience
        xpos
        ypos
        xlength
        ylength
        Orientation
        CollideState
        img
    end
    methods
        function out=player(h,mh,m,mm,s,w,d,lb,ul,cl,l,e,x,y,xl,yl,o,c,i)
            out.Health=h;
            out.MaxHealth=mh;
            out.Mana=m;
            out.MaxMana=mm;
            out.Strength=s;
            out.Wisdom=w;
            out.Defense=d;
            out.LimitBar=lb;
            out.UnlockedLimits=ul;
            out.CurrentLimit=cl;
            out.Level=l;
            out.Experience=e;
            out.xpos=x;
            out.ypos=y;
            out.xlength=xl;
            out.ylength=yl;
            out.Orientation=o;
            out.CollideState=c;
            out.img=i;
        end
        function [playerguy,playmagic,Message]=levelup(playerguy,playmagic)
            global hardmode
            if playerguy.Experience>=(playerguy.Level*10)^3 && playerguy.Level<5
                if hardmode==0
                    playerguy.MaxHealth=playerguy.MaxHealth+(playerguy.Level*50);
                    playerguy.Health=playerguy.MaxHealth;
                	playerguy.Strength=playerguy.Strength+(playerguy.Level*5);
                	playerguy.Wisdom=playerguy.Wisdom+(playerguy.Level*5);
                	playerguy.Defense=playerguy.Defense+(playerguy.Level*3);
                    playerguy.MaxMana=40+5*playerguy.Wisdom;
                    playerguy.Mana=playerguy.MaxMana;
                end
                playerguy.Level=playerguy.Level+1;
            	playerguy.Experience=0;
                Message=sprintf('You leveled up to level %d!\nHealth: %d     Mana: %d\nStrength: %d  Wisdom: %d  Defense: %d\n',playerguy.Level,playerguy.MaxHealth,playerguy.MaxMana,playerguy.Strength,playerguy.Wisdom,playerguy.Defense);
                for i=1:length(playmagic.ManaCost)
                    switch playmagic.Tier(i)
                        case 0
                            playmagic.ManaCost(i)=5;
                        case 1
                            playmagic.ManaCost(i)=5+5*playerguy.Level;
                        case 2
                            playmagic.ManaCost(i)=30+10*playerguy.Level;
                        case 3
                            playmagic.ManaCost(i)=60+15*playerguy.Level;
                    end
                end
                switch playerguy.Level
                    case 2
                        playmagic.inv=[1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0];
                    case 3
                        playerguy.UnlockedLimits=[1,1,0];
                    case 4
                        playmagic.inv=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
                    case 5
                        playerguy.UnlockedLimits=[1,1,1];
                end
            else
                	Message='No Level Up';
            end
        end
        function playerguy=checkorient(playerguy)
            if playerguy.Orientation==1;
                playerguy.img=imread('player_left.png');
            elseif playerguy.Orientation==2;
                playerguy.img=imread('player_up.png');
            elseif playerguy.Orientation==3;
                playerguy.img=imread('player_down.png');
            elseif playerguy.Orientation==4;
                playerguy.img=imread('player_right.png');
            end
        end
        function playerguy=boundplayer(playerguy,mapout)
            if playerguy.ypos>mapout.b_up.ypos&&isempty(find(playerguy.xpos==mapout.b_up.xpos))==0;
                playerguy.ypos=mapout.b_up.ypos;
                playerguy.CollideState=true;
            elseif playerguy.ypos<mapout.b_down.ypos&&isempty(find(playerguy.xpos==mapout.b_down.xpos))==0;
                playerguy.ypos=mapout.b_down.ypos;
                playerguy.CollideState=true;
            elseif playerguy.xpos<mapout.b_left.xpos&&isempty(find(playerguy.ypos==mapout.b_left.ypos))==0;
                playerguy.xpos=mapout.b_left.xpos;
                playerguy.CollideState=true;
            elseif playerguy.xpos>mapout.b_right.xpos&&isempty(find(playerguy.ypos==mapout.b_right.ypos))==0;
                playerguy.xpos=mapout.b_right.xpos;
                playerguy.CollideState=true;
            elseif playerguy.CollideState==true;
                %do nothing
            else
                playerguy.CollideState=false;
            end
        end
        function [player,playerinv]=equip(playerinv,player,ID)
            player.MaxHealth=player.MaxHealth-playerinv.equipped(1); 
            player.Strength=player.Strength-playerinv.equipped(3);
            player.Wisdom=player.Wisdom-playerinv.equipped(4);
            player.Defense=player.Defense-playerinv.equipped(5);
            have=find(playerinv.inv==1);
            playerinv.equipped=playerinv.stats(have(ID),:);
            playerinv.equippedname=playerinv.names{have(ID)};
            player.MaxHealth=player.MaxHealth+playerinv.equipped(1);
            player.Strength=player.Strength+playerinv.equipped(3);
            player.Wisdom=player.Wisdom+playerinv.equipped(4);
            player.Defense=player.Defense+playerinv.equipped(5);
            player.MaxMana=40+5*player.Wisdom;
            if player.Health>player.MaxHealth
                player.Health=player.MaxHealth;
            end
            if player.Mana>player.MaxMana
                player.Mana=player.MaxMana;
            end
            clear have
        end
        function [player,playitems,message]=useitem(player,playitems,ID)
            have=find(playitems.amount>0);
            switch have(ID)
                case 1
                    RecoverAmount=20;
                    player.Health=player.Health+RecoverAmount;
                    if player.Health>player.MaxHealth
                        player.Health=player.MaxHealth;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 2
                    RecoverAmount=15;
                    player.Mana=player.Mana+RecoverAmount;
                    if player.Mana>player.MaxMana
                        player.Mana=player.MaxMana;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 3
                    RecoverAmount=40;
                    player.Health=player.Health+RecoverAmount;
                    if player.Health>player.MaxHealth
                        player.Health=player.MaxHealth;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 4
                    RecoverAmount=15;
                    player.Mana=player.Mana+RecoverAmount;
                    if player.Mana>player.MaxMana
                        player.Mana=player.MaxMana;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 5
                    RecoverAmount=80;
                    player.Health=player.Health+RecoverAmount;
                    if player.Health>player.MaxHealth
                        player.Health=player.MaxHealth;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 6
                    RecoverAmount=60;
                    player.Mana=player.Mana+RecoverAmount;
                    if player.Mana>player.MaxMana
                        player.Mana=player.MaxMana;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 7
                    RecoverAmount=160;
                   player.Health=player.Health+RecoverAmount;
                    if player.Health>player.MaxHealth
                        player.Health=player.MaxHealth;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 8
                    RecoverAmount=120;
                    player.Mana=player.Mana+RecoverAmount;
                    if player.Mana>player.MaxMana
                        player.Mana=player.MaxMana;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 9
                    RecoverAmount=320;
                    player.Health=player.Health+RecoverAmount;
                    if player.Health>player.MaxHealth
                        player.Health=player.MaxHealth;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 10
                    RecoverAmount=240;
                    player.Mana=player.Mana+RecoverAmount;
                    if player.Mana>player.MaxMana
                        player.Mana=player.MaxMana;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
            end
            message=sprintf('You used %s',playitems.names{have(ID)});
        end
        function [player,playitems,message]=useitembattle(player,playitems,Block,ID)
            have=find(playitems.amount>0);
            switch have(ID)
                case 1
                    if Block==1
                        RecoverAmount=10;
                    else
                        RecoverAmount=20;
                    end
                    player.Health=player.Health+RecoverAmount;
                    if player.Health>player.MaxHealth
                        player.Health=player.MaxHealth;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 2
                    if Block==1
                        RecoverAmount=5;
                    else
                        RecoverAmount=15;
                    end
                    player.Mana=player.Mana+RecoverAmount;
                    if player.Mana>player.MaxMana
                        player.Mana=player.MaxMana;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 3
                    if Block==1
                        RecoverAmount=20;
                    else
                        RecoverAmount=40;
                    end
                    player.Health=player.Health+RecoverAmount;
                    if player.Health>player.MaxHealth
                        player.Health=player.MaxHealth;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 4
                    if Block==1
                        RecoverAmount=15;
                    else
                        RecoverAmount=30;
                    end
                    player.Mana=player.Mana+RecoverAmount;
                    if player.Mana>player.MaxMana
                        player.Mana=player.MaxMana;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 5
                    if Block==1
                        RecoverAmount=40;
                    else
                        RecoverAmount=80;
                    end
                    player.Health=player.Health+RecoverAmount;
                    if player.Health>player.MaxHealth
                        player.Health=player.MaxHealth;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 6
                    if Block==1
                        RecoverAmount=30;
                    else
                        RecoverAmount=60;
                    end
                    player.Mana=player.Mana+RecoverAmount;
                    if player.Mana>player.MaxMana
                        player.Mana=player.MaxMana;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 7
                    if Block==1
                        RecoverAmount=80;
                    else
                        RecoverAmount=160;
                    end
                   player.Health=player.Health+RecoverAmount;
                    if player.Health>player.MaxHealth
                        player.Health=player.MaxHealth;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 8
                    if Block==1
                        RecoverAmount=60;
                    else
                        RecoverAmount=120;
                    end
                    player.Mana=player.Mana+RecoverAmount;
                    if player.Mana>player.MaxMana
                        player.Mana=player.MaxMana;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 9
                    if Block==1
                        RecoverAmount=160;
                    else
                        RecoverAmount=320;
                    end
                    player.Health=player.Health+RecoverAmount;
                    if player.Health>player.MaxHealth
                        player.Health=player.MaxHealth;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
                case 10
                    if Block==1
                        RecoverAmount=120;
                    else
                        RecoverAmount=240;
                    end
                    player.Mana=player.Mana+RecoverAmount;
                    if player.Mana>player.MaxMana
                        player.Mana=player.MaxMana;
                    end
                    playitems.amount(have(ID))=playitems.amount(have(ID))-1;
            end
            message=sprintf('You used %s',playitems.names{have(ID)});
        end      
        
    end
end