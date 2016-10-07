% getting data from file
hw2p2_data = load('hw2p2_data.mat');
data = hw2p2_data.x;

% part a
figure, scatter3(data(:, 1), data(:, 2), data(:, 3));
xlabel('1st Dimension');
ylabel('2nd Dimension');
zlabel('3rd Dimension');

% part b
sigma = cov(data);
[U, S, V] = svd(sigma);

eigenvalues = diag(S);
figure, semilogx(1:1:size(S, 1), eigenvalues, 'LineWidth', 1.5);
title('Scree plot');
xlabel('Dimensions');
ylabel('Eigenvalues');

% part c
U_reduced = U(:, 1:3);
z = U_reduced'  * data'; z = z';
figure, scatter3(z(:, 1), z(:, 2), z(:, 3));
xlabel('1st Dimension');
ylabel('2nd Dimension');
zlabel('3rd Dimension');