function prediction = knn_predict(x, data, ex_per_class, k)
%KNN_PREDICT Summary of this function goes here
%   Detailed explanation goes here
    distances = zeros(size(data, 1), 1);
    
    for i = 1:size(data, 1)
        distances(i) = euclidian_distance(x, data(i, :));
    end
    
    [~, idx] = sort(distances);
    class = fix(idx/ex_per_class) + 1;
    k_classes = class(1:k);
    
    % Getting the most common class among the top k nearest neighbors
    prediction = mode(k_classes);
end

