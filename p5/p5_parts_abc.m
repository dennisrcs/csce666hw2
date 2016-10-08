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

% Part (a, b, c)

ks = [1, 2, 5, 10, 50, 100, 200];
accs_parts_abc = size(ks, 1);
it_num = 30;

for k = 1:size(ks, 2)
    
    correct_class = 0;
    for j = 1:it_num

        % Splitting the data
        [training_set1, test_set1] = p5_split_data(samples1_augmented);
        [training_set2, test_set2] = p5_split_data(samples2_augmented);
        [training_set3, test_set3] = p5_split_data(samples3_augmented);

        % Building training and test data
        training_data = [training_set1; training_set2; training_set3];
        test_data = [test_set1; test_set2; test_set3];

        % Normalizing data
        training_data = normc(training_data);
        test_data = normc(test_data);

        test_data_size = size(test_data, 1);
        test_ex_per_class = size(test_set1, 1);
        training_ex_per_class = size(training_set1, 1);

        for i = 1:test_data_size
            class_predicted = knn_predict(test_data(i, :), training_data, training_ex_per_class, ks(k));

            curr_label = fix(i/test_ex_per_class) + 1;
            if class_predicted == curr_label
                correct_class = correct_class + 1;
            end
        end
    end

    accs_parts_abc(k) = (correct_class/test_data_size)/it_num;
    disp(strcat('Mean classification high-dimensional data. k=', num2str(ks(k))));
    disp(accs_parts_abc(k));
end

figure;
scatter(ks, accs_parts_abc);
xlabel('k'); ylabel('average accuracy');
title('KNN-Accuracy for High dimensional space');