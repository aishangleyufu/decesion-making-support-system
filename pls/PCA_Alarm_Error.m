%��ģ���Խ�ģ�ͣ���΢�е����������ҷֲ�

tic;%������ʱ��
close all;
clear all;
clc;

disp('------------------------Welcome to MATLAB !------------------------')
disp('*****************************************************')
disp('**********PCA_Alarm_Error ģ��***********************')
disp('*****************************************************')
%----------���ò���-------------
alpha = 0.90;  %������
lambda = 0.9;
I = 2000;
number = 0.1*I;%ҪС���������ݵĸ���0.3*I
Ipls = 0.25*number;
%Ipls = 0.90*number;


%s = 0.1*I;      %���ݿ���%sӦ����I-number��������I-number���ǲ��Լ�������������ʹ��s���ǽ����Լ����зֿ顣
s = 1;

error = 0.3;

%---------����ģ��-------------
[ X,Y,B,virtualChangePoints ] = Control_Model_Linear_multivariable(I,number,Ipls,error);
mu = 0.01*B;
turningPoint1 = virtualChangePoints(1);
turningPoint2 = virtualChangePoints(2);

turningPoint1 = turningPoint1 - number ;
turningPoint2 = turningPoint2 - number ;
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
