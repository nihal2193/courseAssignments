clear
clc
I = imread('apple.jpg');
 
I = im2double(I);

pyr_out_laplacian = pyramid(I,'laplacian',3);

  for i =1:3
    pyr_out_laplacian{i,1} = round(255*(pyr_out_laplacian{i,1})/4)/255 ;
  end
