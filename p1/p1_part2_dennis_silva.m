% getting data from file
hw2p1_data = load('hw2p1_data.mat');
data = hw2p1_data.x;

% preallocating memory
data_size = size(data, 2);
density = zeros(1, data_size-1);
sum_density_logs = 0;

% making a copy for the original data
data_bkp = data;
for i = 1:data_size
    [training_set, validation_set] = split_data(data, i);
    
    training_set = sort(training_set);
    % calculating density
    for j = 1:size(training_set, 2)
        density(j) = pkde(training_set(j), data, 4); 
    end
    
    density_at_validation = evaluate_validation_set(validation_set, training_set, density);
    sum_density_logs = sum_density_logs + log(density_at_validation);    
    
    data = data_bkp;
end

disp('Average log-likelihood');
disp(sum_density_logs/data_size);