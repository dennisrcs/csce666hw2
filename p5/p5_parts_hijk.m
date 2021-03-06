% Part (h, i, j, k)

ks = [1, 2, 5, 20, 50, 100, 500];
accs_parts_hijk = size(ks, 1);
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

        [lda_training_data, U_lda, ~] = tamu_lda(training_data, p4_get_training_labels');
        lda_test_data = U_lda'  * test_data'; lda_test_data = lda_test_data';

        s = size(training_set1, 1);

        test_ex_per_class = size(test_set1, 1);
        training_ex_per_class = size(training_set1, 1);

        for i = 1:test_data_size
            % Predicting test data class
            class_predicted = knn_predict(lda_test_data(i, :), lda_training_data, training_ex_per_class, ks(k));

            curr_label = fix(i/test_ex_per_class) + 1;
            if class_predicted == curr_label
                correct_class = correct_class + 1;
            end
        end
    end
    
    accs_parts_hijk(k) = (correct_class/test_data_size)/it_num;

    disp(strcat('Accuracy (LDA). k=', num2str(ks(k))));
    disp(accs_parts_hijk(k));
end