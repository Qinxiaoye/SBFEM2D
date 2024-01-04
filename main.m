clear;

load nonMatch.mat;

k = 1;
ndim = 2;
ndf = 2; % 2-二维力学问题

E = 2E5; nu = 0.3; % plane stress
mat.E = E; mat.nu = nu;

sumNode = size(node,1);

[GK,sdSln] = globalK(node,elem,mat);

nodeD = find(node(:,2)<-2.5+0.001);
nodeT = find(node(:,2)>2.5-0.001);
nodeR = find(node(:,1)>5-0.001);

% right hand vector
pface = findFace(node,elem,nodeR);
p = -20; % 压力
press = [pface,ones(length(pface),1)*p];
ff = getForce(node,sumNode,elem,press,'y');

% fixNode
fixNode = [nodeD;nodeT];
fixNdf = expendID(fixNode,ndim);
GK = boundaryCondition(GK,fixNdf);
ff(fixNdf) = 0;

uh = GK\sparse(ff);

uh = full(uh);

ux = uh(1:ndim:sumNode*ndim);
uy = uh(2:ndim:sumNode*ndim);

showmesh(node,elem); 
title('Polygon mesh')
hold on;
plot(node(:,1),node(:,2),'k.', 'MarkerSize', 4);
hold off;

% Plot numerical solution
figure
showsolution(node,elem,ux);
figure
showsolution(node,elem,uy);

S = calculateStress(uh,sdSln,node,elem,mat);

figure
showsolution(node,elem,S(:,4));

