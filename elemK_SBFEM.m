function [K,sdSln1] = elemK_SBFEM(elemID,node,elem,mat)
% calculate elem stiffness matrix
% for k = 1,2,3
% input: elemID,centroid,diameter,Area,node,elem,ndim,ndf,k,mat,constrainttype
% output: K

ndim = 2;

index = elem{elemID};
Nv = length(index);


x = node(index ,1)-mean(node(index,1)); y = node(index ,2)-mean(node(index,2));
Ndof = Nv; 
v1 = 1:Nv; v2 = [2:Nv,1]; % loop index for vertices or edges

Ndof = Ndof*ndim;
D = IsoElasMtrx(mat.E,mat.nu);

E0 = zeros(Ndof, Ndof);
E1 = zeros(Ndof, Ndof);
E2 = zeros(Ndof, Ndof);

nip = 3;
[xi,weight] = gaussInt(nip);

elem1 = [v1(:), v2(:)];
for n = 1:Nv
    nodeLine = [x(elem1(n,:)),y(elem1(n,:))];
    e0 = zeros(4);
    e1 = zeros(4);
    e2 = zeros(4);

    for m = 1:nip % 高斯积分
        N = fun(xi(m),0,0,1,2);
        dN = dfunc(xi(m),0,0,1,2);
        xb = N'*nodeLine(:,1);
        yb = N'*nodeLine(:,2);
        xb_eta = dN'*nodeLine(:,1);
        yb_eta = dN'*nodeLine(:,2);
        Jb = [xb,yb;xb_eta,yb_eta];
        b1 = 1/det(Jb)*[yb_eta,0;0,-xb_eta;-xb_eta,yb_eta];
        b2 = 1/det(Jb)*[-yb,0;0,xb;xb,-yb];
        B1 = b1*arrangeNdim(N,ndim);
        B2 = b2*arrangeNdim(dN,ndim);
        e0 = e0+weight(m)*B1'*D*B1*det(Jb);
        e1 = e1+weight(m)*B2'*D*B1*det(Jb);
        e2 = e2+weight(m)*B2'*D*B2*det(Jb);
    end
    nodeID = elem1(n,:);
    d = expendID(nodeID,ndim);
    E0(d,d) = E0(d,d) + e0;
    E1(d,d) = E1(d,d) + e1;
    E2(d,d) = E2(d,d) + e2;
end

[K,d,v] = SElementSlnEigenMethod(E0, E1, E2, 0);
xy = [x,y];
sdSln1 = struct('xy',xy,'K',K,'d',d, 'v', v,...
    'sc' , [mean(node(index,1)),mean(node(index,2))],...
    'conn',elem1,'node',index);