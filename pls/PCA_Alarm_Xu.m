%�����Լ�����ģ�ͣ�����Ũ�ܻ��Ļ���������������+��̬ģ��
%�����Ժ��������ͺ͡�PCA-Alarm_Error�����ģ�Ͷ�Ӧ
close all;
clear all;
clc;
%w=2;      %���ݿ���г���
%f_f=0.99; %��������
s=1;     %���ݿ���,�ɵ�����s=1ʱ������һ��ѧһ������s=200ʱ������200������Ϊһ�����ݿ飬���ļ�������ʱ��
%----------------------------------------
disp('*****************************************************')
disp('**********����+��̬ ģ��***********************')
disp('*****************************************************')
%---------����ģ��-------------

%Ũ�ܻ�����ģ��1.1

%���ο����ڽ����г���ĩ��V0
k=54.5;
x=2;
y=1;
z=1;
gma=0.085;                                    %��������ϵ��

%d=0.00606;                                   %��������cm
d_acid=0.00556;
d_alkaline=0.00606;
d_underflow=0.00506;

D_sludge=2.7;                                %�����ܶ�g/cm3
D_water=1;                                   %ˮ(����)�ܶ�g/cm3
%--------��ʱ�����---------
%Mu=0.1;                                     %������ˮ��ճ�ȣ�����1��=0.1��*s
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
    %V0=k*d^x*(D_sludge-D_water)^y*Mu^(-z)*gma;   %����ĩ��cm/s
    %V0=36*V0;                                    %��λ����m/h
    V0_acid=k*d_acid^x*(D_sludge-D_water)^y*Mu(i)^(-z)*gma;
    V0_acid=36*V0_acid;
    V0_alkaline=k*d_alkaline^x*(D_sludge-D_water)^y*Mu(i)^(-z)*gma;
    V0_alkaline=36*V0_alkaline;
    V0_underflow=k*d_underflow^x*(D_sludge-D_water)^y*Mu(i)^(-z)*gma;
    V0_underflow=36*V0_underflow;


    H0=4.0;                                      %Ũ�ܳظ߶�m
    A=3.14*30*30;                                %�������m2

    C_acid=0.05;                                 %��ˮŨ��
    C_alkaline=0.01;                             %��ˮŨ��
    %C_underflow=0.20;                           %����Ũ��,Ҳ�Ƿ�ɰŨ��

    D_acid=1.0176;                               %��ˮ��Һ��g/cm3
    D_alkaline=1.0028;                           %��ˮ��Һ��g/cm3
    %D_underflow=C_underflow*0.0076+1;            %������Һ��,Ҳ�Ƿ�ɰ��Һ��g/cm3
    %t=(H0-Hn_Last)/V0;                           %����ʱ��h  
    t_acid=H0/V0_acid;
    t_alkaline=H0/V0_alkaline;
    t_underflow=H0/V0_underflow;
    t_iter=30.0;

    %W=(Q_acid*D_acid*C_acid)*t_acid+(Q_alkaline*D_alkaline*C_alkaline)*t_alkaline+((Q_return*t_underflow-Q_underflow*t_iter)*D_underflow*C_underflow);   %���Ϲ�����t

    %Hn=W/(A*D_underflow*C_underflow);
    %----------------------------------------------------------------------
    %Q_acid=5-0.2*i;                                          %��ˮ����m3/h
    Q_acid=300+200*sin((i-50)*4*pi/300);
    X_1=[X_1 Q_acid];  
    
    Q_alkaline=1000-300*sin(i*4*pi/300);                        %��ˮ����m3/h
    X_2=[X_2 Q_alkaline];
    
    %Q_return=50+10*rand(1);                                      %��ɰ����m3/h
    %%Q_return=50+10*rand(); 
    %Q_return=5+1*rand(1); 
    Q_return=50+10*sin((i+50)*4*pi/300); 
    X_3=[X_3 Q_return];
    
    %Q_underflow=1.0+0.1*exp(-0.001*i);
    %Q_underflow=1.0+0.1*(0.001*i)^2;
    Q_underflow=150-20*sin((i+200)*4*pi/300);                  %��������m3/h
    X_4=[X_4 Q_underflow];
    
    %C_underflow=0.20+0.00005*i;                               %����Ũ��,Ҳ�Ƿ�ɰŨ��
    C_underflow=0.20+0.005*sin(i*4*pi/300); 
    X_5=[X_5 C_underflow];
    
    D_underflow=C_underflow*0.0076+1;

    W=(Q_acid*D_acid*C_acid)*t_acid+(Q_alkaline*D_alkaline*C_alkaline)*t_alkaline+((Q_return*t_underflow-Q_underflow*t_iter)*D_underflow*C_underflow);   %���Ϲ�����t
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
%----------ѵ�����Լ�-------------

alpha=0.90;
number = 200;%0.2*I;
%PLS��ģ����Ipls�����������number-Ipls��
Ipls = 0.10*number;%%%���ڳ�ʼ����ģ��
%Ipls = 0.80*number;%%%�����Լ���д��ģ��

turningPoint1 = turningPoint1 - number ;
turningPoint2 = turningPoint2 - number ;

mu0 = zeros(0.01*I,1);
mu = [Mu(number+1:I,:);mu0];

%----------ѵ��������Լ�------------- 
trnX=X1(1:number,:);           %ѵ����
trnY=Y(1:number,:);
tstX=X1(number+1:end,:);       %���Լ�
tstY=Y(number+1:end,:);
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
