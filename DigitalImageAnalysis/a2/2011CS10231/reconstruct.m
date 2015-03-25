function [gaussian] = reconstruct(stitched_laplacian, level)
gaussian = cell(level,1);
gaussian{level,1} = stitched_laplacian{level,1};
for i = level-1:-1:1
    rows_vec = 1:1:2*size(gaussian{i+1,1},1)-1;
    cols_vec = 1:1:2*size(gaussian{i+1,1},2)-1;
    stitched_laplacian{i,1} = stitched_laplacian{i,1}(rows_vec, cols_vec, :);
    gaussian{i,1} = stitched_laplacian{i,1} + expand(gaussian{i+1,1});
end

end