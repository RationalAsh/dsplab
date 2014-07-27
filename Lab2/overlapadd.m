%This is a manual implementation of the overlap and add method of
%convolution that is used when one of the input sequences are too large to
%be processed in one go. The input sequence is split up into blocks of
%manageable length and these sequences are convolved with the filter. The
%sequences obtained from this is then shifted, overlapped at the
%appropriate points and then added.

%The overlap and add algorithm now works!!! :D

function output = overlapadd(x, h, block_size)
c_result = [];
n_blocks = length(x)/block_size;
flg = 0;
if(mod(length(x), block_size) ~= 0)
    disp('The length of the input sequence must be an integer multiple of the block_size. Please try again');
    output = [];
    flg = 1;
end

blocks = zeros(n_blocks, block_size);
%convolved= zeros(n_blocks, block_size + length(h) - 1);
out = zeros(n_blocks, length(x)+length(h)-1);

if(flg ~= 1)
    %Split the input sequence into blocks of manageable length
    blocks = reshape(x, n_blocks, block_size)';
    %Convolve each block with the filter
    for i = 1:n_blocks
        out(i, 1:block_size+length(h)-1) = convolve(blocks(i, :), h);
    end
    %Overlap each sequence at the right spot.
    for i=1:n_blocks
        out(i, :) = circshift(out(i, :), [0 (i-1)*block_size]);
    end
    %Add all the sequences to get the answer.
    %output = convolve(x,h);
end
output = cumsum(out);
output = output(n_blocks, :);
%output = output;
end
