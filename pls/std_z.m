function X=std_z(X0,xmean,xstd)             %对X按列进行标准化
[n,m]=size(X0);
%X=zeros(n,m);
for i=1:n
    %size(X0(i,:));
    %size(xmean);
    %size(xstd);
     X(i,:)=(X0(i,:)-xmean)./xstd;
end
end

