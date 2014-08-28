function [X]=dif(f)
N=length(f);
X=zeros(1,N);
if(N>2)
    n=0:N/2-1;
    wk=exp(-2*pi*n*j/N);
    f1=f(1:N/2)+f(N/2+1:N);
    f2=wk.*(f(1:N/2)-f(N/2+1:N));
    %N=N/2;
    F1=dif(f1);
    F2=dif(f2);
    for i=1:N/2
        X(2*i-1)=F1(i);
        X(2*i)=F2(i);
    end
else
    X(1)=f(1)+f(2);
    X(2)=f(1)-f(2);
end
X=abs(X);
end
