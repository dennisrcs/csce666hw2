% Getting data from file
hw2p6_train = load('hw2p6_train.mat');
hw2p6_test = load('hw2p6_test.mat');

% Retriving training
train = hw2p6_train.x1;
clab_train = hw2p6_train.clab1;

% Retriving test data
test = hw2p6_test.x2;

% LDA dimensionality reduction
[lda_train_projected, u_lda, d] = tamu_lda(train, clab_train);
lda_test = u_lda'  * test'; lda_test = lda_test';

% Getting data from each specific class
lda_train_1 = get_class_data(lda_train_projected, clab_train, 1);
lda_train_2 = get_class_data(lda_train_projected, clab_train, 2);
lda_train_3 = get_class_data(lda_train_projected, clab_train, 3);

% Retriving training and test data
train_size = length(lda_train_projected);
test_size = length(lda_test);

% Calculating priors
prior1 = size(lda_train_1, 1)/train_size;
prior2 = size(lda_train_2, 1)/train_size;
prior3 = size(lda_train_3, 1)/train_size;

uclab = [];
quadratic_correct_class = 0;
for i = 1:test_size
    % Computing gi
    g1 = p6_quadratic_classifier(lda_test(i, :), lda_train_1, prior1);
    g2 = p6_quadratic_classifier(lda_test(i, :), lda_train_2, prior2);
    g3 = p6_quadratic_classifier(lda_test(i, :), lda_train_3, prior3);

    % Checking if the class predicted matches the original class label
    [~, class_predicted] = max([g1, g2, g3]);
    uclab = [uclab; class_predicted];
end