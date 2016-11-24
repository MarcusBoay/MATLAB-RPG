classdef equipment
    properties
        names
        stats
        inv
        equipped
        equippedname
    end
    
    methods
        function out=equipment(names,stats,inv,equipped,equippedname)
            out.names=names;
            out.stats=stats;
            out.inv=inv;
            out.equipped=equipped;
            out.equippedname=equippedname;
        end
        function [playinv,message]=gain(playinv,ID)
            playinv.inv(ID)=1;
            message=sprintf('You have obtained %s\n',playinv.names{ID});
        end
        function listing=list(playinv,have,i)
            n=playinv.names{have(i)};
            listing=sprintf('%d) %s',i,n);
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
    end
end

