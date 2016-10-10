function train_target = get_class_data(train, clab, target)
%GET_CLASS_DATA Summary of this function goes here
%   Detailed explanation goes here

    train_size = size(train, 1);
    
    index = 1;
    for i = 1:train_size
        if clab(i) == target
            train_target(index, :) = train(i, :);
            index = index + 1;
        end
    end

end

