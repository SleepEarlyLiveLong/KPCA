function k = mykernel(x,y,choice,var)
%MYKERNEL - To get the result of a kerner function with 2 input vectors.
%
%   k = mykernel(x,y,choice,var)
% 
%   Input - 
%   x: input vector;
%   y: input vector;
%   choice: what kind of kernel to be chosen;
%   var: kernel's parameter.
%   Output - 
%   x: result of a kerner function with 2 input vectors.
% 
%   Copyright (c) 2018 CHEN Tianyang
%   more info contact: tychen@whu.edu.cn

%% 
% cls: choose kernel function
if ~isvector(x)||~isvector(y)
    error('Input error 1.');
end
if length(x)~=length(y)
    error('Input error 2.');
end
x = x(:);
y = y(:);
if choice == 1
    k = exp( - norm(x-y)^2/(2*var^2) );     % ��˹��
elseif choice == 2
    k = (x'*y+1)^var;                       % ����ʽ��
elseif choice == 3          
    k = x'*y;                               % ���κ�
elseif choice == 4
    k = exp( - norm(x-y)/(2*var^2) );       % ָ����
elseif choice == 5
    k = exp( - norm(x-y)/var );             % ������˹��
else
    error('Error! Parameter "choice" should be interger from 1 to 5.');
end