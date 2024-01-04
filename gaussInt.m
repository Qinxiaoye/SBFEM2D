function [point,weight] = gaussInt(nip)
% return the coor for gauss integral point and weight

if nip == 3
    point = [-0.774596669241483,0,0.774596669241483]; % 积分点
    weight = [0.55555555555556,0.888888888888888889,0.55555555555556]; % 权系数
elseif nip == 1
    point = 0;
    weight = 2;
elseif nip == 4
    point = [-0.8611363115940520,-0.3399810435848560,0.3399810435848560,0.8611363115940520];
    weight = [0.3478548451374530,0.6521451548625460,0.6521451548625460,0.3478548451374530];
end