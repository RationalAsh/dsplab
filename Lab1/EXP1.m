% function z = EXP1(x, y)
% %Convolving x with y manually
% M = length(y);
% L = length(x);
% output = zeros(1, L+M-1);
% i = 1;
% k = M - 1;
% x = [x, zeros(1, M-1)];
% while(i <= L)
%     if(i <= 100)
%        output(i) = dot(y(101-i:100),x(1:i));
%     else
%        output(i) = dot(y, x(i:i+k));
%     end
%     i = i + 1;
% end
% z = output;
% end



%Sampling frequency
Fs = 100; Ts = 1/Fs;
%frequency
f1 = 15; f2 = 20; f3 = 5; f4 = 10;

%Amplitudes
A1 = 7; A2 = 5; A3 = 11; A4 = 13;

%Values of n
n1 = 1:100; n2 = 101:200;
n3 = 201:300; n4 = 301:400;
N = [n1 n2 n3 n4];
T = Ts*N;

%Functions to plot
x1 = A1*sin(2*pi*f1*n1*Ts); x2 = A2*sin(2*pi*f2*n2*Ts);
x3 = A3*sin(2*pi*f3*n3*Ts); x4 = A4*sin(2*pi*f4*n4*Ts);
X = [x1 x2 x3 x4];
%Functions to convolve with
Y1 = sin(2*pi*f3*n1*Ts); Y2 = sin(2*pi*f1*n1*Ts);
Y3 = sin(2*pi*f2*n1*Ts); Y4 = sin(2*pi*f4*n1*Ts);

%Getting the correlation using inbuilt matlab functions
matlabout1 = xcorr(X, Y1); matlabout2 = xcorr(X, Y2);
matlabout3 = xcorr(X, Y3); matlabout4 = xcorr(X, Y4);


%Plotting the functions before correlation
subplot(3,1,1), plot(N*Ts,X);
xlabel('time(s)'); ylabel('X'); title('X Function');
subplot(3,1,2), plot(n1*Ts, Y1);
xlabel('time(s)'); ylabel('Y1'); title('Y=sin(2*pi*f3*n*Ts)');

%Convolving Y1 with X manually
M = length(Y1);
L = length(X);
output = zeros(1, L+M-1);
output2 = zeros(1, L+M-1);
output3 = zeros(1, L+M-1);
output4 = zeros(1, L+M-1);
i = 1;
k = M - 1;
X = [X, zeros(1, M-1)];
while(i <= L)
    if(i <= 100)
       output(i)  = dot(Y1(101-i:100),X(1:i));
       output2(i) = dot(Y2(101-i:100),X(1:i));
       output3(i) = dot(Y3(101-i:100),X(1:i));
       output4(i) = dot(Y4(101-i:100),X(1:i));
    else
       output(i)  = dot(Y1, X(i:i+k));
       output2(i) = dot(Y2, X(i:i+k));
       output3(i) = dot(Y3, X(i:i+k));
       output4(i) = dot(Y4, X(i:i+k));
    end
    i = i + 1;
end
%X = X(0:length(X)-M+1);

%z = EXP1(x,y);

%Functions to convolve with
Y1 = sin(2*pi*f3*n1*Ts); Y2 = sin(2*pi*f1*n1*Ts);
Y3 = sin(2*pi*f2*n1*Ts); Y4 = sin(2*pi*f4*n1*Ts);
%plotting and comparing the results
subplot(3,1,3), plot(Ts*[1:L+M-1], output);
xlabel('time(s)'); ylabel('output'); title('Correlation of X with Y=sin(2*pi*f3*n1*Ts)');
figure();
subplot(3,1,1), plot(Ts*[1:L+M-1], output2);
xlabel('time(s)'); ylabel('output2'); title('Correlation of X with Y=sin(2*pi*f1*n1*Ts)');
subplot(3,1,2), plot(Ts*[1:L+M-1], output3);
xlabel('time(s)'); ylabel('output3'); title('Correlation of X with Y=sin(2*pi*f2*n1*Ts)');
subplot(3,1,3), plot(Ts*[1:L+M-1], output4);
xlabel('time(s)'); ylabel('output4'); title('Correlation of X with Y=sin(2*pi*f4*n1*Ts)');
%subplot(2,2,4), plot(Ts*[1:length(matlabout)], matlabout1);
%xlabel('time(s)'); ylabel('matlabout'); title('Inbuilt correlation of X and Y');

