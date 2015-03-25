tic;
clear;
clc;
load('q3-sub.mat');
X = data.raw;
numF = size(X,2)-1;
X = X(:,1:numF);
Y = data.Y;
num0 = size(find(Y==0),1);
num1 = size(find(Y==1),1);
prior(1,1) = log(num0/9000);
prior(2,1) = log(num1/9000);
%posterior(class,attr,value)
posterior = zeros(2,numF,5);
m = 9000;


acc = zeros(5,1);
for splits = 1:5
    r = randperm(9000);

    %train
    Xtrain = X(r(1,1:6000),:);
    
    Xtest = X(r(1,6001:end),:);
    Ytrain = Y(r(1,1:6000),:);
    Ytest = Y(r(1,6001:end),:);
    [m,n] = size(Xtrain);
    num0train = size(find(Ytrain==0),1);
    num1train = size(find(Ytrain==1),1);
    for index = 1:m
        if(Ytrain(index,1)==1)
            for j = 1:numF
                posterior(2,j,Xtrain(index,j)) = posterior(2,j,Xtrain(index,j)) + 1;
            end
        else
            for j = 1:numF
                posterior(1,j,Xtrain(index,j)) = posterior(1,j,Xtrain(index,j)) + 1;
            end
        end
        
    end
    posterior(1,:,:) = posterior(1,:,:)/num0train;
    posterior(2,:,:) = posterior(2,:,:)/num1train;    
    posterior = log(posterior);
    
    YT = zeros(3000,1);
    for index = 1:3000
        p = 0;
        q = 0;
        for features = 1:numF
            p = p + prior(1)+ posterior(1,features,Xtest(index,features));
            q = q + prior(2)+ posterior(2,features,Xtest(index,features));
        end
        if(p>q)
            YT(index,1) = 0;
        else
            YT(index,1) = 1;
        end
    end
    res = YT+Ytest;
    acc(splits,1) = size(find(res==0),1)+size(find(res==2),1);
    
    fprintf('Accuracy of split %s is %s \n',num2str(splits),num2str(acc(splits,1)/30));
    
    
end
fprintf('Avg Accuracy is %s\n',num2str(mean(acc)/30));

toc;