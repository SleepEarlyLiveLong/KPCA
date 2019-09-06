function X_KPCA = myKPCA(X, sigma, choice, R, varargin)
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
%   R: number of dimensions to be reduced to, normally, R<N;
%   DIM: specifies a dimension DIM to arrange X.
%       DIM = 1: X(N*M)
%       DIM = 2: X(M*N)
%       DIM = otherwisw: error
%   Output - 
%   X_KPCA: a R*M matrix containing M datas with R dimensions, result of KPCA of data X;
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
[N,M] = size(X);        % N*M = 样本维数*样本数，即每一列代表一个数据/样本
if R > N
    warning('warning! Parameter "target_dim" is not recommended to be larger than parameter "N".');
elseif R == N
    warning('Warning! There is no dimension-reduction effect.');
end

%% core algorithm
% 计算核矩阵 K (实对称矩阵)  【核矩阵 K 的size等于样本数目】
K = zeros(M,M);
for i=1:M
    for j=1:M
        K(i,j)=mykernel(X(:,i),X(:,j),choice,sigma);       % 落实到计算是任意2个【样本】的点积
    end
end

% 计算中心化后的核矩阵KI((实对称矩阵))
% 中心化:使得矩阵【各行各列】的均值为0（本身为实对称矩阵）
% I*k/M: 矩阵 K 的各列均值延拓 M 行, 即矩阵 I*k/M 每行相同;
% k*I/M: 矩阵 K 的各行均值延拓 M 列, 即矩阵 k*I/M 每列相同;
% I*k*I/(M*M): 矩阵 K 所有数据均值构成的一个M*M矩阵;
I = ones(M,M);
kI = K-I*K/M-K*I/M+I*K*I/(M*M);

% 计算特征值与特征向量
[v,e] = eig(kI);
e = diag(e);

% 按序由大到小排列，其中v整列参与排序
[~, index] = sort(e, 'descend');
v = v(:, index);

% 取 KI 最大的 target_dim 个特征值及其对应的特征向量 【!!!特征向量按行排列!!!】 
% 注意这里的 特征值 和 特征向量 都是 KI 或 K 的, 不是高维空间中的特征向量
X_KPCA = (v(:, 1:R))';    % X_KPCA 本身就是原数据 X 经过 KPCA 之后得到的     

end