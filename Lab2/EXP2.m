Fs = 10000;
Ts = 1/Fs
fi = [90 100 150 170 220];
S  = zeros(1,200);
for n  = 1:3000
    S(n) = sum(sin(2*pi*fi*n*Ts));
end
subplot(5,1,1), plot(Ts*[1:length(S)], S);

%Filters
h1 = [-0.0011 0.0048 0.0006 -0.0316 0.0275 0.0975 -0.1298 -0.2263 0.3153 0.7511 0.4946 0.1115];
h2 = [-0.1115 0.4946 -0.7511 0.3153 0.2263 -0.1298 -0.0975 0.0275 0.0316 0.0006 -0.0048 0.0011];
h3 = [0.1115 0.4946 0.7511 0.3153 -0.2263 -0.1298 0.0975 0.0275 -0.0316 0.0006 0.0048 -0.0011];
h4 = [-0.0011 -0.0048 0.0006 0.0316 0.0275 -0.0975 -0.1298 0.2263 0.3153 -.7511 0.4946 -0.1115];

%Convolving with the filter
L = length(h1);
M = length(S);
y1 = zeros(1, L+M-1);
%for(i=1:L)
%    if(
y1 = conv(S, h1);
%y1 = out(1:L+M-1);
subplot(5,1,2), plot(Ts*[1:length(y1)], y1);

%I have to replace every other sample with a zero. This 
%is a little trick to do just that. I'll explain how it 
%works so that I can understand it later.
%First I create an array of the increasing numbers from
%one to the length of the array. Then I get the remainder
%of each number when divided by two. This gives me an array
%of alternating ones and zeros that are the same size as the
%array. Then I multiply this array with the sequence element 
%by element so that every other sameple is replaced by a zero.
y2 = y1.*mod([1:length(y1)], 2);
subplot(5,1,3), plot(Ts*[1:length(y2)], y2);
y3 = conv(y2, h2);
subplot(5,1,4), plot(Ts*[1:length(y3)], y3);
