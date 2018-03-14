function [ X1,Y,B,virtualChangePoints ] = Control_Model_Linear_multivariable(I,number,Ipls,error)%——线性模型，且模型参数按分段直线规律变化，且输入变量不服从正态分布
%--------慢时变参数---------
c=0.8*I;
k=I-c;%0.2*I
b = zeros(I,1);


m1 = 0.35;
m2 = 0.7;
m3 = 0.8;
m4 = 0.9;

m5 = 0.7;
m6 = 0.8;
m7 = 0.9;
%m5 = 0.99;
vCP1 = 629; %应为turningPoint1+200-1，且turningPoint1最好是偶数。
%vCP1 = m1*I-67;
vCP2 = m2*I-45;
vCP3 = m3*I-53;
vCP4 = m4*I-113;
vCP5 = m5*I-33;
vCP6 = m6*I-57;
vCP7 = m7*I-73;

%k1 = 0.625;
k1 = 3.0/1; %k1相当于实际斜率的倒数

virtualChangePoints = [vCP1+1;vCP2+1];
%virtualChangePoints = [vCP1+1;vCP2+1;vCP3+1;vCP4+1]';%;vCP5+1;vCP6+1;vCP7+1]';
for i = 1:I

    if i<=vCP1
        b(i) = 1.0;%对于正常数据模型应该是不变的，我之前就没有理解明白，一直在做无用功。
    else if i<=vCP2
    %else 
         b(i) = 1-(i-vCP1)/(k1*c);%c=0.8*I;,k = 0.2*I
         %b(i) = 1+exp(-(10*m1-2)/8)-exp(-(i-k)/(1*c));%c=0.8*I;,k = 0.2*I
         %b(i) = 0.95;
         %b(i) = 1.0;
        %else if i<=vCP3
                %b(i) = 1+exp(-(10*m1-2)/8)-exp(-(i-k)/(1*c));%c=0.8*I;,k = 0.2*I
                %b(i) = 1+((m2-m1)*I-1)/(1*c)+(i-m2*I)/(1*c);%c=0.8*I;,k = %0.2*I
                %b(i) = 1-((m2-m1)*I-1)/(1*c)+(i-m2*I)/(3*c);%该段初始时刻的值与上一段末值的差距很重要。
                %b(i) = 0.90-(i-vCP2)/(3*c);
                %b(i) = 0.4+0.5*exp(-(i-m2*I)/(1*c));%c=0.8*I;,k = 0.2*I
                %b(i) = 1.0-(i-vCP2)/(3*c);   %+(i-m2*I)/(3*c);
                %b(i) = 1-(vCP2-vCP1)/(3*c)+(i-vCP2)/(1*c);
                %b(i) = 1.0;
            %else if i<=vCP4
               %b(i) = 1-exp(-(10*m1-2)/8)+exp(-(10*m2-2)/8)-2*exp(-(10*m3-2)/8)+2*exp(-(i-k)/(1*c));%c=0.8*I;,k = 0.2*I
               %b(i) = 1-((m2-m1)*I-1)/(1*c)-(m3-m2)*I/(2*c)-(i-m3*I)/(6*c);%c=0.8*I;,k = 0.2*I
               %b(i) = 1-((m2-m1)*I-1)/(1*c)-(m3-m2)*I/(3*c)-(i-m3*I)/(3*c);%c=0.8*I;,k = 0.2*I
               %b(i) = 1-((m2-m1)*I-1)/(1*c)-(i-m3*I)/(6*c);%c=0.8*I;,k = 0.2*I
               %b(i) = 1-(vCP2-vCP1)/(3*c)+(vCP3-vCP2)/(1*c);
               %b(i) = 0.90;
               %b(i) = 1-((m2-m1)*I-1)/(1*c)+(m3-m2)*I/(2*c);%c=0.8*I;,k = 0.2*I
                %else %if i<=vCP5
                     %   b(i) = 0.6;
                     %else if i<=vCP6
                     %   b(i) = 0.5;
                     %   else if i<=vCP7
                     %            b(i) = 0.4;
        else
                                 b(i) = 1-(vCP2-vCP1)/(k1*c);
                                 %b(i) = 1.0;
                     %            b(i) = 1.0;
                                 %b(i) = 1-(vCP2-vCP1)/(3*c)+(vCP3-vCP2)/(1*c);
                     %       end
                     %   end
                     %end
                %end
            %end
        end
    end
    
end

%---------控制模型-------------
u1=zeros(I,1);
u2=zeros(I,1);
u3=zeros(I,1);
u4=zeros(I,1);
u5=zeros(I,1);
u6=zeros(I,1);

%y=zeros(1,201);
%y=zeros(I+1,1);
y=zeros(I,1);
X1=[];
Y=[];



for i=1:I

    %u1(i)=(1*i*0.001)^3;%相当于输入一直是无周期地变化的——可以研究此种情况下，在模型没改变时就报错以及模型变化与统计量分布对应与正弦输入（有周期输入）时不同的情况。
    %u2(i)=(2*i*0.001)^2;
    %u3(i)=(3*i*0.001)^1;
    
    %u1(i)=sin(1*pi*i*0.005);
    u1(i)=sin(1*pi*i*0.010);
    %u1(i)=(1*i*0.001)^3;
    
    %u2(i)=sin(1*pi*i*0.010);
    u2(i)=sin(1*pi*i*0.020);
    %u2(i)=exp(-1*i*0.0001);
    %u2(i)=(1*i*0.001)^2;
    
    %u3(i)=sin(1*pi*i*0.015);
    u3(i)=sin(1*pi*i*0.030);
    %u3(i)=(1*i*0.001)^1;
    
    %u3(i)=0.1+0.1*rand(1,1); 
    %u4(i)=sin(4*pi*i*0.01);
    %u5(i)=sin(5*pi*i*0.01);
    %u6(i)=sin(6*pi*i*0.01);
    
    u4(i)=2*u1(i);
    u5(i)=u2(i)+u3(i);
    u6(i)=u1(i)+2*u2(i)+3*u3(i);
    
    %y(i+1)=b(i)*(u(i)+v(i)+w(i));  %+y(i)/(i+y(i)^2);        %y(i+1) = f(u(i),v(i),w(i),y(i)),f(.)函数有四个变量：u,v,w与y。
    %y(i+1)=b(i)*(u1(i)+u2(i)+u3(i)+u4(i)+u5(i)+u6(i));
    
    y(i)=12+b(i)*(u1(i)+u2(i)+u3(i)+u4(i)+u5(i)+u6(i));
    %y(i)=b(i)*(u1(i))+u2(i)+u3(i)+u4(i)+u5(i)+u6(i);
    %z(i+1)=u(i)^3+z(i)/(i+z(i)^2);
end
for j=0.1*Ipls+1:0.9*Ipls
    y(j) = y(j)+error;
end

%noise=randn(1,80);%1*80——行向量，列向量也无所谓，下面相加是单个元素进行。

%for i=200:279
             %y(i+1)=y(i+1)+1.5*sin(pi*(i-199)*0.05);             %含大噪声
%    y(i+1)=y(i+1)+0.1*noise(i-199);             %含噪声
%    u1(i+1)=u1(i+1)+0.1*noise(i-199);             %含噪声
%end
%for i=710:789
    %y(i+1)=y(i+1)+1.5*sin(pi*(i-199)*0.05);             %含大噪声
%    y(i+1)=y(i+1)+0.1*noise(i-709);             %含噪声
%    u1(i+1)=u1(i+1)+0.1*noise(i-709);         %含噪声end
%end

for i=1:I
    
    %X2=[u(i),v(i),w(i)];
    X2=[u1(i),u2(i),u3(i),u4(i),u5(i),u6(i)];
    X1=[X1;X2];
    %Y=[Y;y(i+1)];
    Y=[Y;y(i)];
    
end

B0 = zeros(0.01*I,1);
B = [b(number+1:I,:);B0];

end







