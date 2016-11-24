classdef mobatk
    properties
        Name
        Damage
        MPuse
    end
    methods
        function out=mobatk(n,d,m)
            out.Name=n;
            out.Damage=d;
            out.MPuse=m;
        end
    end
end