% sl0alg.m

% SL01 algorithm for compressed sensing reconstruction
function s = SL01(A, x, sigma_min)
    % Initialization
    sigma_decrease_factor = 0.5;
    A_pinv = pinv(A);
    mu_0 = 2;
    L = 3;
    
    s = A_pinv * x;
    sigma = 2 * max(abs(s(:)));

    % Main Loop
    while sigma > sigma_min
        for i = 1:L
            delta = OurDelta(s, sigma);
            s = s - mu_0 * delta;
            s = s - A_pinv * (A * s - x);  % Projection
        end

        sigma = sigma * sigma_decrease_factor;
    end
end

function delta = OurDelta(s, sigma)
    delta = s .* exp(-abs(s).^2 / sigma^2);
end

% Load the original image
original_image = imread('C:\Users\Asus\Desktop\final year project\matlab code\ogdog.jpg');
original_image = rgb2gray(original_image); % Convert to grayscale if needed
original_image = double(original_image);  % Convert to double

% Display the original image
subplot(1, 3, 1);
imshow(original_image, []);
title('Original Image');

% Generate a random binary matrix for compressed sensing
random_matrix = randi([0, 1], [128, 256]); % Adjust the size accordingly
random_matrix = double(random_matrix);

% Resize A to match the size of compressed_image(:)
A = reshape(random_matrix, 1, []);
A = double(A);

% Compress the image using compressed sensing
compressed_image = original_image .* random_matrix;

% Display the compressed image
subplot(1, 3, 2);
imshow(compressed_image, []);
title('Compressed Image');

% Reconstruct the image using the SL01 algorithm
A = random_matrix';
sigma_min = 0.01;  % Adjust as needed
reconstructed_image = SL01(A, compressed_image(:), sigma_min);
reconstructed_image = reshape(reconstructed_image, size(original_image));

% Display the reconstructed image
subplot(1, 3, 3);
imshow(reconstructed_image, []);
title('Reconstructed Image');
