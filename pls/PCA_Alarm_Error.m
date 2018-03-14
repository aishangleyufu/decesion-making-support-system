%建模（自建模型，略微有点误差）——正弦分布

tic;%启动定时器
close all;
clear all;
clc;

disp('------------------------Welcome to MATLAB !------------------------')
disp('*****************************************************')
disp('**********PCA_Alarm_Error 模型***********************')
disp('*****************************************************')
%----------设置参数-------------
alpha = 0.90;  %置信限
lambda = 0.9;
I = 2000;
number = 0.1*I;%要小于正常数据的个数0.3*I
Ipls = 0.25*number;
%Ipls = 0.90*number;


%s = 0.1*I;      %数据块宽度%s应该是I-number的因数，I-number就是测试集的样本点数，使用s就是将测试集进行分块。
s = 1;

error = 0.3;

%---------控制模型-------------
[ X,Y,B,virtualChangePoints ] = Control_Model_Linear_multivariable(I,number,Ipls,error);
mu = 0.01*B;
turningPoint1 = virtualChangePoints(1);
turningPoint2 = virtualChangePoints(2);

turningPoint1 = turningPoint1 - number ;
turningPoint2 = turningPoint2 - number ;
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
