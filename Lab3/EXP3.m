%Sampling characteristics
Fs = 10000;
Ts = 1/Fs;

%Generating the signal
A = [40 50 10];
f = [100 200 4000];

n = 1:1000;
x = zeros(1,length(n));
for i=1:3
    x = x + A(i)*sin(2*pi*f(i)*n*Ts);
end

%Designing a low pass filter to filter out noise
Fc = 1000;
M = 71; %Filter length
n = -(M-1)/2:(M-1)/2;
%using rectuangular window
h = (2*Fc/Fs)*sinc((2*Fc/Fs)*(n));
plot(h);
fvtool(h);

%using bartlett window
h1 = h.*bartlett(M)';
fvtool(h1);
%using hanning window
h2 = h.*hanning(M)';
fvtool(h2);
%using Hamming window
h3 = h.*hamming(M)';
fvtool(h3);
%using the Blackmann window
h4 = h.*blackman(M)';
fvtool(h4);
%plot(bartlett(M));

y  = convolve(x,h);
y1 = convolve(x,h1);
y2 = convolve(x,h2);
y3 = convolve(x,h3);
y4 = convolve(x,h4);
subplot(6,1,1), plot(Ts*[1:length(x)], x);
subplot(6,1,2), plot(Ts*[1:length(y)], y);
subplot(6,1,3), plot(Ts*[1:length(y1)], y1);
subplot(6,1,4), plot(Ts*[1:length(y2)], y2);
subplot(6,1,5), plot(Ts*[1:length(y3)], y3);
subplot(6,1,6), plot(Ts*[1:length(y4)], y4);

% x1 = sin(2*pi*f1*n*Ts);
% x2 = sin(2*pi*f2*n*Ts);
% y  = xcorr(x1, x2);
% subplot(3,1,1), plot(x1);
% subplot(3,1,2), plot(x2);
% subplot(3,1,3), plot(y);
% 
% for f = 1:10:50000
%     x2 = sin(2*pi*f*n*Ts);
%     subplot(3,1,2), plot(x2);
%     title(sprintf('Frequency: %d', f));
%     y = xcorr(x1, x2);
%     subplot(3,1,3), plot(y);
%     title(sprintf('Maxval: %f', max(y)));
%     pause(0.0000001);
% end
