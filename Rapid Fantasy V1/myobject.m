classdef myobject
    properties
        Interactable
        Exist
        ProgNum
        xpos
        ypos
        xlength
        ylength
        img
    end
    methods
        function out=myobject(I,e,p,x,y,xl,yl,i)
            out.Interactable=I;
            out.Exist=e;
            out.ProgNum=p;
            out.xpos=x;
            out.ypos=y;
            out.xlength=xl;
            out.ylength=yl;
            out.img=i;
        end
    end
end