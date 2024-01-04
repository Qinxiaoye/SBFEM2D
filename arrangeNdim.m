function v = arrangeNdim(vector,ndim)

if size(vector,2) == 1
    vector = vector';
end

L = length(vector);

M = eye(ndim,ndim);

v = zeros(ndim,L*ndim);

for n = 1:L
    v(:,(n-1)*ndim+1:n*ndim) = M*vector(n);
end