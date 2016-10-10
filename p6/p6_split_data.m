function [training_set, validation_set, train_clab, validation_clab] = p6_split_data(data, clab)
%SPLIT_DATA Splits the data into training and test set
    
    % Initialize
    data_size = size(data, 1);
    training_data_size = ceil(0.75 * data_size);
    
    % Create a permutation of indices
    p = randperm(data_size);
    
    % Splitting the data
    training_set = data(p(1:training_data_size), :);
    train_clab = clab(p(1:training_data_size), :);
    
    validation_set = data(p(training_data_size+1:end), :);
    validation_clab = clab(p(training_data_size+1:end), :);
end