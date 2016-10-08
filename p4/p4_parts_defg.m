% Part (d, e, f g)
training_data = [training_set1; training_set2; training_set3];
cov_matrix = cov(training_data);
[U_pca, S_pca, ~] = svd(cov_matrix);
U_reduced = U_pca(:, 1:3);
training_projected = U_reduced'  * training_data'; training_projected = training_projected';
test_projected = U_reduced'  * test_data'; test_projected = test_projected';

figure;
subplot(1, 3, 1);
scatter(test_projected(:, 1), test_projected(:, 2), [], p4_get_test_labels);
xlabel('PC1'); ylabel('PC2');

subplot(1, 3, 2);
scatter(test_projected(:, 1), test_projected(:, 3), [], p4_get_test_labels);
xlabel('PC1'); ylabel('PC3');

subplot(1, 3, 3);
scatter(test_projected(:, 2), test_projected(:, 3), [], p4_get_test_labels);
xlabel('PC2'); ylabel('PC3');

s = training_size_class;
lower_dim_training_set1 = training_projected(1:s, 1:2);
lower_dim_training_set2 = training_projected(s+1:2*s, 1:2);
lower_dim_training_set3 = training_projected(2*s+1:end, 1:2);

lower_dim_test_set = test_projected(:, 1:2);

correct_class = 0;
for j = 1:it_num
    for i = 1:test_data_size
        g1 = quadratic_classifier(lower_dim_test_set(i, :), lower_dim_training_set1);
        g2 = quadratic_classifier(lower_dim_test_set(i, :), lower_dim_training_set2);
        g3 = quadratic_classifier(lower_dim_test_set(i, :), lower_dim_training_set3);

        [max_val, class_predicted] = max([g1, g2, g3]);
        curr_label = fix(i/ex_per_class) + 1;
        if class_predicted == curr_label
            correct_class = correct_class + 1;
        end
    end
end

disp((correct_class/test_data_size)/it_num);