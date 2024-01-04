function N = fun(xi,eta,zeta,ndim,mnode)
% for mnode = 3:
% 1--3--2
N = zeros(mnode,1);

if ndim == 1
    if mnode==2
        N(1) = (1-xi)/2;
        N(2) = (1+xi)/2;
    elseif mnode==3
        N(1) = xi*(xi-1)/2;
        N(2) = xi*(xi+1)/2;
        N(3) = -(xi-1)*(xi+1);
    end
end