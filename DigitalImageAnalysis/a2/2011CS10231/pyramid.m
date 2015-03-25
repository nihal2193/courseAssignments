function [pyr_out] = pyramid(toGenerate, type, level)

% compressed_laplacian;
%if(strcmp(type,'gaussian') == 1)
%calculation is for gaussian which is also needed for laplacian
pyramid = cell(level,1);

pyramid{1,1} = im2double(toGenerate);

    for i = 1:level-1
        pyramid{i+1,1} = reduce(pyramid{i,1});
    end
    %gaussian output 
    pyr_out_gaussian = pyramid;

%elseif(strcmp(type,'laplacian') == 1)
    %laplacian of level would be same as gaussian = pyramid{level}
    for i = 1:1:level-1
        rows_vec = 1:1:(2*size(pyramid{i+1,1},1)-1);
        cols_vec = 1:1:(2*size(pyramid{i+1,1},2)-1);
        pyramid{i,1} = pyramid{i,1}(rows_vec,cols_vec,:);
        pyramid{i,1} = pyramid{i,1} - expand(pyramid{i+1,1});
       
        filenamei = strcat(num2str(i),'.txt');
        dlmwrite(filenamei,pyramid{i,1},'\t');
    end
    %laplacian output
    pyr_out_laplacian = pyramid;
    
if(strcmp(type,'gaussian') == 1)
    pyr_out = pyr_out_gaussian;
%     compressed_laplacian = pyr_out_laplacian;


elseif(strcmp(type,'laplacian') ==1)
    pyr_out = pyr_out_laplacian;
%     compressed_laplacian = pyr_out_laplacian;
end


end
