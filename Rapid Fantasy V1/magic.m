classdef magic
    properties
        Names
        Tier
        ManaCost
        Element
        inv
        Current
    end
   methods
       function out=magic()
           out.Names=[cellstr('Scan');cellstr('FireBall');cellstr('Bubble Beam');
               cellstr('Lightning Bolt');cellstr('Stone Edge');cellstr('Holy Light');
               cellstr('Dark Spear');cellstr('Red Blaze');cellstr('Waterfall');
               cellstr('Electrocute');cellstr('Landslide');cellstr('Piercing Light');
               cellstr('Pitch Black');cellstr('Inferno');cellstr('Tsunami');cellstr('Plasma');
               cellstr('Earthquake');cellstr('Genesis');cellstr('Blackhole')];
           out.Tier=[0,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3];
           out.ManaCost=[5,10,10,10,10,10,10,40,40,40,40,40,40,75,75,75,75,75,75];
           out.Element=[02,03,06,05,04,07,08,03,06,05,04,07,08,03,06,05,04,07,08];
           out.inv=[1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0];
           out.Current=[1,0,0,0];
       end
       function listing=listmagic(playmagic)
           have=find(playmagic.inv==1);
           if isempty(have)==0
               for i=1:length(have)
               listing{i,:}=sprintf('%d) %s',i,playmagic.Names{have(i)});
               end
           else
               listing=sprintf('Empty');
           end
       end       
       function playmagic=swapmagic(playmagic,slot,ID)
           have=find(playmagic.inv==1);
           playmagic.Current(slot)=(have(ID));
       end
   end
end

