% Getting data from file
hw2p6_train = load('hw2p6_train.mat');
hw2p6_test = load('hw2p6_test.mat');

% Retriving training
train = hw2p6_train.x1;
clab_train = hw2p6_train.clab1;

% Retriving test data
test = hw2p6_test.x2;
clab_test = hw2p6_test.clab2;

% PCA
cov_matrix = cov(train);
[U, S, V] = svd(cov_matrix);

% Plotting training data eigenvalues
eigenvalues = diag(S);
figure;
subplot(1, 2, 1);
plot(1:1:size(S, 1), eigenvalues, 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Eigenvalues');

cum_eigenvalues = cumsum(eigenvalues);
subplot(1, 2, 2);
plot(1:1:size(S, 1), cum_eigenvalues/cum_eigenvalues(length(cum_eigenvalues)), 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Normalized Cumulative Eigenvalues');

U_reduced = U(:, 1:3);
pca_train_projected = U_reduced'  * train'; pca_train_projected = pca_train_projected';
pca_test_projected = U_reduced'  * test'; pca_test_projected = pca_test_projected';

% Plotting PCA projecting
figure;
subplot(1, 3, 1);
scatter(pca_train_projected(:, 1), pca_train_projected(:, 2), [], map_into_color(clab_train));
xlabel('PC1'); ylabel('PC2');

subplot(1, 3, 2);
scatter(pca_train_projected(:, 1), pca_train_projected(:, 3), [], map_into_color(clab_train));
xlabel('PC1'); ylabel('PC3');

subplot(1, 3, 3);
scatter(pca_train_projected(:, 2), pca_train_projected(:, 3), [], map_into_color(clab_train));
xlabel('PC2'); ylabel('PC3');

% LDA dimensionality reduction
[lda_train_projected, u_lda, d] = tamu_lda(train, clab_train);
lda_test = u_lda'  * test'; lda_test = lda_test';

% Plotting LDA projection
figure;
scatter(lda_train_projected(:, 1), lda_train_projected(:, 2), [], map_into_color(clab_train));
xlabel('Dimension 1'); ylabel('Dimension 2');