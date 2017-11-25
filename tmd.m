function [ zhenfubi ] = tmd( INPUTi,lamda ,miu)
%please input the gama and kesi, remember that input the kesi when gama input is completely finished  

%lamda加振频率比
INPUT=reshape(INPUTi,numel(INPUTi)/2,2);
a=size(INPUT,1);%a 为阻尼吸振器级数
miuni=miu/a;%miu为n重动力吸振器zhong质量比,单个吸振器质量比要除以n(miu为mius，单一动力吸振器的质量比)
gama=INPUT(:,1);%第i个动力吸振器的固有频率比
kesi=INPUT(:,2);%第i个动力吸振器的阻尼比
kesizhu=0;%主系统的振动阻尼比
 
%***************generate the mass matrix m ************************
m=zeros(a+1,a+1);
m(1,1)=1;
for i=2:a+1
    m(i,i)=miuni;
end
%******************************************************************

%***************generate the damp matrix c ************************
c=zeros(a+1,a+1);
for i=2:a+1
    c(1,i)=-miuni*gama(i-1)*kesi(i-1);
    c(i,1)=-miuni*gama(i-1)*kesi(i-1);
    c(i,i)=miuni*gama(i-1)*kesi(i-1);
end
c(1,1)=kesizhu-sum(c(2:a+1,1));

%******************************************************************

%***************generate the stiffness matrix k *******************
k=zeros(a+1,a+1);
for i=2:a+1
    k(1,i)=-miuni*gama(i-1)^2;
    k(i,1)=-miuni*gama(i-1)^2;
    k(i,i)= miuni*gama(i-1)^2;
end
k(1,1)=1-sum(k(2:a+1,1));
%******************************************************************

%***************Now,it's time to caculate**************************

AA=-lamda^2*m+1i*lamda*2*c+k;
xx=AA\[1 zeros(1,a)]';
zhenfubi=abs(xx(1));





end


