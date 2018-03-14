function [ Et ] = Gauss_Er_add( sp,trnX,tstX )%以别块数据为聚类中心点——适用于非线性情况
C = trnX';                  %聚类中心点
trnD = dist(tstX,C);      % D = sqrt(sum((x-y).^2)),dist() 函数就是这么用的
Et = radbas(trnD/sp);      % a = radbas(n);  a = exp(-n^2)

%C = trnX;
%Nx = size(trnX,1);
%Ny = size(tstX,1);
 %for i=1:Ny
 %    for j=1:Nx   
 %        Et(i,j) = exp(-norm(tstX(i,:)-C(j,:))^2/sp);
 %    end
 %end

end

