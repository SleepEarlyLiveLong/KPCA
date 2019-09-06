% ���� PCA �� KPCA �����ݵĽ�ά����
% PCAKPCA_test.m:
%   This file is used for testing the KPCA( Kernel Principle Component
%   Analysis) algorithm and its difference between PCA, I generated some
%   data first and compare ther result of PCA and KPCA separately.
%
%   Copyright (c) 2018 CHEN Tianyang
%   more info contact: tychen@whu.edu.cn

%%
clear; close;

%% �����޸�˹�Ŷ��ķ����Կɷֵ���������
datanum = 100;
[X1, X2, X3] = mygenerate_data(datanum,2);

% ���������ݵ�ԭͼ
figure;
plot(X1(1,:),X1(2,:),'b.');
hold on;
plot(X2(1,:),X2(2,:),'g*');
plot(X3(1,:),X3(2,:),'ro');
axis equal;

X = [X1 X2 X3];
[nFea, nSmps] = size(X);
nClsSmps = nSmps/3;

%% ������������ PCA
% ----------------------- ���� -----------------------
k=2;            % PCA ������ά��
Res = myPCA(X,k);
P = Res.P;
Y = Res.Y;
center = Res.center;
% ----------------------- ��ͼ -----------------------
plot(Y(1,1:nClsSmps),Y(2,1:nClsSmps),'b.');
hold on;
plot(Y(1,nClsSmps+1:2*nClsSmps),Y(2,nClsSmps+1:2*nClsSmps),'g*');
plot(Y(1,2*nClsSmps+1:3*nClsSmps),Y(2,2*nClsSmps+1:3*nClsSmps),'ro');
axis equal;
% �任ǰ�㼯�������ɢ��
myarrow(center,10*P(1,:),'g');
myarrow(center,10*P(2,:),'b');
% �任��㼯�������ɢ��(����X��Y��)
myarrow([0 0],10*[1 0],'g');
myarrow([0 0],10*[0 1],'b');

%% ������������ KPCA
% ----------------------- ���� -----------------------
percent = 1;
choice   = 2;          % 1�����˹�ˣ�2�������ʽ�ˣ�3�������Ժ�
sigma = 5;             % �˲���
R = 2;                 % KPCA��ά������ά��
X_kpca = myKPCA(X, sigma, choice, R);
% ----------------------- ��ͼ -----------------------
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
