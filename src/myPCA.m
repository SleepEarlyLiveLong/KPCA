function Res = myPCA(X,target_dimension,varargin)
%MYPCM - The Principal Component Analysis(PCA) function.
%   To calculate the result after PCA, one kind of 
%   dimension-reduction technical of characteristics.
%   Here are some useful reference material:
%   https://www.jianshu.com/p/2fad63faa773
%   http://blog.codinglabs.org/articles/pca-tutorial.html
%
%   Res = myPCA(X,target_dimension)
%   Res = myPCA(X,target_dimension,DIM)
% 
%   Input - 
%   X: a N*M matrix containing M datas with N dimensions;
%   target_dimension: number of dimensions to be reduced to, normally, target_dimension<N;
%   DIM: specifies a dimension DIM to arrange X.
%       DIM = 1: X(N*M)
%       DIM = 2: X(M*N)
%       DIM = otherwisw: error
%   Output - 
%   Res  : the result of PCA of the input matrix X;
%       Res.P: a target_dimension*N matrix containing target_dimension bases with N dimensions;
%       Res.Y: a target_dimension*M matrix containing M datas with target_dimension dimensions;
%       Res.contrb: a target_dimension*1 vector containing the contribution rate 
%                   of each principal component.
%       Res.sumcontrb: a scaler means the sum contribution rate
%                   of all principal components.
% 
%   Copyright (c) 2018 CHEN Tianyang
%   more info contact: tychen@whu.edu.cn

%% parameter test
% parameter number test
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
if ~ismatrix(X) || ~isreal(target_dimension)
    error('Error! Input parameters error.');
end
[N,M] = size(X);
if target_dimension > N
    error('Error! The 2nd parameter should be smaller than the col. of the 1st one.');
elseif target_dimension == N
    warning('Warning! There is no dimension-reduction effect.');
end

%% core algorithm
center = mean(X,2);
X = X - repmat(center,1,M);      % zero_centered for each LINE/Field
C = X*(X')/M;                       % the Covariance matrix of X, C(N*N)
[eigenvector,eigenvalue] = eig(C);
[B,order] = sort(diag(eigenvalue),'descend');
% calculate contribution-rate matrix
contrb = zeros(target_dimension,2);
contrb(:,1) = B(1:target_dimension)/sum(B);             
for i=1:target_dimension
    contrb(i,2) = sum(contrb(1:i,1));
end
P = zeros(target_dimension,N);
% convert eigenvectors from columns to lines.
for i=1:target_dimension
    P(i,:) = eigenvector(:,order(i))';
end
Y = P*X;

%% get result
Res.contrb = contrb;
Res.P = P;
Res.Y = Y;
Res.center = center;

end