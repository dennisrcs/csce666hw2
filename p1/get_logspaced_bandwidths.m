function [h0, bandwidths] = get_logspaced_bandwidths(data)
%GET_LOGSPACED_BANDWIDTHS Return logaritmically-spaced bandwidths

    % calculating h0
    N = size(data, 2);
    A = min(std(data), iqr(data)/1.34);
    h0 = 0.9 * A * (N.^(-1/5));

    % computing log-spaced bandwidhts
    bandwidths = logspace(log10(h0) -2, log10(h0) + 2, 100);
    
end

