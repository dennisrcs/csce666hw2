% Part (h, i, j, k)

correct_class = 0;
for j = 1:it_num
    % Splitting the data
    [training_set1, test_set1] = p4_split_data(samples1_augmented);
    [training_set2, test_set2] = p4_split_data(samples2_augmented);
    [training_set3, test_set3] = p4_split_data(samples3_augmented);
    
    % Creating training and test set
    training_data = [training_set1; training_set2; training_set3];
    test_data = [test_set1; test_set2; test_set3];
    
    [lda_training_data, U_lda, ~] = tamu_lda(training_data, p4_get_training_labels');
    lda_test_data = U_lda'  * test_data'; lda_test_data = lda_test_data';

    if j == 1
        % Plotting pairwise scatter plot (training data)
        figure;
        scatter(lda_training_data(:, 1), lda_training_data(:, 2), [], p4_get_labels(train_size));
        xlabel('Dimension 1'); ylabel('Dimension 2');
        axis tight;

        % Plotting pairwise scatter plot (test data)
        figure;
        scatter(lda_test_data(:, 1), lda_test_data(:, 2), [], p4_get_labels(test_size));
        xlabel('Dimension 1'); ylabel('Dimension 2');
        axis tight;
    end

    s = size(training_set1, 1);
    
    % Retrieving lower dimensional training and test data
    lda_training_set1 = lda_training_data(1:s, :);
    lda_training_set2 = lda_training_data(s+1:2*s, :);
    lda_training_set3 = lda_training_data(2*s+1:end, :);

    for i = 1:test_data_size
        % Computing gi
        g1 = quadratic_classifier(lda_test_data(i, :), lda_training_set1);
        g2 = quadratic_classifier(lda_test_data(i, :), lda_training_set2);
        g3 = quadratic_classifier(lda_test_data(i, :), lda_training_set3);

        % Checking if the class predicted matches the original class label
        [max_val, class_predicted] = max([g1, g2, g3]);
        curr_label = fix(i/ex_per_class) + 1;
        if class_predicted == curr_label
            correct_class = correct_class + 1;
        end
    end
end

disp('Accuracy (LDA)');
disp((correct_class/test_data_size)/it_num);