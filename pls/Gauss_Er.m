function [ Er ] = Gauss_Er( sp,trnX )%�Ա�������Ϊ�������ĵ㡪�������ڷ��������
                           %sp���
C = trnX';                  %�������ĵ�

trnD = dist(trnX,C);      % D = sqrt(sum((x-y).^2)),dist()����������ô�õģ����ǻ����˽��京�塣

Er = radbas(trnD/sp);      % a = radbas(n);  a = exp(-n^2),sp=sqrt(2)*rou
%C = trnX;
%Nx = size(trnX,1);
% for i=1:Nx
%     for j=1:Nx   
%         Er(i,j) = exp(-norm(trnX(i,:)-C(j,:))^2/sp);
%     end
% end

end

