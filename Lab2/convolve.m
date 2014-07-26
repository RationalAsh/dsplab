function output = convolve(x,h)
% Get lengths of both sequences
L = length(x);
M = length(h);
%output = conv(h,x);
%Convolving manually
% 1. Zero pad both the sequences to the same length (L+M-1)
x_z = [x, zeros(1, M-1)];
h_z = [h, zeros(1, L-1)];

% 2. Take dft of both sequences.
X = fft(x_z);
H = fft(h_z);

% 3. Multiply the two dfts together
Y = X.*H;

% 4. Take the inverse dft of the resulting sequence to get the convolved
%    sequence
output = ifft(Y);

end
