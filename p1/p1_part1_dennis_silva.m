% getting data from file
hw2p1_data = load('hw2p1_data.mat');
data = hw2p1_data.x;

% getting min and max values from data set
minimum = min(data);
maximum = max(data);

% evenly spaced numbers
num_points = 50;
points = linspace(minimum, maximum, num_points);
density = zeros(3, num_points);
bandwidths = [1, 4, 10];

% calculating density
for i = 1:size(bandwidths, 2)
    for j = 1:num_points
        density(i, j) = pkde(points(j), data, bandwidths(i)); 
    end
end

% histogram
num_bins = 60;

figure;
subplot(3, 1, 1);
histogram(data, num_bins, 'Normalization','pdf');
hold on;
plot(points, density(1,:), 'LineWidth', 2);
ylabel('Probability');
xlabel('Data');
title('Density estimation. Gaussian KDE h = 1 (Small)');

subplot(3, 1, 2);
histogram(data, num_bins, 'Normalization','pdf');
hold on;
plot(points, density(2,:), 'LineWidth', 2);
ylabel('Probability');
xlabel('Data');
title('Density estimation. Gaussian KDE h = 3 (Best)');

subplot(3, 1, 3);
histogram(data, num_bins, 'Normalization','pdf');
hold on;
plot(points, density(3,:), 'LineWidth', 2);
ylabel('Probability');
xlabel('Data');
title('Density estimation. Gaussian KDE h = 10 (Large)');