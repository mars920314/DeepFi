function [xout,yout]=position(xin,yin,opts)
ap1=[10,3];
ap2=[10,26];
ap3=[11,12];
if opts=='lat'
    a=ceil(xin/6);
    b=xin-6*(a-1);
    switch a
        case 1
            xout=3;
        case 2
            xout=5+3;
        case 3
            xout=5+5+3;
        case 4
            xout=5+5+5+3;
        case 5
            xout=5+5+5+5+3;
    end
    yout=2*(b-1)+3;

elseif opts=='lab'
    if yin<8
        switch xin
            case 1
                xout=2;
            case 2
                xout=2+2;
            case 3
                xout=5+2+2;
            case 4
                xout=5+5+2+2;
            case 5
                xout=5+5+5+2+2;
            case 6
                xout=5+5+5+5+2+2;
            case 7
                xout=2+5+5+5+5+2+2;
        end
        yout=2*(yin-1)+2;
    elseif yin==8
        switch xin
            case 2
                xout=3+2+2;
            case 3
                xout=5+3+2+2;
            case 4
                xout=5+5+3+2+2;
            case 5
                xout=5+5+5+3+2+2;
        end
        yout=2*6+2;
    end
end