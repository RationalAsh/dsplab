clear all;
Fs = 10000;
Ts = 1/Fs;

A = [40 50 10];
f = [300 200 4000];
n = 1:500;
x = zeros(1,length(n));

%Filter designed using bilinear mapping
num = [0.166667 0.5 0.5 0.166667];
den = [1 0 0.333333 0];
b = num;
a = den;
ord = 3;

%Filter designed using the impulse invariance method
[b1, a1] = butter(3, 2500*2*pi, 's');
[bz, az] = impinvar(b1, a1, Fs);
%bz = [0.0000 0.5813 0.2114 0];
%az = [1.0000 -0.3984 0.2475 -0.0432];
ord = 3;

%Filter designed using Impulse Invariance technique

for i=1:3
    x = x + A(i)*sin(2*pi*f(i)*n*Ts);
end

%Filtering using the bilinear filter
y = zeros(1,length(x));
M = zeros(1, ord);

for i = 1:length(x)
    %y = iirfilter(x(i));
    w = x(i) - dot(den(2:length(den)), M);
    y(i) = (w)*num(1) + dot(num(2:length(num)), M);
    %update memory elements
    M(3) = M(2);
    M(2) = M(1);
    M(1) = w;
end

%Filtering using the impulse invariant filter
y1 = zeros(1, length(x));
M  = zeros(1,ord);
for(i = 1:length(x))
    w = x(i) - dot(az(2:length(az)), M);
    y1(i) = w*b(1) + dot(b(2:length(b)), M);
    
    %update memory elements
    M(3) = M(2);
    M(2) = M(1);
    M(1) = w;
end

subplot(3,1,1), plot(x);
subplot(3,1,2), plot(y);
subplot(3,1,3), plot(y1);

