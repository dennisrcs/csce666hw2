function prediction = p6_knn_predict(x, data, clab, k)
%KNN_PREDICT Summary of this function goes here
%   Detailed explanation goes here
    distances = zeros(size(data, 1), 1);
    
    for i = 1:size(data, 1)
        distances(i) = euclidian_distance(x, data(i, :));
    end
    
    [~, idx] = sort(distances);
    classes = clab(idx);
    k_classes = classes(1:k);
    
    % Getting the most common class among the top k nearest neighbors
    prediction = mode(k_classes);
end

