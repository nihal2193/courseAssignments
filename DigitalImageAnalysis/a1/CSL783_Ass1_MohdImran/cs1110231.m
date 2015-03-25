%Title : Canny Edge Detector
%Name : Mohd Imran
%Entry No: 2011CS10231
%Date of submission : 22 Aug 2014
%Honor code : This assignment is my own work and no cde has been taken from
%any source.

%read the image
I = imread('kat.jpg');

%convert it to grayscale image
gray = rgb2gray(I);

%define gaussian filter with sigma=2
gaussian = fspecial('gaussian',[5,5],2);

%blurr the image with gaussian filter
blurred = imfilter(gray,gaussian,'same');

%apply the inbuild sobel operator
[Gmag,Gdir]=imgradient(blurred,'sobel');


%%rounding the directions
rDir=roundM(Gdir);

%normalising the magnitude of gradients
Gmag= 255.*(Gmag./max(Gmag(:)));

%% non maximal supression
nmsMag=nonMaxSup(Gmag,rDir);

%normalising the magnitude after non-maximal supression
nmsMag=255.*(nmsMag./max(nmsMag(:)));

%%hysterysis thresholding
hsT = hystThresh(nmsMag);

%show the results
subplot(1,2,1),imshow(I) ,title('Original')
subplot(1,2,2),imshow(hsT),title('Implemented Canny')

