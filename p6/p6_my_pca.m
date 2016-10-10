function [projected_data, U_reduced] = p6_my_pca(data, m)
%MY_PCA Computes PCA for the data. Returns the top 'm' eigenvectors and
%projects the data into those calculated vectors.
    cov_matrix = cov(data);
    [U, ~, ~] = svd(cov_matrix);
    U_reduced = U(:, 1:m);
    projected_data = U_reduced' * data'; projected_data = projected_data';
end

