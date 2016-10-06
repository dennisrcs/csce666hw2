% Part2 (a, b, c)
% getting data from file
hw2p1_data = load('hw2p1_data.mat');
data = hw2p1_data.x;

% preallocating memory
data_size = size(data, 2);
density = zeros(1, data_size-1);
sum_density_logs = 0;

for i = 1:data_size
    % splitting data into training and validation set
    [training_set, validation_set] = split_data(data, i);
    
    % calculating density
    density_at_validation = pkde(validation_set, training_set, 4); 
    sum_density_logs = sum_density_logs + log(density_at_validation);    
end

log_likelihood = sum_density_logs/data_size;

disp('Average log-likelihood');
disp(log_likelihood);

% Part2 (d, e, f)
for i = 1:data_size
    % splitting data into training and validation set
    [training_set, validation_set] = split_data(data, i);

    bandwidths = get_logspaced_bandwidths(training_set);
    
    for j = 1:size(bandwidths, 2)
        % calculating density
        density_at_validation = pkde(validation_set, training_set, bandwidths(j)); 
        sum_density_logs = sum_density_logs + log(density_at_validation);
    end
end

