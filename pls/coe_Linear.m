%ѵ��ģ�� ���ػع����A��ģ�Ͳ���P��B��Q������������ģ��
function [A,P,B,Q,T,R]=coe_Linear(X,Y,h) %��һ��X,Y���ݼ��������A,P,B,Q
%[n,m] = size(X);
stdX = std(X);            %�����������Ӧ�еı�׼��
stdY = std(Y);
%[P,B,Q,T,Ws,a] = nipals(X,Y,h);   %��ȡģ�ͽ�ġ������Ե���������С�����㷨��
[P,B,Q,T,Ws,a] = nipals_Linear(X,Y,h);   %��ȡģ�ͽ�ġ������Ե���������С�����㷨��
R = Ws;
ai = a' * stdY ./ stdX;           %�ع�ϵ��A
%a0 = mean(Y) - sum( ( a' * stdY ./ stdX ) .* mean(X) );
a0 = mean(Y) - sum(ai.* mean(X));
%a0;
A = [a0,ai];
end

