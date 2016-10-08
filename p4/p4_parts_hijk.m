% Part (h, i, j, k)
training_data = [training_set1; training_set2; training_set3];
[lda_training_data, U_lda, S_lda] = tamu_lda(training_data, p4_get_training_labels');
lda_test_data = U_lda'  * test_data'; lda_test_data = lda_test_data';

figure;
scatter(lda_test_data(:, 1), lda_test_data(:, 2), [], p4_get_test_labels);
xlabel('PC1'); ylabel('PC2');

s = size(training_set1, 1);
lda_training_set1 = lda_training_data(1:s, :);
lda_training_set2 = lda_training_data(s+1:2*s, :);
lda_training_set3 = lda_training_data(2*s+1:end, :);

correct_class = 0;
for j = 1:it_num
    for i = 1:test_data_size
        g1 = quadratic_classifier(lda_test_data(i, :), lda_training_set1);
        g2 = quadratic_classifier(lda_test_data(i, :), lda_training_set2);
        g3 = quadratic_classifier(lda_test_data(i, :), lda_training_set3);

        [max_val, class_predicted] = max([g1, g2, g3]);
        curr_label = fix(i/ex_per_class) + 1;
        if class_predicted == curr_label
            correct_class = correct_class + 1;
        end
    end
end

disp((correct_class/test_data_size)/it_num);