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
samples1_augmented = augment_with_noise(samples1, dimensions_augmented);
samples2_augmented = augment_with_noise(samples2, dimensions_augmented);
samples3_augmented = augment_with_noise(samples3, dimensions_augmented);

% Part (a)

% Splitting the data
[training_set1, test_set1] = split_data(samples1_augmented);
[training_set2, test_set2] = split_data(samples2_augmented);
[training_set3, test_set3] = split_data(samples3_augmented);

% Part (b, c)

test_data = [test_set1; test_set2; test_set3];
test_data_size = size(test_data, 1);
ex_per_class = size(test_set1, 1);
it_num = 30;

correct_class = 0;
for j = 1:it_num
    for i = 1:test_data_size
        g1 = quadratic_classifier(test_data(i, :), training_set1);
        g2 = quadratic_classifier(test_data(i, :), training_set2);
        g3 = quadratic_classifier(test_data(i, :), training_set3);

        [max_val, class_predicted] = max([g1, g2, g3]);
        curr_label = fix(i/ex_per_class) + 1;
        if class_predicted == curr_label
            correct_class = correct_class + 1;
        end
    end
end

disp('Mean classification rate averaged over 10 iterations')
disp((correct_class/test_data_size)/it_num);

