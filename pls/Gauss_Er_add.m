function [ Et ] = Gauss_Er_add( sp,trnX,tstX )%�Ա������Ϊ�������ĵ㡪�������ڷ��������
C = trnX';                  %�������ĵ�
trnD = dist(tstX,C);      % D = sqrt(sum((x-y).^2)),dist() ����������ô�õ�
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

