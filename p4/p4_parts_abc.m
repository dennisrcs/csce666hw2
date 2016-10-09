% First distribution
mu1 = [5 0 5];
sigma1 = [5 -4 -2; -4 4 0; -2 0 5];
samples1 = mvnrnd(mu1, sigma1, 250);

% Second distribution
mu2 = [4 6 7];
sigma2 = [3 0 0; 0 3 0; 0 0 3];
samples2 = mvnrnd(mu2, sigma2, 250);

% Third distribution
mu3 = [6 2 4];
sigma3 = [6 5 6; 5 6 7; 6 7 9];
samples3 = mvnrnd(mu3, sigma3, 250);

% Augmenting feature vector with 48 noisy dimensions
dimensions_augmented = 48;
samples1_augmented = p4_augment_with_noise(samples1, dimensions_augmented);
samples2_augmented = p4_augment_with_noise(samples2, dimensions_augmented);
samples3_augmented = p4_augment_with_noise(samples3, dimensions_augmented);

it_num = 30;
correct_class = 0;
for j = 1:it_num
    % Splitting the data
    [training_set1, test_set1] = p4_split_data(samples1_augmented);
    [training_set2, test_set2] = p4_split_data(samples2_augmented);
    [training_set3, test_set3] = p4_split_data(samples3_augmented);

    % Building test data
    test_data = [test_set1; test_set2; test_set3];
    test_data_size = size(test_data, 1);
    ex_per_class = size(test_set1, 1);
    
    for i = 1:test_data_size
        % Computing gi's
        g1 = quadratic_classifier(test_data(i, :), training_set1);
        g2 = quadratic_classifier(test_data(i, :), training_set2);
        g3 = quadratic_classifier(test_data(i, :), training_set3);

        % Determining which class was predicted by the discriminants
        [~, class_predicted] = max([g1, g2, g3]);
        curr_label = fix(i/ex_per_class) + 1;
        if class_predicted == curr_label
            correct_class = correct_class + 1;
        end
    end
end

disp('Accuracy for high-dimensional data');
disp((correct_class/test_data_size)/it_num);