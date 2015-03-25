I1 = imread('apple.jpg');
I2 = imread('orange.jpg');

% I1 = imread('1.png');
% I2 = imread('2.png');



I1 = im2double(I1);
I2 = im2double(I2);
dlmwrite('I2.txt',I2,'\t');

gauss_blur = fspecial('gauss', 15, 1.5);


level = 3;

laplacian_I1 = pyramid(I1, 'laplacian', level);
laplacian_I2 = pyramid(I2, 'laplacian', level);

left_laplacian = cell(level,1);
right_laplacian = cell(level,1);
stitched_laplacian = cell(level,1);


for i=1:level
    cols_mid = floor(size(laplacian_I1{i,1},2)/2);
    cols_end = size(laplacian_I1{i,1},2);
    num_rows = size(laplacian_I1{i,1},1);
    num_cols = size(laplacian_I1{i,1},2);
    depth = size(I1,3);
    
    left_laplacian{i,1} = cat(2, laplacian_I1{i,1}(:,1:cols_mid,:) , zeros(num_rows,cols_mid+1,depth));
    
%     left_laplacian{i,1} = imfilter(left_laplacian{i,1}, gauss_blur,'same');
    
%     cols_mid
%     cols_end
    
    right_laplacian{i,1} = cat(2, zeros(num_rows,cols_mid,depth), laplacian_I2{i,1}(:,cols_mid+1:cols_end,:));

%     right_laplacian{i,1} = imfilter(right_laplacian{i,1}, gauss_blur,'same');
    
    left_laplacian{i,1} = left_laplacian{i,1}(:,1:cols_mid,:);
    right_laplacian{i,1} = right_laplacian{i,1}(:,cols_mid+1:cols_end,:);
    
    stitched_laplacian{i,1} = cat(2, left_laplacian{i,1}, right_laplacian{i,1});
    
    stitched_laplacian{i,1} = imfilter(stitched_laplacian{i,1}, gauss_blur, 'same');
    
end

%reconstructing image from stitched laplacian


gaussian =reconstruct(stitched_laplacian, level);
imshow(gaussian{1,1});


