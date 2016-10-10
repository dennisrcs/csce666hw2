% Part2 (a, b, c)
% getting data from file
hw2p1_data = load('hw2p1_data.mat');
data = hw2p1_data.x;

% preallocating memory
data_size = size(data, 2);
density = zeros(1, data_size-1);
sum_density_logs = 0;
best_bandwidth_part_1 = 2;

for j = 1:data_size
    % splitting data into training and validation set
    [training_set, validation_set] = split_data(data, j);
    
    % calculating density
    density_at_validation = pkde(validation_set, training_set, best_bandwidth_part_1); 
    sum_density_logs = sum_density_logs + log(density_at_validation);    
end

log_likelihood = sum_density_logs/data_size;

disp('Average log-likelihood (Part C)');
disp(log_likelihood);

% Part2 (d, e)
[h0, bandwidths] = get_logspaced_bandwidths(data);
num_bandwidths = size(bandwidths, 2);
avg_densities_log = zeros(1, num_bandwidths);

for i = 1:num_bandwidths
    sum_density_logs = 0;
    for j = 1:data_size
        % splitting data into training and validation set
        [training_set, validation_set] = split_data(data, j);

        % calculating density
        density_at_validation = pkde(validation_set, training_set, bandwidths(i)); 
        sum_density_logs = sum_density_logs + log(density_at_validation);
    end
    avg_densities_log(i) = sum_density_logs / num_bandwidths;
end

figure, semilogx(bandwidths, avg_densities_log, 'LineWidth', 1.5);
xlabel('bandwidth')
ylabel('log-likelihood');

% Part2 (f)
[val, index] = max(avg_densities_log);
best_bandwidth = bandwidths(index);

% getting min and max values from data set
minimum = min(data);
maximum = max(data);

% evenly spaced numbers
num_points = 100;
points = linspace(minimum, maximum, num_points);
bandwidths_partf = [h0, best_bandwidth];
density_partf = zeros(2, num_points);

% calculating density
for i = 1:size(bandwidths_partf, 2)
    for j = 1:num_points
        density_partf(i, j) = pkde(points(j), data, bandwidths_partf(i)); 
    end
end

figure;
histogram(data, 50, 'Normalization','pdf');
hold on;
plot(points, density_partf(1,:), points, density_partf(2,:), 'LineWidth', 2);
legend('histogram', strcat('h0= ', num2str(h0)), strcat('best h= ', num2str(best_bandwidth)));
ylabel('Probability');
xlabel('Data Values');