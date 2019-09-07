function  myarrow(S,V,color)
%MYARROR - To draw arrows in 2-D and 3-D space with proper input parameters.
%
%   myarrow(S,V,color)
% 
%   Input - 
%   S: The starting point of the arrow;
%   V: The vectorization presentation of the arrow;
%   color: color of the arrow.
%   Output - 
%   No output parameter.
% 
%   For example:
%   if S = [x0,y0,z0] and V = [a,b,c], 
%   then the arrow will go from (x0，y0, z0) to (x0+a，y0+b, z0+c).
% 
%   Copyright (c) 2018 CHEN Tianyang
%   more info contact: tychen@whu.edu.cn

%%
if ~isvector(S) || ~isvector(V)
    error('Input error 1. Input parameters P and V must be vectors.');
end
if length(S) ~= length(V)
    error('Input error 2. P and V must have same size.');
else
    len = length(S);
end
S = S(:);
V = V(:);
L = norm(V);
if nargin < 3 
    color = 'b';
end
if len == 2
    % 画直线
    x0 = S(1);y0 = S(2); 
    a = V(1); b = V(2);
    u = [x0 x0+a]; v = [y0 y0+b];
    plot(u,v,color);
    hold on;
    % 画箭头 —— 三角函数法
    if a==0 && b > 0
        theta = pi/2;
    elseif a==0 && b < 0
        theta = -pi/2;
    else
        theta = acos(a/sqrt(a^2+b^2));
    end
    delta_theta = 2*pi/180;     % 5度夹角
    H = 0.95*L;
    Ax = x0 + H*cos(theta+delta_theta);
    Ay = y0 + H*sin(theta+delta_theta);
    Bx = x0 + H*cos(theta-delta_theta);
    By = y0 + H*sin(theta-delta_theta);
    plot([Ax,x0+a], [Ay,y0+b], color);
    plot([Bx,x0+a], [By,y0+b], color);
    
elseif len == 3
    % 画直线
    x0 = S(1);y0 = S(2);z0 = S(3);
    a = V(1);b = V(2);c = V(3);
    u = [x0 x0+a]; v = [y0 y0+b]; w = [z0, z0+c];
    plot3(u,v,w,color);
    hold on;
    % 画箭头 —— 暂时还没想出好办法
else
    error('Visualization requires the dimension to be no larger than 3.');
end
end