% Load the original image
original_image = imread('C:\Users\Asus\Desktop\final year project\matlab code\ogdog.jpg');
original_image = rgb2gray(original_image); % Convert to grayscale if needed
original_image = double(original_image);  % Convert to double

% Display the original image
subplot(1, 3, 1);
imshow(original_image, []);
title('Original Image');

% Generate a random binary matrix for compressed sensing
random_matrix = randi([0, 1], size(original_image));

% Convert random_matrix to double
random_matrix = double(random_matrix);

% Compress the image using compressed sensing
compressed_image = original_image .* random_matrix;

% Display the compressed image
subplot(1, 3, 2);
imshow(compressed_image, []);
title('Compressed Image');

% Reconstruct the image using the SL01 algorithm
A = random_matrix;
sigma_min = 0.01;  % Adjust as needed
reconstructed_image = SL01(A, compressed_image(:), sigma_min);
reconstructed_image = reshape(reconstructed_image, size(original_image));

% Display the reconstructed image
subplot(1, 3, 3);
imshow(reconstructed_image, []);
title('Reconstructed Image');
