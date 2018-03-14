function [ Er ] = Gauss_Er( sp,trnX )%以本块数据为聚类中心点——适用于非线性情况
                           %sp宽度
C = trnX';                  %聚类中心点

trnD = dist(trnX,C);      % D = sqrt(sum((x-y).^2)),dist()函数就是这么用的，但是还不了解其含义。

Er = radbas(trnD/sp);      % a = radbas(n);  a = exp(-n^2),sp=sqrt(2)*rou
%C = trnX;
%Nx = size(trnX,1);
% for i=1:Nx
%     for j=1:Nx   
%         Er(i,j) = exp(-norm(trnX(i,:)-C(j,:))^2/sp);
%     end
% end

end

