function [training_set, validation_set] = split_data(data, validation_index)
%GET_TRAINING_SET Splits the data into training and validation set
    data_size = size(data, 2);
    flag = -100;
    
    % validation set has only element at index
    validation_set = data(validation_index);
    data(validation_index) = flag;
    
    % training set has the remaining elements
    training_set = zeros(1, data_size-1);
    
    index = 1;
    for i = 1:data_size
        if data(i) ~= flag
            training_set(index) = data(i);
            index = index + 1;
        end
    end

end

