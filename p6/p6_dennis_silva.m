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
semilogx(1:1:size(S, 1), eigenvalues, 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Eigenvalues');

cum_eigenvalues = cumsum(eigenvalues);
subplot(1, 2, 2);
semilogx(1:1:size(S, 1), cum_eigenvalues/cum_eigenvalues(length(cum_eigenvalues)), 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Normalized Cumulative Eigenvalues');

U_reduced = U(:, 1:2);
pca_train_projected = U_reduced'  * train'; pca_train_projected = pca_train_projected';
pca_test_projected = U_reduced'  * test'; pca_test_projected = pca_test_projected';

% Plotting PCA projecting
figure;
scatter(pca_train_projected(:, 1), pca_train_projected(:, 2), [], clab_train);
xlabel('PC1'); ylabel('PC2');

% LDA dimensionality reduction
[lda_train_projected, u_lda, d] = tamu_lda(train, clab_train);
lda_test = u_lda'  * test'; lda_test = lda_test';

% Plotting LDA projection
figure;
scatter(lda_train_projected(:, 1), lda_train_projected(:, 2), [], clab_train);
xlabel('PC1'); ylabel('PC2');

lda_train_1 = get_class_data(lda_train_projected, clab_train, 1);
lda_train_2 = get_class_data(lda_train_projected, clab_train, 2);
lda_train_3 = get_class_data(lda_train_projected, clab_train, 3);

test_size = length(lda_test);
train_size = length(lda_train_projected);

prior1 = size(lda_train_1, 1)/train_size;
prior2 = size(lda_train_2, 1)/train_size;
prior3 = size(lda_train_3, 1)/train_size;

correct_class = 0;
for i = 1:test_size
    % Computing gi
    g1 = p6_quadratic_classifier(lda_test(i, :), lda_train_1, prior1);
    g2 = p6_quadratic_classifier(lda_test(i, :), lda_train_2, prior2);
    g3 = p6_quadratic_classifier(lda_test(i, :), lda_train_3, prior3);

    % Checking if the class predicted matches the original class label
    [~, class_predicted] = max([g1, g2, g3]);
    if class_predicted == clab_test(i)
        correct_class = correct_class + 1;
    end
end

disp(correct_class/test_size);