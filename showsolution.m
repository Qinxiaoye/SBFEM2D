function h=showsolution(node,elem,u,varargin)
%Showsolution displays the solution corresponding to a mesh given by [node,elem] in 2-D.
%
% Copyright (C) Terence Yu.

data = [node,u];
if ~iscell(elem)
    patch('Faces', elem,...
        'Vertices', data,...
        'FaceColor', 'interp',...
        'CData', u);
else
    max_n_vertices = max(cellfun(@length, elem));
    padding_func = @(vertex_ind) [vertex_ind,...
        NaN(1,max_n_vertices-length(vertex_ind))];  % function to pad the vacancies
    tpad = cellfun(padding_func, elem, 'UniformOutput', false);
    tpad = vertcat(tpad{:});
    h=patch('Faces', tpad,...
        'Vertices', node,'EdgeColor','k',...
        'FaceColor', 'interp',...
        'FaceVertexCData', u);
end
axis equal; 
axis off;
colorbar;

