function dN = dfunc(xi,eta,zeta,ndim,mnode)
% for mnode = 3:
% 1--3--2
dN = zeros(mnode,ndim);

if ndim == 1
    if mnode==2
        dN(1) = -1/2;
        dN(2) = 1/2;
    elseif mnode==3
        dN(1) = 1/2*(2*xi-1);
        dN(2) = 1/2*(2*xi+1);
        dN(3) = -2*xi;
    end
end