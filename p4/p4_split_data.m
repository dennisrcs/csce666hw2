function [training_set, test_set] = p4_split_data(data)
%SPLIT_DATA Splits the data into training and test set
    % Initialize
    data_size = size(data, 1);
    training_data_size = ceil(0.75 * data_size);
    
    % Create a permutation of indices
    p = randperm(data_size);
    
    % Splitting the data
    training_set = data(p(1:training_data_size), :);
    test_set = data(p(training_data_size+1:end), :);
end