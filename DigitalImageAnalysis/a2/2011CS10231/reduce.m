function [G_reduce] = reduce(toReduce)

I = toReduce;



G = im2double(I);

a = 0.375;

gaussian_kernel1D = [1/4-a/2,1/4,a,1/4,1/4-a/2];

%gaussian filter kernel
w = kron(gaussian_kernel1D, gaussian_kernel1D');


rows = size(G,1);
cols = size(G,2);
depth = size(G,3);

rows_reduce_vec = 1:2:rows;
cols_reduce_vec = 1:2:cols;

rows_reduce = size(1:2:rows);
cols_reduce = size(1:2:cols);
G_reduce = zeros(rows_reduce(1,2), cols_reduce(1,2), size(G,3));

G_prime = zeros(size(G));

for color = 1:depth
    G_prime(:,:,color) = G(:,:,color);
    %filtering the color'th layer of image with output having 'same' dimensions
    G_prime = imfilter(G_prime,w,'same');
    G_reduce(:,:,color) = G_prime(rows_reduce_vec, cols_reduce_vec, color);
end

%show the reduced image
% imshow(G_reduce);
% imwrite(G_reduce, 'a.png', 'png', 'transparency', 'TransparentColor');
end
