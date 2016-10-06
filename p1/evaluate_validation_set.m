function y = evaluate_validation_set(x, data, density)
%FIND_CLOSEST Summary of this function goes here
%   Detailed explanation goes here
    data_diff = abs(data - x);
    [~, idx] = min(data_diff);
    y = density(idx);
end

