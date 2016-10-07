% First distribution
mu1 = [5 0 5];
sigma1 = [5 -4 -2; -4 4 0; -2 0 5];
samples1 = mvnrnd(mu1,sigma1,250);

% Second distribution
mu2 = [4 6 7];
sigma2 = [3 0 0; 0 3 0; 0 0 3];
samples2 = mvnrnd(mu2, sigma2, 250);

% Third distribution
mu3 = [6 2 4];
sigma3 = [6 5 6; 5 6 7; 6 7 9];
samples3 = mvnrnd(mu3, sigma3, 250);

% Augmenting feature vector with 48 noisy dimensions
dimensions_augmented = 48;
samples1_augmented = augment_with_noise(samples1, dimensions_augmented);
samples2_augmented = augment_with_noise(samples2, dimensions_augmented);
samples3_augmented = augment_with_noise(samples3, dimensions_augmented);

% Part (a)

% Computing data for first and second principal components
data = [samples1_augmented; samples2_augmented; samples3_augmented];
sigma = cov(data);
[U, S, V] = svd(sigma);
U_reduced = U(:, 1:2);
data_reduced = U_reduced'  * data'; data_reduced = data_reduced';

% Generating labels
labels = get_labels();

scatter(data_reduced(:, 1), data_reduced(:, 2), '*');
text(data_reduced(:, 1), data_reduced(:, 2), labels);
xlabel('PC1'); ylabel('PC2');
axis;



