% TODO: Write my own code for convolution instead of using the inbuilt one.

Fs = 10000;
Ts = 1/Fs;
fi = [1000 2500 3000 4000 5000];
S = zeros(1,200);
% 1. Generate the signal S
for n = 1:500
    S(n) = sum(sin(2*pi*fi*n*Ts));
end
figure(1);
subplot(4,1,1), plot(Ts*[1:length(S)], S);
xlabel('time(s)'); ylabel('S'); title('The original signal');

%Window filters
h1 = [-0.0011 0.0048 0.0006 -0.0316 0.0275 0.0975 -0.1298 -0.2263 0.3153 0.7511 0.4946 0.1115];
h2 = [-0.1115 0.4946 -0.7511 0.3153 0.2263 -0.1298 -0.0975 0.0275 0.0316 0.0006 -0.0048 0.0011];
h3 = [0.1115 0.4946 0.7511 0.3153 -0.2263 -0.1298 0.0975 0.0275 -0.0316 0.0006 0.0048 -0.0011];
h4 = [-0.0011 -0.0048 0.0006 0.0316 0.0275 -0.0975 -0.1298 0.2263 0.3153 -.7511 0.4946 -0.1115];

%Checking the responses of the filters
figure(2);
[h, w] = freqz(h1, [1]);
subplot(2,2,1), plot(w*Fs/(2*pi), abs(h));
xlabel('Frequency'); ylabel('Magnitude'); title('Magnitude response of h1');
[h, w] = freqz(h2, [1]);
subplot(2,2,2), plot(w*Fs/(2*pi), abs(h));
xlabel('Frequency'); ylabel('Magnitude'); title('Magnitude response of h2');
[h, w] = freqz(h3, [1]);
subplot(2,2,3), plot(w*Fs/(2*pi), abs(h));
xlabel('Frequency'); ylabel('Magnitude'); title('Magnitude response of h3');
[h, w] = freqz(h4, [1]);
subplot(2,2,4), plot(w*Fs/(2*pi), abs(h));
xlabel('Frequency'); ylabel('Magnitude'); title('Magnitude response of h4');
figure(1);

% 2. Convolve signal with h1 to get y1
L = length(h1);
M = length(S);
y1 = zeros(1, L+M-1);
ctemp = fliplr(h1);
%y1 = convolve(S, h1);
y1 = overlapadd(S, h1, 50);
subplot(4,1,2), plot(Ts*[1:length(y1)], y1);
xlabel('time(s)'); ylabel('Y1'); title('S convolved with h1');

%I have to replace every other sample with a zero. This
%is a little trick to do just that. I'll explain how it
%works so that I can understand it later.
%First I create an array of the increasing numbers from
%one to the length of the array. Then I get the remainder
%of each number when divided by two. This gives me an array
%of alternating ones and zeros that are the same size as the
%array. Then I multiply this array with the sequence element
%by element so that every other sameple is replaced by a zero.

% 3. Replace alternative samples of y1 with zeros to obtain y2
y2 = y1.*mod([1:length(y1)], 2);
%subplot(5,1,3), plot(Ts*[1:length(y2)], y2);

% 4. Convolve the signal with h2 to get y3
%y3 = convolve(S, h2);
y3 = overlapadd(S, h2, 50);
subplot(4,1,3), plot(Ts*[1:length(y3)], y3);
xlabel('time(s)'); ylabel('y3'); title('S convolved with h2');


% 5. Replace alternative samples of y3 with zeros to obtain y4
y4 = y3.*mod([1:length(y3)], 2);

% 6. Convolve the signal y2 with h3 to get out1
%out1 = convolve(y2, h3);
out1 = overlapadd(y2, h3, 7);

% 7. Convolve y4 with h4 to get out2
%out2 = convolve(y4, h4);
out2 = overlapadd(y4, h4, 7);

subplot(4,1,4), plot([1:length(out1+out2)],out1 + out2)
xlabel('time(s)'); ylabel('out1+out2'); title('Sum of out1 and out2');

%Plotting the spectra of the signals
figure(3);
subplot(4,1,1), plot([-Fs/2:Fs/length(S):Fs/2-Fs/length(S)],abs(fftshift(fft(S))));
xlabel('Frequency'); ylabel('S'); title('Spectrum of Original signal');
subplot(4,1,2), plot([-Fs/2:Fs/length(y1):Fs/2-Fs/length(y1)],abs(fftshift(fft(y1))));
xlabel('Frequency'); ylabel('y1'); title('Spectrum of y1');
subplot(4,1,3), plot([-Fs/2:Fs/length(y3):Fs/2-Fs/length(y3)],abs(fftshift(fft(y3))));
xlabel('Frequency'); ylabel('y3'); title('Spectrum of y3');
subplot(4,1,4), plot([-Fs/2:Fs/length(out1+out2):Fs/2-Fs/length(out1+out2)],abs(fftshift(fft(out1+out2))));
xlabel('Frequency'); ylabel('out1+out2'); title('Spectrum of out1+out2');