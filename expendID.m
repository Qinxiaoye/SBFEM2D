function v = expendID(vector,ndim)
if ndim == 2
    v1 = [(vector-1)*2+1;vector*2];
    v = v1(:)';
end
end