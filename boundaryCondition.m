function GK = boundaryCondition(GK,fixNdf)

sumNdf = size(GK,1);

GK(fixNdf,:) = 0;
GK = GK+sparse(fixNdf,fixNdf,1,sumNdf,sumNdf);