classdef items    
    properties
        names
        amount
    end
    
    methods
        function out=items()
            out.names=[cellstr('Red Potion I');cellstr('Blue Potion I');
                       cellstr('Red Potion II');cellstr('Blue Potion II');...
                       cellstr('Red Potion III');cellstr('Blue Potion III');...
                       cellstr('Red Potion IV');cellstr('Blue Potion IV');...
                       cellstr('Red Potion V');cellstr('Blue Potion V')];
            out.amount=[5;5;0;0;0;0;0;0;0;0];
        end
        function [playitems,message]=gainitems(playitems,ID,amount)
            if playitems.amount(ID)+amount<15
                playitems.amount(ID)=playitems.amount(ID)+amount;
                message=sprintf('You have gained %d %s',amount,playitems.names{ID});
            elseif playitems.amount(ID)+amount>=15 && (15-playitems.amount(ID))>0;
                amount=15-playitems.amount(ID);
                playitems.amount(ID)=playitems.amount(ID)+amount;
                message=sprintf('You have gained %d %s',amount,playitems.names{ID});
            else
                message=sprintf('You have the maximum number of %s',playitems.names{ID});
            end
        end
        function listing=listitems(playitems)
            have=find(playitems.amount>0);
            if isempty(have)==0
                for i=1:length(have)
                listing{i,:}=sprintf('%d) %s x%d',i,playitems.names{have(i)},playitems.amount(have(i)));
                end
            else
                listing=sprintf('Empty');
            end
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
        function [player,playitems,message]=useitembattle(player,playitems,ID)
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

