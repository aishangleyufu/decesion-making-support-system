
%%%%%%%%%*********************************************************************%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%**************����ʵ������ģ��************%
%%%%%%%%%*********************************************************************%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%�ó�������b����b1����b2����b3����b���������������仯1�����仯2�����仯3���������������⣬��Ҫ�ǽ���������仯2�����������⡣
%��ģ�͸���ʱ�൱�ڡ������ޱ仯����
tic;%������ʱ��  
close all;
clear all;
clc;

disp('------------------------Welcome to MATLAB !------------------------')
%---------����ģ��-------------
deta = xlsread('datx');
X = [deta(:,1:5),deta(:,12:13),deta(:,15)];
Y = deta(:,17);
I = size(deta,1);
%[ virtualChangePoints ] = coefficient_turningPoint(I);
%----------���ò���-------------
alpha=0.90;  %������

number = 1200;
Ipls = 0.75*number;
     
s = 1;%���ݿ����%sӦ����I-number��������I-number���ǲ��Լ�������������ʹ��s���ǽ����Լ����зֿ顣
%----------ѵ��������Լ�------------- 
[ trnX,trnY,tstX,tstY ] = train_test( X,Y,number );
%----------ѵ�����õ���ģ�Ͳ�������-------------
[ Er,Fr ] = Er_Fr_Linear( trnX,trnY );
%----------ѵ��ģ��-------------
[h]=cv(Er,Fr);                   %[h]=cv(Er, Fr),[val, h]=cv(Er, Fr) ��������������,��ͨ��������֤��[val, h]=cv(Er, Fr)��ȡ��������ʱ�����

h
[AA,PP,BB,QQ,T_PLS,R_PLS]=coe_Linear(Er,Fr,h);
AA

preY_tst = [];
for t = 1:length(tstY)
   %disp('----------%�õ����Լ���Ԥ��ģ��------------------------------')
   step=t+number;
%%%%%%%%%%%%%%%******���ò��Լ��ĵ�ǰ�齨ģ�õ�Ԥ�����**********%%%%%%%%%%%%
   trnX_block = tstX((t-1)*s+1:t*s,:);
   trnY_block = tstY((t-1)*s+1:t*s);
   Er = trnX_block ;
   preY = [ones(size(Er,1),1),Er]*AA';
   preY_tst = [preY_tst;preY];
end
figure 
plot(preY_tst,'g')
grid on;
hold on;
plot(tstY,'r')
grid on;
legend('Ԥ��ֵ','ʵ��ֵ')