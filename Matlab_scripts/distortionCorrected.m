function [xn,yn]=distortionCorrected(kMatrix,xd,yd,error)

    xn=xd;
    yn=yd;
    
    while(1)
    psquare=xn.^2+yn.^2;
    beta=1+kMatrix(1)*psquare+kMatrix(2)*psquare^2+kMatrix(5)*psquare^3;
    dx=2*kMatrix(3)*xn*yn+kMatrix(4)*(psquare+2*xn^2);
    dy=kMatrix(3)*(psquare+2*yn^2)+2*kMatrix(4)*xn*yn;

    xnnew=(xd-dx)./beta;
    ynnew=(yd-dy)./beta;
    if(abs(xn-xnnew)<error&&abs(yn-ynnew)<error)
        break;
    end
    xn=xnnew;
    yn=ynnew;
    end


end