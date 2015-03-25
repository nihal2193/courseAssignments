tic;
clear;
clc;
load('q3-sub.mat');
X = data.raw;
numF = size(X,2)-1;
X = X(:,1:6);
Y = data.Y;

m = 9000;



X = [ones(m,1),X];
acc = zeros(5,1);
for splits = 1:5
r = randperm(9000);

%train
Xtrain = X(r(1,1:6000),:);
Xtest = X(r(1,6001:end),:);
Ytrain = Y(r(1,1:6000),:);
Ytest = Y(r(1,6001:end),:);


[m,n] = size(Xtrain);

theta = zeros(n,1);
%[0;0;0];

%log likelyhood of the function parameterized by thetas
xT = Xtrain*theta;
loglikelyhood = (1+exp(-xT));
loglikelyhood = 1./loglikelyhood;

loglikelyhoodbar = 1- loglikelyhood;

%scaling the matrix to have column column elementwise multiplication
temp = loglikelyhood.*loglikelyhoodbar;
scale = repmat(temp,1,n);
Xprime = scale.*Xtrain;


theta_new = ones(7,1)./1e+5;

iterations = 1;

%first order derivative of cost function
FOD_log_reg = Xtrain'*(Ytrain-loglikelyhood);

while(abs(theta_new - theta) > 1e-6)

    theta = theta_new;

    xT = Xtrain*theta;
    loglikelyhood = (1+exp(-xT));
    loglikelyhood = 1./loglikelyhood;

    loglikelyhoodbar = 1- loglikelyhood;

    %scaling the matrix to have column column elementwise multiplication
    temp = loglikelyhood.*loglikelyhoodbar;
    scale = repmat(temp,1,n);
    Xprime = scale.*Xtrain;
    
    theta_new = theta + 0.00001*((inv(Xtrain'*Xprime))*Xtrain')*(Ytrain-loglikelyhood);
    
    FOD_log_reg =  Xtrain'*(Ytrain-loglikelyhood);
    
    iterations = iterations + 1;
    
    if(mod(iterations,500)==0)
        iterations
    end
end


YT = 1./(1+exp(-Xtest*theta));
for index = 1 :3000
    if(YT(index,:)>0.5)
        YT(index,:) = 1;
    else
        YT(index,:) = 0;
    end
end

res = YT + Ytest;

acc(splits,1) = size(find(res==0),1) + size(find(res==2),1);

fprintf('Accuracy of split %s is %s \n',num2str(splits),num2str(acc(splits,1)/30));

end

fprintf('Avg Accuracy is %s\n',num2str(mean(acc)/30));

toc;