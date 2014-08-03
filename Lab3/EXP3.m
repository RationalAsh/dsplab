Fs = 10000;
Ts = 1/Fs;

A = [40 50 20];
f = [100 200 1000];

n = 1:1000;
x = zeros(1,length(n));
for i=1:3
    x = x + A(i)*sin(2*pi*f(i)*n*Ts);
end

plot(x)
