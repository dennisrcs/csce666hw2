function density = pkde(x, data, bandwidth)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    dim = size(x, 2);
    N = size(data, 2);
    h = bandwidth;
    
    density = 0;
    for i = 1:N
       density = density + guassian_k((x - data(i))/h);
    end
    
    density = (1 / (N * (h.^dim))) * density;

end

