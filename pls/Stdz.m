% ��׼��
%standardize X  IK*J����ʽ
function X=Stdz(X0)             %��X���н��б�׼��
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