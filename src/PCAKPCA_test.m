% 测试 PCA 和 KPCA 对数据的降维作用
% PCAKPCA_test.m:
%   This file is used for testing the KPCA( Kernel Principle Component
%   Analysis) algorithm and its difference between PCA, I generated some
%   data first and compare ther result of PCA and KPCA separately.
%
%   Copyright (c) 2018 CHEN Tianyang
%   more info contact: tychen@whu.edu.cn

%%
clear; close;

%% 生成无高斯扰动的非线性可分的三类数据
datanum = 100;
[X1, X2, X3] = mygenerate_data(datanum,2);

% 作三类数据的原图
figure;
plot(X1(1,:),X1(2,:),'b.');
hold on;
plot(X2(1,:),X2(2,:),'g*');
plot(X3(1,:),X3(2,:),'ro');
axis equal;

X = [X1 X2 X3];
[nFea, nSmps] = size(X);
nClsSmps = nSmps/3;

%% 对三类数据做 PCA
% ----------------------- 运算 -----------------------
k=2;            % PCA 保留的维度
Res = myPCA(X,k);
P = Res.P;
Y = Res.Y;
center = Res.center;
% ----------------------- 作图 -----------------------
plot(Y(1,1:nClsSmps),Y(2,1:nClsSmps),'b.');
hold on;
plot(Y(1,nClsSmps+1:2*nClsSmps),Y(2,nClsSmps+1:2*nClsSmps),'g*');
plot(Y(1,2*nClsSmps+1:3*nClsSmps),Y(2,2*nClsSmps+1:3*nClsSmps),'ro');
axis equal;
% 变换前点集的最大离散轴
myarrow(center,10*P(1,:),'g');
myarrow(center,10*P(2,:),'b');
% 变换后点集的最大离散轴(就是X轴Y轴)
myarrow([0 0],10*[1 0],'g');
myarrow([0 0],10*[0 1],'b');

%% 对三类数据做 KPCA
% ----------------------- 运算 -----------------------
percent = 1;
choice   = 2;          % 1代表高斯核，2代表多项式核，3代表线性核
sigma = 5;             % 核参数
R = 2;                 % KPCA升维后保留的维度
X_kpca = myKPCA(X, sigma, choice, R);
% ----------------------- 作图 -----------------------
figure;
plot(X_kpca(1,1:nClsSmps),X_kpca(2,1:nClsSmps), 'b.');
hold on;
plot(X_kpca(1,nClsSmps+1:2*nClsSmps),X_kpca(2,nClsSmps+1:2*nClsSmps), 'g*');
plot(X_kpca(1,2*nClsSmps+1:3*nClsSmps),X_kpca(2,2*nClsSmps+1:3*nClsSmps), 'ro');
title(strcat('KPCA','(choice=',num2str(choice),', sigma=',num2str(sigma),')'));
xlabel('Dimension 1');
ylabel('Dimension 2');
% str = strcat(str, '.jpg');
% saveas(gcf, str)
