% Getting data from file
hw2p6_train = load('hw2p6_train.mat');
hw2p6_test = load('hw2p6_test.mat');

% Retriving training
training_data = hw2p6_train.x1;
clab_training_data = hw2p6_train.clab1;

% Retriving test data
test = hw2p6_test.x2;
clab_test = hw2p6_test.clab2;

% Defining k's
ks = [1, 2, 5, 20, 50, 100, 225];

it_num = 30;

orig_quad_accuracy = zeros(it_num, 1);
pca_quad_accuracy = zeros(it_num, 1);
lda_quad_accuracy = zeros(it_num, 1);

orig_knn_accs = zeros(it_num, size(ks, 2));
pca_knn_accs = zeros(it_num, size(ks, 2));
lda_knn_accs = zeros(it_num, size(ks, 2));

disp('Model Selection');

for it = 1:it_num

    % Splitting the data
    [train, validation, clab_train, clab_validation] = p6_split_data(training_data, clab_training_data);
    
    % Retriving training and test data
    train_size = size(train, 1);
    validation_size = size(validation, 1);

    % Getting data per class
    train_1 = get_class_data(train, clab_train, 1);
    train_2 = get_class_data(train, clab_train, 2);
    train_3 = get_class_data(train, clab_train, 3);

    % Calculating priors
    prior1 = size(train_1, 1)/train_size;
    prior2 = size(train_2, 1)/train_size;
    prior3 = size(train_3, 1)/train_size;

    % Analyzing results for high-dimensional data
    orig_quad_corrects = 0;
    for i = 1:validation_size
        % Computing gi
        g1 = p6_quadratic_classifier(validation(i, :), train_1, prior1);
        g2 = p6_quadratic_classifier(validation(i, :), train_2, prior2);
        g3 = p6_quadratic_classifier(validation(i, :), train_3, prior3);

        % Checking if the class predicted matches the original class label
        [~, class_predicted] = max([g1, g2, g3]);
        if class_predicted == clab_validation(i)
            orig_quad_corrects = orig_quad_corrects + 1;
        end
    end

    orig_quad_accuracy(it) = orig_quad_corrects/validation_size;
    
    for k = 1:size(ks, 2)
        orig_knn_corrects = 0;
        for i = 1:validation_size
            % Predicting test data class
            class_predicted = p6_knn_predict(validation(i, :), train, clab_train, ks(k));

            if class_predicted == clab_validation(i)
                orig_knn_corrects = orig_knn_corrects + 1;
            end
        end
        orig_knn_accs(it, k) = orig_knn_corrects/validation_size;
    end

    disp('');

    % PCA dimensionality reduction
    cov_matrix = cov(train);
    [u_pca, ~, ~] = svd(cov_matrix);

    % Projecting validation data 
    u_pca_reduced = u_pca(:, 1:3);
    pca_train = u_pca_reduced'  * train'; pca_train = pca_train';
    pca_validation = u_pca_reduced'  * validation'; pca_validation = pca_validation';

    % Getting data from each specific class
    pca_train_1 = get_class_data(pca_train, clab_train, 1);
    pca_train_2 = get_class_data(pca_train, clab_train, 2);
    pca_train_3 = get_class_data(pca_train, clab_train, 3);

    pca_quad_corrects = 0;
    for i = 1:validation_size
        % Computing gi
        g1 = p6_quadratic_classifier(pca_validation(i, :), pca_train_1, prior1);
        g2 = p6_quadratic_classifier(pca_validation(i, :), pca_train_2, prior2);
        g3 = p6_quadratic_classifier(pca_validation(i, :), pca_train_3, prior3);

        % Checking if the class predicted matches the original class label
        [~, class_predicted] = max([g1, g2, g3]);
        if class_predicted == clab_validation(i)
            pca_quad_corrects = pca_quad_corrects + 1;
        end
    end

    pca_quad_accuracy(it) = pca_quad_corrects/validation_size;

    for k = 1:size(ks, 2)
        pca_knn_corrects = 0;
        for i = 1:validation_size
            % Predicting test data class
            class_predicted = p6_knn_predict(pca_validation(i, :), pca_train, clab_train, ks(k));

            if class_predicted == clab_validation(i)
                pca_knn_corrects = pca_knn_corrects + 1;
            end
        end
        pca_knn_accs(it, k) = pca_knn_corrects/validation_size;
    end

    disp('');

    % LDA dimensionality reduction
    [lda_train, u_lda, ~] = tamu_lda(train, clab_train);

    % Projecting validation data
    lda_validation = u_lda'  * validation'; lda_validation = lda_validation';

    % Getting data from each specific class
    lda_train_1 = get_class_data(lda_train, clab_train, 1);
    lda_train_2 = get_class_data(lda_train, clab_train, 2);
    lda_train_3 = get_class_data(lda_train, clab_train, 3);

    lda_quad_corrects = 0;
    for i = 1:validation_size
        % Computing gi
        g1 = p6_quadratic_classifier(lda_validation(i, :), lda_train_1, prior1);
        g2 = p6_quadratic_classifier(lda_validation(i, :), lda_train_2, prior2);
        g3 = p6_quadratic_classifier(lda_validation(i, :), lda_train_3, prior3);

        % Checking if the class predicted matches the original class label
        [~, class_predicted] = max([g1, g2, g3]);
        if class_predicted == clab_validation(i)
            lda_quad_corrects = lda_quad_corrects + 1;
        end
    end

    lda_quad_accuracy(it) = lda_quad_corrects/validation_size;

    for k = 1:size(ks, 2)
        lda_knn_corrects = 0;
        for i = 1:validation_size
            % Predicting test data class
            class_predicted = p6_knn_predict(lda_validation(i, :), lda_train, clab_train, ks(k));

            if class_predicted == clab_validation(i)
                lda_knn_corrects = lda_knn_corrects + 1;
            end
        end
        lda_knn_accs(it, k) = lda_knn_corrects/validation_size;
    end

end

disp(strcat('orig_quad_accuracy: ', num2str(mean(orig_quad_accuracy))));
for k = 1:size(ks, 2)
    disp(strcat('orig_knn_accs k=', num2str(ks(k)), ':', num2str(mean(orig_knn_accs(:, k)))));
end

disp(strcat('pca_quad_accuracy: ', num2str(mean(pca_quad_accuracy))));
for k = 1:size(ks, 2)
    disp(strcat('pca_knn_accs k=', num2str(ks(k)), ':', num2str(mean(pca_knn_accs(:, k)))));
end

disp(strcat('lda_quad_accuracy: ', num2str(mean(lda_quad_accuracy))));
for k = 1:size(ks, 2)
    disp(strcat('lda_knn_accs k=', num2str(ks(k)), ':', num2str(mean(lda_knn_accs(:, k)))));
end

disp('Quadratic classifier applied to the LDA projected test data');

% LDA dimensionality reduction
[final_train, final_u_lda, ~] = tamu_lda(training_data, clab_training_data);

% Projecting validation data
final_test = final_u_lda'  * test'; final_test = final_test';

% Getting data from each specific class
final_train_1 = get_class_data(final_train, clab_training_data, 1);
final_train_2 = get_class_data(final_train, clab_training_data, 2);
final_train_3 = get_class_data(final_train, clab_training_data, 3);

final_train_size = size(training_data, 1);
final_test_size = size(test, 1);

final_prior1 = size(final_train_1, 1)/final_train_size;
final_prior2 = size(final_train_2, 1)/final_train_size;
final_prior3 = size(final_train_3, 1)/final_train_size;

test_correct_class = 0;
for i = 1:final_test_size
    % Computing gi
    g1 = p6_quadratic_classifier(final_test(i, :), final_train_1, final_prior1);
    g2 = p6_quadratic_classifier(final_test(i, :), final_train_2, final_prior2);
    g3 = p6_quadratic_classifier(final_test(i, :), final_train_3, final_prior3);

    % Checking if the class predicted matches the original class label
    [~, class_predicted] = max([g1, g2, g3]);
    if class_predicted == clab_test(i)
        test_correct_class = test_correct_class + 1;
    end
end

disp(strcat('Accuracy for test: ', num2str(test_correct_class/final_test_size)));