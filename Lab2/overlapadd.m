%This is a manual implementation of the overlap and add method of
%convolution that is used when one of the input sequences are too large to
%be processed in one go. The input sequence is split up into blocks of
%manageable length and these sequences are convolved with the filter. The
%sequences obtained from this is then shifted, overlapped at the
%appropriate points and then added.

function output = overlapadd(x, h)

end
