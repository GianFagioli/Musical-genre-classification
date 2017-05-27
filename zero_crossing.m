function [ zero ] = zero_crossing( x )
% Cantidad de cruces por cero
    N=length(x);
    zero = 0;
    for i=2 : N
        zero= zero + 1/2 * abs( sign(x(i)) - sign(x(i-1)) );
    end
end

