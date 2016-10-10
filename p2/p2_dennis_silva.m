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
figure;
subplot(1, 2, 1);
semilogx(1:1:size(S, 1), eigenvalues, 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Eigenvalues');

cum_eigenvalues = cumsum(eigenvalues);
subplot(1, 2, 2);
semilogx(1:1:size(S, 1), cum_eigenvalues/cum_eigenvalues(length(cum_eigenvalues)), 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Normalized Cumulative Eigenvalues');

% part c

% plotting penguim
U_reduced = U(:, 1:3);
z = U_reduced'  * data'; z = z';
figure, scatter3(z(:, 1), z(:, 2), z(:, 3));
xlabel('1st Dimension');
ylabel('2nd Dimension');
zlabel('3rd Dimension');

% plotting alien
U_reduced_234 = U(:, 2:4);
z_234 = U_reduced_234'  * data'; z_234 = z_234';
figure, scatter3(z_234(:, 1), z_234(:, 2), z_234(:, 3));
xlabel('1st Dimension');
ylabel('2nd Dimension');
zlabel('3rd Dimension');
