
%%%%%%%%%*********************************************************************%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%**************采用实际数据模型************%
%%%%%%%%%*********************************************************************%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%该程序解决“b——b1——b2——b3——b”即“正常——变化1——变化2——变化3——正常”的问题，主要是解决“——变化2——”的问题。
%在模型更新时相当于“控制限变化”。
tic;%启动定时器  
close all;
clear all;
clc;

disp('------------------------Welcome to MATLAB !------------------------')
%---------控制模型-------------
deta = xlsread('datx');
X = [deta(:,1:5),deta(:,12:13),deta(:,15)];
Y = deta(:,17);
I = size(deta,1);
%[ virtualChangePoints ] = coefficient_turningPoint(I);
%----------设置参数-------------
alpha=0.90;  %置信限

number = 1200;
Ipls = 0.75*number;
     
s = 1;%数据块宽度%s应该是I-number的因数，I-number就是测试集的样本点数，使用s就是将测试集进行分块。
%----------训练集与测试集------------- 
[ trnX,trnY,tstX,tstY ] = train_test( X,Y,number );
%----------训练集得到的模型参数矩阵-------------
[ Er,Fr ] = Er_Fr_Linear( trnX,trnY );
%----------训练模型-------------
[h]=cv(Er,Fr);                   %[h]=cv(Er, Fr),[val, h]=cv(Er, Fr) 最优特征向量数,可通过交叉验证法[val, h]=cv(Er, Fr)求取，但运算时间过长

h
[AA,PP,BB,QQ,T_PLS,R_PLS]=coe_Linear(Er,Fr,h);
AA

preY_tst = [];
for t = 1:length(tstY)
   %disp('----------%得到测试集的预测模型------------------------------')
   step=t+number;
%%%%%%%%%%%%%%%******利用测试集的当前块建模得到预测输出**********%%%%%%%%%%%%
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
legend('预测值','实际值')
