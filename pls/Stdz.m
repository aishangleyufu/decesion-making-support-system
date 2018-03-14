% 标准化
%standardize X  IK*J的形式
function X=Stdz(X0)             %对X按列进行标准化
[n,m]=size(X0);
X=zeros(n,m);
for j=1:m
    if std(X0(:,j))==0;
       X(:,j)=0;
    else
       X(:,j)=(X0(:,j)-mean(X0(:,j)))./std(X0(:,j));
    end
end
end