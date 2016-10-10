% Part (d, e, f g)

ks = [1, 2, 5, 20, 50, 100, 500];
accs_parts_defg = size(ks, 1);
it_num = 30;

for k = 1:size(ks, 2)
    
    correct_class = 0;
    for j = 1:it_num

        % Splitting the data
        [training_set1, test_set1] = p4_split_data(samples1_augmented);
        [training_set2, test_set2] = p4_split_data(samples2_augmented);
        [training_set3, test_set3] = p4_split_data(samples3_augmented);

        % Creating training and test set
        training_data = [training_set1; training_set2; training_set3];
        test_data = [test_set1; test_set2; test_set3];

        % Normalizing data
        training_data = normc(training_data);
        test_data = normc(test_data);

        % PCA
        pca_cov_matrix = cov(training_data);
        [U_pca, ~, ~] = svd(pca_cov_matrix);
        U_pca_reduced = U_pca(:, 1:3);

        % Projecting training and test data
        pca_training_projected = U_pca_reduced' * training_data'; pca_training_projected = pca_training_projected';
        pca_test_projected = U_pca_reduced' * test_data'; pca_test_projected = pca_test_projected';

        s = size(training_set1, 1);

        % Retrieving lower dimensional training and test data
        lower_dim_training_set1 = pca_training_projected(1:s, 1:2);
        lower_dim_training_set2 = pca_training_projected(s+1:2*s, 1:2);
        lower_dim_training_set3 = pca_training_projected(2*s+1:3*s, 1:2);
        lower_dim_training_data = [lower_dim_training_set1; lower_dim_training_set2; lower_dim_training_set3];
        lower_dim_test_set = pca_test_projected(:, 1:2);

        test_ex_per_class = size(test_set1, 1);
        training_ex_per_class = size(training_set1, 1);
        
        for i = 1:test_data_size
            % Predicting test data class
            class_predicted = knn_predict(lower_dim_test_set(i, :), lower_dim_training_data, training_ex_per_class, ks(k));

            curr_label = fix(i/test_ex_per_class) + 1;
            if class_predicted == curr_label
                correct_class = correct_class + 1;
            end
        end
    end
    
    accs_parts_defg(k) = (correct_class/test_data_size)/it_num;
    disp(strcat('Accuracy (PCA). k=', num2str(ks(k))));
    disp(accs_parts_defg(k));
end