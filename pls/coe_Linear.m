%训练模型 返回回归参数A及模型参数P，B，Q——用于线性模型
function [A,P,B,Q,T,R]=coe_Linear(X,Y,h) %对一般X,Y数据集，求参数A,P,B,Q
%[n,m] = size(X);
stdX = std(X);            %求输入矩阵相应列的标准差
stdY = std(Y);
%[P,B,Q,T,Ws,a] = nipals(X,Y,h);   %求取模型解的‘非线性迭代部分最小二乘算法’
[P,B,Q,T,Ws,a] = nipals_Linear(X,Y,h);   %求取模型解的‘非线性迭代部分最小二乘算法’
R = Ws;
ai = a' * stdY ./ stdX;           %回归系数A
%a0 = mean(Y) - sum( ( a' * stdY ./ stdX ) .* mean(X) );
a0 = mean(Y) - sum(ai.* mean(X));
%a0;
A = [a0,ai];
end

