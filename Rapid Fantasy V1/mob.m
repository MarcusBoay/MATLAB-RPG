classdef mob
    properties
        Health
        MaxHealth
        Mana
        MaxMana
        Strength
        Wisdom
        Defense
        Level
        Image
        Name
        Element
        Gold
        Experience
        ID
        Atk1
        Atk2
        Atk3
        Atk4
        Atk5
    end
    methods
        function out=mob(h,mh,m,mm,s,w,d,l,i,n,e,g,ex,id,a1,a2,a3,a4,a5)
            out.Health=h;
            out.MaxHealth=mh;
            out.Mana=m;
            out.MaxMana=mm;
            out.Strength=s;
            out.Wisdom=w;
            out.Defense=d;
            out.Level=l;
            out.Image=i;
            out.Name=n;
            out.Element=e;
            out.Gold=g;
            out.Experience=ex;
            out.ID=id;
            out.Atk1=a1;
            out.Atk2=a2;
            out.Atk3=a3;
            out.Atk4=a4;
            out.Atk5=a5;
        end
    end
end