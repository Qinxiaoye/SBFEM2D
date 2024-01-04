function S = calculateStress(uh,sdSln,node,elem,mat)

sumNode = size(node,1);
sumElem = size(elem,1);

S = zeros(sumNode,4);
nodeUsed = zeros(sumNode,1);

sdStrnMode = SElementStrainMode2NodeEle( sdSln );
sdIntgConst = SElementIntgConst( uh, sdSln );

D = IsoElasMtrx(mat.E,mat.nu);
xi = 1;
for isd = 1:sumElem
    index = elem{isd};
    s = zeros(length(index),3);
    [~, ~, ~, ~, strnEle] = ...
     SElementInDispStrain(xi, sdSln{isd},sdStrnMode{isd}, sdIntgConst{isd});
    stress = (D*strnEle)';

    s = s+stress;
    s = s+[stress(end,:);stress(1:end-1,:)];
    s = s./2;
    S(index,1:3) = S(index,1:3)+s;
    nodeUsed(index) = nodeUsed(index)+1;
end

S = S./nodeUsed;

smax = (S(:,1)+S(:,2))./2+sqrt(((S(:,1)-S(:,2))./2).^2+S(:,3).^2);
smin = (S(:,1)+S(:,2))./2-sqrt(((S(:,1)-S(:,2))./2).^2+S(:,3).^2);


S(:,4) = sqrt((smax.^2+smin.^2+(smax-smin).^2)./2);