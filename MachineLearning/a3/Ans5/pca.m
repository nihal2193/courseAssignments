tic;
I = zeros(19,19);
%toAdjust the data
toAdjI = zeros(2429,19,19);
for im = 1:2429
    s = '';
    for z = length(num2str(im)):4;
        s = strcat(s,'0');
    end
    toAdjI(im,:,:) = double(imread(strcat(strcat(strcat('face',s),num2str(im)),'.pgm')));
end

%calculating the adjusted data
AdjI = zeros(361,2429);
for im = 1:2429
    temp(:,:) = toAdjI(im,:,:);
    AdjI(:,im) = reshape(temp,[361,1]);
end

meanImage = mean(AdjI,2);
mI = reshape(meanImage,[19,19]);
imshow(mI/255);

phi = AdjI - repmat(meanImage,1,2429);
C = zeros(361,361);
for index = 1:2429
    C = C + phi(:,index)*phi(:,index)';
end
C = C/2429;

[U,S,V] = svd(C);

%eigenValue and eigenVector
eValue = zeros(50,1);
eVector = zeros(361,50);

for index = 1:50
    eValue(index,:) = S(index,index); 
    eVector(:,index) = U(:,index);
end

%eFaces
eFaces = zeros(361,50);

for index = 1:50
    eFaces(:,index) = ((eVector(:,index)- min(eVector(:,index)))/max(eVector(:,index))-min(eVector(:,index)))*255;
end

dlmwrite('pc.txt',eFaces,'\t');
prompt = input('Give a faceId to see the projection on EigenFaces!\n');

img = eFaces'*phi(:,prompt);
img1 = eFaces*img + meanImage;
img2 =(img1 - min(img1))/(max(img1)-min(img1));

figure 
imshow(reshape(img2,[19,19]));

toc;