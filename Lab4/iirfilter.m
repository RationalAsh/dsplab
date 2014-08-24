function y = iirfilter(x, num, den)
ord = length(den);
y = zeros(1,length(x));
M = zeros(1, ord);
%The filter coefficients need to be defined
b = num;
a = den;

%do filtering using direct form 2
for i = 1:length(x)
    w = x(i) - dot(den, M);
    y(i) = (w)*num(1) + dot(num(2:length(num)), M);
    %update memory elements
    M(3) = M(2);
    M(2) = M(1);
    M(1) = w;
end

end