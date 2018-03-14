%采用自己所建模型（依据浓密机的机理）————正弦+正态模型
%——以后这个程序就和“PCA-Alarm_Error”这个模型对应
close all;
clear all;
clc;
%w=2;      %数据块队列长度
%f_f=0.99; %遗忘因子
s=1;     %数据块宽度,可调，当s=1时，即来一个学一个；当s=200时，即以200个点作为一个数据块，大大的减少运算时间
%----------------------------------------
disp('*****************************************************')
disp('**********正弦+正态 模型***********************')
disp('*****************************************************')
%---------控制模型-------------

%浓密机机理模型1.1

%球形颗粒在介质中沉降末速V0
k=54.5;
x=2;
y=1;
z=1;
gma=0.085;                                    %球形修正系数

%d=0.00606;                                   %颗粒粒度cm
d_acid=0.00556;
d_alkaline=0.00606;
d_underflow=0.00506;

D_sludge=2.7;                                %颗粒密度g/cm3
D_water=1;                                   %水(介质)密度g/cm3
%--------慢时变参数---------
%Mu=0.1;                                     %常温下水的粘度：泊，1泊=0.1帕*s
I = 1000;

Kdeta = 1.01;
kc = 1.5;

%turningPoint1 = 480;
turningPoint1 = 488;
turningPoint2 = 808;
%Mu = zeros(1200,1);
Mu = zeros(I,1);
for l = 1:I %1000
    if l<=turningPoint1
        Mu(l) =0.1;
    else if l<=turningPoint2 
        Mu(l) = 0.1+(l-(turningPoint1+1))*0.0001;
        %Mu(l) = 0.1+(l-(turningPoint1+1))*0.001;
        else
         Mu(l) = 0.1+(turningPoint2 -turningPoint1)*0.0001;
         %Mu(l) = 0.1+(turningPoint2 -turningPoint1)*0.001;
        end
    end
end


Y=[];
X_1=[];
X_2=[];
X_3=[];
X_4=[];
X_5=[];

for i=1:I %1000
    %V0=k*d^x*(D_sludge-D_water)^y*Mu^(-z)*gma;   %沉降末速cm/s
    %V0=36*V0;                                    %单位换算m/h
    V0_acid=k*d_acid^x*(D_sludge-D_water)^y*Mu(i)^(-z)*gma;
    V0_acid=36*V0_acid;
    V0_alkaline=k*d_alkaline^x*(D_sludge-D_water)^y*Mu(i)^(-z)*gma;
    V0_alkaline=36*V0_alkaline;
    V0_underflow=k*d_underflow^x*(D_sludge-D_water)^y*Mu(i)^(-z)*gma;
    V0_underflow=36*V0_underflow;


    H0=4.0;                                      %浓密池高度m
    A=3.14*30*30;                                %沉降面积m2

    C_acid=0.05;                                 %酸水浓度
    C_alkaline=0.01;                             %碱水浓度
    %C_underflow=0.20;                           %底流浓度,也是返砂浓度

    D_acid=1.0176;                               %酸水固液比g/cm3
    D_alkaline=1.0028;                           %碱水固液比g/cm3
    %D_underflow=C_underflow*0.0076+1;            %底流固液比,也是返砂固液比g/cm3
    %t=(H0-Hn_Last)/V0;                           %沉降时间h  
    t_acid=H0/V0_acid;
    t_alkaline=H0/V0_alkaline;
    t_underflow=H0/V0_underflow;
    t_iter=30.0;

    %W=(Q_acid*D_acid*C_acid)*t_acid+(Q_alkaline*D_alkaline*C_alkaline)*t_alkaline+((Q_return*t_underflow-Q_underflow*t_iter)*D_underflow*C_underflow);   %入料固体量t

    %Hn=W/(A*D_underflow*C_underflow);
    %----------------------------------------------------------------------
    %Q_acid=5-0.2*i;                                          %酸水流量m3/h
    Q_acid=300+200*sin((i-50)*4*pi/300);
    X_1=[X_1 Q_acid];  
    
    Q_alkaline=1000-300*sin(i*4*pi/300);                        %碱水流量m3/h
    X_2=[X_2 Q_alkaline];
    
    %Q_return=50+10*rand(1);                                      %返砂流量m3/h
    %%Q_return=50+10*rand(); 
    %Q_return=5+1*rand(1); 
    Q_return=50+10*sin((i+50)*4*pi/300); 
    X_3=[X_3 Q_return];
    
    %Q_underflow=1.0+0.1*exp(-0.001*i);
    %Q_underflow=1.0+0.1*(0.001*i)^2;
    Q_underflow=150-20*sin((i+200)*4*pi/300);                  %底流流量m3/h
    X_4=[X_4 Q_underflow];
    
    %C_underflow=0.20+0.00005*i;                               %底流浓度,也是返砂浓度
    C_underflow=0.20+0.005*sin(i*4*pi/300); 
    X_5=[X_5 C_underflow];
    
    D_underflow=C_underflow*0.0076+1;

    W=(Q_acid*D_acid*C_acid)*t_acid+(Q_alkaline*D_alkaline*C_alkaline)*t_alkaline+((Q_return*t_underflow-Q_underflow*t_iter)*D_underflow*C_underflow);   %入料固体量t
    %Hn=W/(A*D_underflow*C_underflow);
    Hn=1+W/(A*D_underflow*C_underflow);
    
    Y=[Y Hn];
    
end
%---------------------------------------------------------

X_1=X_1';
X_2=X_2';
X_3=X_3';
X_4=X_4';
X_5=X_5';
Y=Y';

X1=[X_1 X_2 X_3 X_4 X_5];
%----------训练测试集-------------

alpha=0.90;
number = 200;%0.2*I;
%PLS建模数据Ipls个，监测数据number-Ipls个
Ipls = 0.10*number;%%%用于初始所给模型
%Ipls = 0.80*number;%%%用于自己所写的模型

turningPoint1 = turningPoint1 - number ;
turningPoint2 = turningPoint2 - number ;

mu0 = zeros(0.01*I,1);
mu = [Mu(number+1:I,:);mu0];

%----------训练集与测试集------------- 
trnX=X1(1:number,:);           %训练集
trnY=Y(1:number,:);
tstX=X1(number+1:end,:);       %测试集
tstY=Y(number+1:end,:);
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
