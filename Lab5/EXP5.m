close all;
load('speechsignal.mat');
speech = speechdata;
segsize = 256;

spmat = zeros(segsize/2, length(speech));
%plotting the spectrum
for i=1:(length(speech) - segsize)
    %Get the next overlapping 256 samples
    x = speech(i:i+segsize -1);
    %Multpiply by the window
    win = hamming(segsize)';
    %win = 0.54 - 0.46*cos(2*pi*[1:segsize]/(segsize-1));
    xw = x.*win;
    %compute N point DFT
    X = fft(xw);
    sq = (abs(X)).^2;
    spect = sq(1:segsize/2);
    
    spmat(:,i) = spect';
end
cep = 11 + log10(spmat);
image(spmat);
figure();
image(cep');
figure();
plot(speech);