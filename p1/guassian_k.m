function density = guassian_k(x)
%GUASSIAN_K Returns the density in x, according to the unimodal guassian
%distribution
    dim = size(x, 2);
    density = (2 * pi).^(-dim/2) * exp(-0.5 * dot(x', x));
end

