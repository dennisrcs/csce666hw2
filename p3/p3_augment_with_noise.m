function noisy_data = augment_with_noise(data, num_dimensions)
%AUGMENT_WITH_NOISE Adds noise to the original data feature vector by
%adding #num_dimensions values drawn from a Gaussian distribution into the
%original feature vector

    % Gaussian parameters
    mu = 1;
    sigma = 36;

    % Pre-allocating memory the final feature vector
    noisy_data = zeros(size(data, 1), size(data, 2) + num_dimensions);

    for i = 1:size(data, 1)
        noise = mvnrnd(mu, sigma, num_dimensions);
        noisy_data(i, :) = [data(i, :), noise'];
    end

end
