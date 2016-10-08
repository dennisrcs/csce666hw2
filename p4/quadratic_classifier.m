function g = quadratic_classifier(x, data)
%QUADRATIC_CLASSIFIER Summary of this function goes here
%   Detailed explanation goes here
    avg = mean(data);
    cov_matrix = cov(data);
    x_avg_t = (x - avg)';
    
    first_term = -0.5 * (x - avg) * inv(cov_matrix) * x_avg_t;
    second_term = -0.5 * log(det(cov_matrix));
    third_term = log(1/3);
    
    g = first_term + second_term + third_term;
end

