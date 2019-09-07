function [X1,X2,X3] = mygenerate_data(datanum,tbcrate)
%MYGENERATE_DATA - To generate data we need to do some test.
%
%   [X1,X2,X3] = mygenerate_data(datanum,tbcrate)
% 
%   Input - 
%   datanum: number of data generated;
%   tbcrate: momentum multiplier, a scalar to decide how random the data are generated,
%            the larger tbcrate be, the more data be randomly generated.
%   Output - 
%   [X1,X2,X3]: data generated.
% 
%   Copyright (c) 2018 CHEN Tianyang
%   more info contact: tychen@whu.edu.cn

%%
% tbcrate: ��λ�Ŷ�������
x0 = 30;
y0 = 60;
a1 = 2;b1 = 4;
a2 = 9;b2 = 16;
a3 = 16;b3 = 25;
% ��������ʽ
theta = rand(1,datanum)*2*pi;         % �Ƕ���[0,2*pi]֮����ȷֲ�
% tbcrate=1ʱdistbc�ֲ������(0.5,1.5)֮��ֲ� 
x1 = x0 + a1*cos(theta) + tbcrate*rand(1,datanum); 
y1 = y0 + b1*sin(theta) + tbcrate*rand(1,datanum); 
x2 = x0 + a2*cos(theta) + tbcrate*rand(1,datanum); 
y2 = y0 + b2*sin(theta) + tbcrate*rand(1,datanum); 
x3 = x0 + a3*cos(theta) + tbcrate*rand(1,datanum); 
y3 = y0 + b3*sin(theta) + tbcrate*rand(1,datanum); 
% �����Ҫ����Ϊ������Ϊ����
X1 = [x1;y1];
X2 = [x2;y2];
X3 = [x3;y3];
end
