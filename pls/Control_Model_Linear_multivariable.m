function [ X1,Y,B,virtualChangePoints ] = Control_Model_Linear_multivariable(I,number,Ipls,error)%��������ģ�ͣ���ģ�Ͳ������ֶ�ֱ�߹��ɱ仯�������������������̬�ֲ�
%--------��ʱ�����---------
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
vCP1 = 629; %ӦΪturningPoint1+200-1����turningPoint1�����ż����
%vCP1 = m1*I-67;
vCP2 = m2*I-45;
vCP3 = m3*I-53;
vCP4 = m4*I-113;
vCP5 = m5*I-33;
vCP6 = m6*I-57;
vCP7 = m7*I-73;

%k1 = 0.625;
k1 = 3.0/1; %k1�൱��ʵ��б�ʵĵ���

virtualChangePoints = [vCP1+1;vCP2+1];
%virtualChangePoints = [vCP1+1;vCP2+1;vCP3+1;vCP4+1]';%;vCP5+1;vCP6+1;vCP7+1]';
for i = 1:I

    if i<=vCP1
        b(i) = 1.0;%������������ģ��Ӧ���ǲ���ģ���֮ǰ��û��������ף�һֱ�������ù���
    else if i<=vCP2
    %else 
         b(i) = 1-(i-vCP1)/(k1*c);%c=0.8*I;,k = 0.2*I
         %b(i) = 1+exp(-(10*m1-2)/8)-exp(-(i-k)/(1*c));%c=0.8*I;,k = 0.2*I
         %b(i) = 0.95;
         %b(i) = 1.0;
        %else if i<=vCP3
                %b(i) = 1+exp(-(10*m1-2)/8)-exp(-(i-k)/(1*c));%c=0.8*I;,k = 0.2*I
                %b(i) = 1+((m2-m1)*I-1)/(1*c)+(i-m2*I)/(1*c);%c=0.8*I;,k = %0.2*I
                %b(i) = 1-((m2-m1)*I-1)/(1*c)+(i-m2*I)/(3*c);%�öγ�ʼʱ�̵�ֵ����һ��ĩֵ�Ĳ�����Ҫ��
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

%---------����ģ��-------------
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

    %u1(i)=(1*i*0.001)^3;%�൱������һֱ�������ڵر仯�ġ��������о���������£���ģ��û�ı�ʱ�ͱ����Լ�ģ�ͱ仯��ͳ�����ֲ���Ӧ���������루���������룩ʱ��ͬ�������
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
    
    %y(i+1)=b(i)*(u(i)+v(i)+w(i));  %+y(i)/(i+y(i)^2);        %y(i+1) = f(u(i),v(i),w(i),y(i)),f(.)�������ĸ�������u,v,w��y��
    %y(i+1)=b(i)*(u1(i)+u2(i)+u3(i)+u4(i)+u5(i)+u6(i));
    
    y(i)=12+b(i)*(u1(i)+u2(i)+u3(i)+u4(i)+u5(i)+u6(i));
    %y(i)=b(i)*(u1(i))+u2(i)+u3(i)+u4(i)+u5(i)+u6(i);
    %z(i+1)=u(i)^3+z(i)/(i+z(i)^2);
end
for j=0.1*Ipls+1:0.9*Ipls
    y(j) = y(j)+error;
end

%noise=randn(1,80);%1*80������������������Ҳ����ν����������ǵ���Ԫ�ؽ��С�

%for i=200:279
             %y(i+1)=y(i+1)+1.5*sin(pi*(i-199)*0.05);             %��������
%    y(i+1)=y(i+1)+0.1*noise(i-199);             %������
%    u1(i+1)=u1(i+1)+0.1*noise(i-199);             %������
%end
%for i=710:789
    %y(i+1)=y(i+1)+1.5*sin(pi*(i-199)*0.05);             %��������
%    y(i+1)=y(i+1)+0.1*noise(i-709);             %������
%    u1(i+1)=u1(i+1)+0.1*noise(i-709);         %������end
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







