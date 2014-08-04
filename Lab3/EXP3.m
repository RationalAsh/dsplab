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

%window functions
M = 71;
n = 0:M-1;
bart = 1 - abs(n - (M-1)/2)/(M/2);
n = -(M-1)/2:(M-1)/2;
hann = 0.5*(1+cos((2*pi*n)/(M-1)));
hamm = 0.54 + 0.46*cos((2*pi*n)/(M-1));
black = 0.42 + 0.5*cos((2*pi*n)/(M-1)) + 0.08*cos((4*pi*n)/(M-1));
figure();
subplot(5,1,1), plot(bart);
title('Bartlett');
subplot(5,1,2), plot(hann);
title('Hanning');
subplot(5,1,3), plot(hamm);
title('Hamming');
subplot(5,1,4), plot(black);
title('Blackman');
subplot(5,1,5), plot(zeros(1,M)+1);
title('Rectangular');

%Designing a low pass filter to filter out noise
Fc = 1000;
M = 71; %Filter length
n = -(M-1)/2:(M-1)/2;
%using rectuangular window
h = (2*Fc/Fs)*sinc((2*Fc/Fs)*(n));
%plot(h);
fvtool(h);


%using bartlett window
%h1 = h.*bartlett(M)';
h1 = h.*bart;
fvtool(h1);
%using hanning window
%h2 = h.*hanning(M)';
h2 = h.*hann;
fvtool(h2);
%using Hamming window
%h3 = h.*hamming(M)';
h3 = h.*hamm;
fvtool(h3);
%using the Blackmann window
%h4 = h.*blackman(M)';
h4 = h.*black;
fvtool(h4);
%plot(bartlett(M));

y  = conv(x,h);
y1 = conv(x,h1);
y2 = conv(x,h2);
y3 = conv(x,h3);
y4 = conv(x,h4);
subplot(6,1,1), plot(Ts*[1:length(x)], x);
title(
subplot(6,1,2), plot(Ts*[1:length(y)], y);
subplot(6,1,3), plot(Ts*[1:length(y1)], y1);
subplot(6,1,4), plot(Ts*[1:length(y2)], y2);
subplot(6,1,5), plot(Ts*[1:length(y3)], y3);
subplot(6,1,6), plot(Ts*[1:length(y4)], y4);


% x1 = sin(2*pi*f1*n*Ts);
% x2 = sin(2*pi*f2*n*Ts);
% y = xcorr(x1, x2);
% subplot(3,1,1), plot(x1);
% subplot(3,1,2), plot(x2);
% subplot(3,1,3), plot(y);
%
% for f = 1:10:50000
% x2 = sin(2*pi*f*n*Ts);
% subplot(3,1,2), plot(x2);
% title(sprintf('Frequency: %d', f));
% y = xcorr(x1, x2);
% subplot(3,1,3), plot(y);
% title(sprintf('Maxval: %f', max(y)));
% pause(0.0000001);
% end
