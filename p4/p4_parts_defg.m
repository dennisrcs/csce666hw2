% Part (d, e, f g)

correct_class = 0;
for j = 1:it_num
    
    % Splitting the data
    [training_set1, test_set1] = p4_split_data(samples1_augmented);
    [training_set2, test_set2] = p4_split_data(samples2_augmented);
    [training_set3, test_set3] = p4_split_data(samples3_augmented);
        
    % Creating training and test set
    training_data = [training_set1; training_set2; training_set3];
    test_data = [test_set1; test_set2; test_set3];
    
    % PCA
    [pca_training_projected, U_pca_reduced] = my_pca(training_data, 3);
    
    % Projecting training and test data
    pca_test_projected = U_pca_reduced' * test_data'; pca_test_projected = pca_test_projected';
    
    s = size(training_set1, 1);
    
    % Retrieving lower dimensional (2-D) training and test data
    lower_dim_training_set1 = pca_training_projected(1:s, 1:2);
    lower_dim_training_set2 = pca_training_projected(s+1:2*s, 1:2);
    lower_dim_training_set3 = pca_training_projected(2*s+1:3*s, 1:2);
    
    train_size = size(training_set1, 1);
    test_size = size(test_set1, 1);
    
    if j == 1
        % Plotting pairwise scatter plot (training data)
        figure;
        subplot(1, 3, 1);
        scatter(pca_training_projected(:, 1), pca_training_projected(:, 2), [], p4_get_labels(train_size));
        xlabel('PC1'); ylabel('PC2');

        subplot(1, 3, 2);
        scatter(pca_training_projected(:, 1), pca_training_projected(:, 3), [], p4_get_labels(train_size));
        xlabel('PC1'); ylabel('PC3');

        subplot(1, 3, 3);
        scatter(pca_training_projected(:, 2), pca_training_projected(:, 3), [], p4_get_labels(train_size));
        xlabel('PC2'); ylabel('PC3');
        
        % Plotting pairwise scatter plot (test data)
        figure;
        subplot(1, 3, 1);
        scatter(pca_test_projected(:, 1), pca_test_projected(:, 2), [], p4_get_labels(test_size));
        xlabel('PC1'); ylabel('PC2');

        subplot(1, 3, 2);
        scatter(pca_test_projected(:, 1), pca_test_projected(:, 3), [], p4_get_labels(test_size));
        xlabel('PC1'); ylabel('PC3');

        subplot(1, 3, 3);
        scatter(pca_test_projected(:, 2), pca_test_projected(:, 3), [], p4_get_labels(test_size));
        xlabel('PC2'); ylabel('PC3');
    end

    lower_dim_test_set = pca_test_projected(:, 1:2);
    
    for i = 1:test_data_size
        % Computing gi
        g1 = quadratic_classifier(lower_dim_test_set(i, :), lower_dim_training_set1);
        g2 = quadratic_classifier(lower_dim_test_set(i, :), lower_dim_training_set2);
        g3 = quadratic_classifier(lower_dim_test_set(i, :), lower_dim_training_set3);
        
        % Checking if the class predicted matches the original class label
        [~, class_predicted] = max([g1, g2, g3]);
        curr_label = fix(i/ex_per_class) + 1;
        if class_predicted == curr_label
            correct_class = correct_class + 1;
        end
    end
end

disp('Accuracy (PCA)');
disp((correct_class/test_data_size)/it_num);