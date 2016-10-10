function g = p6_quadratic_classifier(x, data, prior)
%QUADRATIC_CLASSIFIER Summary of this function goes here
%   Detailed explanation goes here
    
    avg = mean(data);
    cov_matrix = cov(data);
    x_avg_t = (x - avg)';
    
    first_term = -0.5 * (x - avg) * (cov_matrix \ x_avg_t);
    second_term = -0.5 * log(det(cov_matrix));
    third_term = log(prior);
    
    g = first_term + second_term + third_term;

end