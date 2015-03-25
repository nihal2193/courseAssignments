X = importdata('q4x.dat');
Y = importdata('q4y.dat');

%no of training examples
m = length(Y);

%Y_prime contains the mapping of Alaska to 0 and Canada to 1
Y_prime = ones(m,1);
figure
hold on

%no of training examples which are negative
y0count = 0;

for i = 1:m
    if strcmp(Y(i,1),'Alaska')
        Y_prime(i,1) = 0;
        y0count = y0count + 1;
    end
    
end

%phi is P(y=0), bernoulli parameter
phi = y0count/m;

%no of training examples which are positive
y1count = m - y0count;

%mean of training examples belonging to Alaska
mean0 = [0,0];
for i = 1:m
    if(Y_prime(i,1)==0)
        mean0 = mean0 + X(i,:);
        scatter(X(i,1),X(i,2),'.r');
    end
end
mean0 = mean0/y0count;
plot(mean0(1,1),mean0(1,2),'or');


%mean of training examples belonging to Canada
mean1 = [0,0];
for i = 1:m
    if(Y_prime(i,1)==1)
        mean1 = mean1 + X(i,:);
        scatter(X(i,1),X(i,2),'.b');
    end
end
mean1 = mean1/y1count;
plot(mean1(1,1),mean1(1,2),'ob');

%sigma the co-variance matric which is same for both
sigma = [0,0;0,0];
for i = 1:m
    if(Y_prime(i,1) == 0)
        sigma = sigma + (X(i,:)-mean0)'*(X(i,:)-mean0) ;
    end
    if(Y_prime(i,1) == 1)
        sigma = sigma + (X(i,:)-mean1)'*(X(i,:)-mean1) ;
    end
end
sigma = sigma/m;

%storing the points belonging to Canada
X1 = zeros(y1count,1);
X2 = zeros(y1count,1);

%calculating sigma0 i.e. co-variance matrix of training data for Alaska
sigma0 = [0,0;0,0];
for i = 1:m
    if(Y_prime(i,1)==0)
        sigma0 = sigma0 + (X(i,:)-mean0)'*(X(i,:)-mean0);
    end
end
sigma0 = sigma0/y0count;

%calculating sigma1 i.e. co-variance matrix of training data for Canada
sigma1 = [0,0;0,0];
for i = 1:m
    if(Y_prime(i,1)==1)
        sigma1 = sigma1 + (X(i,:)-mean1)'*(X(i,:)-mean1);
        X1(i)= X(i,1);
        X2(i)= X(i,2);
    end
end
sigma1 = sigma1/y1count;

%plotting the straight line separator for the given data set
x1 = 1:1:180;
x2 = (x1*(mean0(1,1)-mean1(1,1))+(mean1(1,1)^2 + mean1(1,2)^2 - mean0(1,1)^2 - mean0(1,2)^2)/2)/(mean1(1,2)-mean0(1,2));
plot(x1,x2);


%plotting the contours of normal curves for the given training set
x1 = min(X(:,1)):.2:max(X(:,1));
x2 = min(X(:,2)):.2:max(X(:,2));
[X1,X2] = meshgrid(x1,x2);
%following two lines are taken from example of multivariate normal
%distribution from MathWorks
F = mvnpdf([X1(:) X2(:)],mean0,sigma0);
F = reshape(F,length(x2),length(x1));
contour(x1,x2,F);


x1 = min(X(:,1)):.2:max(X(:,1)); x2 = min(X(:,2)):.2:max(X(:,2));
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mean1,sigma1);
F = reshape(F,length(x2),length(x1));
contour(x1,x2,F);

%plotting the quadratic separator
x0 = min(X(:,1)):.2:max(X(:,1));
syms x1 x2
XX = [x1;x2];

mean1 = mean1';
mean0 = mean0';
 
y1= @(XX) (XX-mean1)'*(inv(sigma1))*(XX-mean1)-(XX-mean0)'*(inv(sigma0))*(XX-mean0) ; 
ezplot(@(x1,x2) y1([x1;x2]),[0 180 0 500]);
