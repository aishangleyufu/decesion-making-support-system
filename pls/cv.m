%交叉验证法确定主元个数（比较耗时）：
%将样本集分为若干组，剔除一组，利用余下的样本来建立PLS模型，再用剔除的那组样本作为检验样本，
%计算模型在其上的预测误差，然后重复上述步骤，直至将每组数据都剔除过一次。
%将每组数据的模型预测误差求和得到预测残差累积平方和（PRESS）。
%分别计算取不同个数的特征向量时所对应的PRESS，取PRESS最小时的特征向量数目作为PLS模型最后保留的的特征向量数目。
function [h] = cv(X, y)
[n] = size(X,1);
r = rank(X);

for h = 1:r
    
    for i = 1:n
        
        Xcv = [ X(1:i-1,:); X(i+1:n,:) ];
        ycv = [ y(1:i-1,:); y(i+1:n,:) ];
        [A]=coe(Xcv, ycv, h);
        yi(i,h) = [1,X(i,:)]*A';
    end
    PRESS(h) = sum((y-yi(:,h)).^2);
end

[val,h] = min(PRESS);
h;
end

