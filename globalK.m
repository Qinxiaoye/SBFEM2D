function [GK,sdSln] = globalK(node,elem,mat)
% calculate the global stiffness matrix,mat
% input: node,elem,k,ndim,ndf
% output: GK

% calculate the geometric quantity for each element

ndim = 2; % dimension
ndf = 2; %dof

sumElem = size(elem,1); % the number of element
sumNode = size(node,1);


elemLen = cellfun('length',elem); 
nnz = sum((ndf*elemLen).^2);

ii = zeros(nnz,1); jj = zeros(nnz,1); ss = zeros(nnz,1); 

% calculate element stiffness matrix
sdSln = cell(sumElem,1);
ia = 0;
for n = 1:sumElem
    [AK,sdSln1] = elemK_SBFEM(n,node,elem,mat);   
    AB = reshape(AK',1,[]);
    index = elem{n};

    % --------- assembly index for ellptic projection -----------
    indexDof = expendID(index,ndim);  
    Ndof = length(indexDof);
    ii(ia+1:ia+Ndof^2) = reshape(repmat(indexDof, Ndof, 1), [], 1);
    jj(ia+1:ia+Ndof^2) = repmat(indexDof(:), Ndof, 1);
    ss(ia+1:ia+Ndof^2) = AB(:);
    ia = ia + Ndof^2;
    sdSln{n}= sdSln1;
end

GK = sparse(ii,jj,ss,sumNode*ndf,sumNode*ndf);