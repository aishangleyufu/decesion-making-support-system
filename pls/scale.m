%��׼�������������


function [E0, F0] = scale(X,Y)
%X=randn(96,11);
%Y=randn(96,4);
[n,m] = size(X);
averX = mean(X);         
stdcovX = std(X);                                         %�����������Ӧ�еı�׼��
E0 = ( X - averX(ones(n,1),:) )./ stdcovX(ones(n,1),:); % ��׼���Ա���
 stdcovY=std(Y); %1*4
 averY=mean(Y);   %1*4
F0 = (Y - averY(ones(n,1),:))./stdcovY(ones(n,1),:);                             % ��׼�������
end
