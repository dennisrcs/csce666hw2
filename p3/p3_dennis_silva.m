% First distribution
mu1 = [5 0 5];
sigma1 = [5 -4 -2; -4 4 0; -2 0 5];
samples1 = mvnrnd(mu1, sigma1, 250);

% Second distribution
mu2 = [4 6 7];
sigma2 = [3 0 0; 0 3 0; 0 0 3];
samples2 = mvnrnd(mu2, sigma2, 250);

% Third distribution
mu3 = [6 2 4];
sigma3 = [6 5 6; 5 6 7; 6 7 9];
samples3 = mvnrnd(mu3, sigma3, 250);

% Plotting the data generated
figure;
scatter3(samples1(:, 1), samples1(:, 2), samples1(:, 3));
hold on;
scatter3(samples2(:, 1), samples2(:, 2), samples2(:, 3));
hold on;
scatter3(samples3(:, 1), samples3(:, 2), samples3(:, 3));
xlabel('x'); ylabel('y'); zlabel('z');
legend('class 1', 'class 2', 'class 3');
hold off;

% Augmenting feature vector with 48 noisy dimensions
dimensions_augmented = 48;
samples1_augmented = p3_augment_with_noise(samples1, dimensions_augmented);
samples2_augmented = p3_augment_with_noise(samples2, dimensions_augmented);
samples3_augmented = p3_augment_with_noise(samples3, dimensions_augmented);

% Part (a)

% Computing data for first and second principal components
data = [samples1_augmented; samples2_augmented; samples3_augmented];
sigma = cov(data);
[U, ~, ~] = svd(sigma);
U_reduced = U(:, 1:2);
pca_data_projected = U_reduced'  * data'; pca_data_projected = pca_data_projected';

% Generating labels
num_labels = get_num_labels();
string_labels = get_string_labels();

figure, scatter(pca_data_projected(:, 1), pca_data_projected(:, 2), 0.0001);
text(pca_data_projected(1:250, 1), pca_data_projected(1:250, 2), '1', 'color', [0 0.4470 0.7410]);
text(pca_data_projected(251:500, 1), pca_data_projected(251:500, 2), '2', 'color', [0.8500 0.3250 0.0980]);
text(pca_data_projected(501:750, 1), pca_data_projected(501:750, 2), '3', 'color', [0.9290 0.6940 0.1250]);
xlabel('PC1'); ylabel('PC2');
axis;

% Part (b)
num_labels = num_labels';

[lda_data_projected, U, S] = tamu_lda(data, num_labels);

figure, scatter(lda_data_projected(:, 1), lda_data_projected(:, 2), 0.0001);
text(lda_data_projected(1:250, 1), lda_data_projected(1:250, 2), '1', 'color', [0 0.4470 0.7410]);
text(lda_data_projected(251:500, 1), lda_data_projected(251:500, 2), '2', 'color', [0.8500 0.3250 0.0980]);
text(lda_data_projected(501:750, 1), lda_data_projected(501:750, 2), '3', 'color', [0.9290 0.6940 0.1250]);
xlabel('PC1'); ylabel('PC2');
axis;