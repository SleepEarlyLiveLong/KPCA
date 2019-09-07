function X_KPCA = myKPCA(X, sigma, choice, target_dimension, varargin)
%MYPCM - The Kernel Principal Component Analysis(KPCA) function.
%   To calculate the result after KPCA, one kind of 
%   dimension-reduction technical of characteristics.
%   Here are some useful reference material:
%   https://www.jianshu.com/p/708ca9fa3023
%   https://blog.csdn.net/qq_38517310/article/details/79387476
%
%   [eigenvalue, X_KPCA] = myKPCA(x, sigma, cls, target_dim)
% 
%   Input - 
%   X: a N*M matrix containing M datas with N dimensions;
%   sigma: a parameter of kernel function;
%   choice: what kind of kernel to be chosen;
%   target_dimension: number of dimensions to be reduced to, normally, target_dimension<N;
%   DIM: specifies a dimension DIM to arrange X.
%       DIM = 1: X(N*M)
%       DIM = 2: X(M*N)
%       DIM = otherwisw: error
%   Output - 
%   X_KPCA: a target_dimension*M matrix containing M datas with target_dimension dimensions, result of KPCA of data X;
% 
%   Copyright (c) 2018 CHEN Tianyang
%   more info contact: tychen@whu.edu.cn

%%
% parameter number check
narginchk(4,5);
narg = numel(varargin);
DIM = [];
switch narg
    case 0
    case 1
        DIM = varargin{:};
    otherwise
        error('Error! Input parameter error.');
end
if isempty(DIM)
    DIM = 1;
end
if DIM == 2
    X = X';
elseif DIM~=1 && DIM~=2
    error('Error! Parameter DIM should be either 1 or 2.');
end
% parameter correction test
if ~ismatrix(X)
    error('Error! Input parameter "X" should be a matrix');
end
[N,M] = size(X);        % N*M = ����ά��*����������ÿһ�д���һ������/����
if target_dimension > N
    warning('warning! Parameter "target_dim" is not recommended to be larger than parameter "N".');
elseif target_dimension == N
    warning('Warning! There is no dimension-reduction effect.');
end

%% core algorithm
% ����˾��� K (ʵ�Գƾ���)  ���˾��� K ��size����������Ŀ��
K = zeros(M,M);
for i=1:M
    for j=1:M
        K(i,j)=mykernel(X(:,i),X(:,j),choice,sigma);       % ��ʵ������������2�����������ĵ��
    end
end

% �������Ļ���ĺ˾���KI((ʵ�Գƾ���))
% ���Ļ�:ʹ�þ��󡾸��и��С��ľ�ֵΪ0������Ϊʵ�Գƾ���
% I*k/M: ���� K �ĸ��о�ֵ���� M ��, ������ I*k/M ÿ����ͬ;
% k*I/M: ���� K �ĸ��о�ֵ���� M ��, ������ k*I/M ÿ����ͬ;
% I*k*I/(M*M): ���� K �������ݾ�ֵ���ɵ�һ��M*M����;
I = ones(M,M);
kI = K-I*K/M-K*I/M+I*K*I/(M*M);

% ��������ֵ����������
[V,D] = eig(kI);
D = diag(D);

% �����ɴ�С���У�����v���в�������
[~, index] = sort(D, 'descend');
V = V(:, index);

% ȡ KI ���� target_dim ������ֵ�����Ӧ���������� ��!!!����������������!!!�� 
% ע������� ����ֵ �� �������� ���� KI �� K ��, ���Ǹ�ά�ռ��е���������
X_KPCA = (V(:, 1:target_dimension))';    % X_KPCA �������ԭ���� X ���� KPCA ֮��õ���     

end