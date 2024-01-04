function ff = getForce(nodeNew,sumNode,elem,press,direction)


ff = zeros(sumNode*2,1);
sumP = size(press,1);

nip = 3;
[x,w] = gaussInt(nip);

for n = 1:sumP
    p = zeros(2,1);
    elemID = press(n,1);
    faceID = press(n,2);
    value = press(n,3);
    index = elem{elemID};
    Nv = length(index);
    v1 = 1:Nv; v2 = [2:Nv,1]; % loop index for vertices or edges
    
    elem1 = [v1(:), v2(:)];
    faceNode = elem1(faceID,:);
    faceNodeID = index(faceNode);
    edgeNodeCoor = nodeNew(faceNodeID,:);
    
    L = nodeNew(faceNodeID(1:2),:);
    L = (L(1,:)-L(2,:));
    Normal = [L(2),-L(1)]/norm(L);
    for m = 1:nip
        N = fun(x(m),0,0,1,2);
        dN = dfunc(x(m),0,0,1,2);
        J = sqrt((dN'*edgeNodeCoor(:,1))^2+(dN'*edgeNodeCoor(:,2))^2);
        p = p+w(m)*N*value*J;
    end
    if strcmp(direction,'normal')
        ff(faceNodeID*2-1) = ff(faceNodeID*2-1)+p*Normal(1);
        ff(faceNodeID*2) = ff(faceNodeID*2)+p*Normal(2);
    elseif strcmp(direction,'x')
        ff(faceNodeID*2-1) = ff(faceNodeID*2-1)+p;
    elseif strcmp(direction,'y')
        ff(faceNodeID*2) = ff(faceNodeID*2)+p;
    end
end
ff = sparse(ff);