function face = findFace(node,elem,nodeID)

sumElem = size(elem,1);

sumNode = size(node,1);
mark = zeros(sumNode,1);
mark(nodeID) = 1;
face = [0,0];

for n = 1:sumElem
    elem1 = elem{n};
    Nv = length(elem1);
    v1 = 1:Nv; v2 = [2:Nv,1]; % loop index for vertices or edges
    for faceNum = 1:Nv
        twoNode = [elem1(v1(faceNum)),elem1(v2(faceNum))];
        mark1 = mark(twoNode);
        if mark1(1)*mark1(2) == 1
            face = [face;[n,faceNum]];
        end
    end
end
if size(face,1)>1
    face(1,:) = [];
end