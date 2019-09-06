function Res = myPCA(X,R,varargin)
%MYPCM - The Principal Component Analysis(PCA) function.
%   To calculate the result after PCA, one kind of 
%   dimension-reduction technical of characteristics.
%   Here are some useful reference material:
%   https://www.jianshu.com/p/2fad63faa773
%   http://blog.codinglabs.org/articles/pca-tutorial.html
%
%   Res = myPCA(X,R)
%   Res = myPCA(X,R,DIM)
% 
%   Input - 
%   X: a N*M matrix containing M datas with N dimensions;
%   R: number of dimensions to be reduced to, normally, R<N;
%   DIM: specifies a dimension DIM to arrange X.
%       DIM = 1: X(N*M)
%       DIM = 2: X(M*N)
%       DIM = otherwisw: error
%   Output - 
%   Res  : the result of PCA of the input matrix X;
%       Res.P: a R*N matrix containing R bases with N dimensions;
%       Res.Y: a R*M matrix containing M datas with R dimensions;
%       Res.contrb: a R*1 vector containing the contribution rate 
%                   of each principal component.
%       Res.sumcontrb: a scaler means the sum contribution rate
%                   of all principal components.
% 
%   Copyright (c) 2018 CHEN Tianyang
%   more info contact: tychen@whu.edu.cn

%% parameter test
% parameter number check
narginchk(2,3);
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
if ~ismatrix(X) || ~isreal(R)
    error('Error! Input parameters error.');
end
[N,M] = size(X);
if R > N
    error('Error! The 2nd parameter should be smaller than the col. of the 1st one.');
elseif R == N
    warning('Warning! There is no dimension-reduction effect.');
end

%% core algorithm
center = mean(X,2);
X = X - repmat(center,1,M);      % zero_centered for each LINE/Field
C = X*(X')/M;                       % the Covariance matrix of X, C(N*N)
[eigenvector,eigenvalue] = eig(C);
[B,order] = sort(diag(eigenvalue),'descend');
% calculate contribution-rate matrix
contrb = zeros(R,2);
contrb(:,1) = B(1:R)/sum(B);             
for i=1:R
    contrb(i,2) = sum(contrb(1:i,1));
end
P = zeros(R,N);
% convert eigenvectors from columns to lines.
for i=1:R
    P(i,:) = eigenvector(:,order(i))';
end
Y = P*X;

%% get result
Res.contrb = contrb;
Res.P = P;
Res.Y = Y;
Res.center = center;

end