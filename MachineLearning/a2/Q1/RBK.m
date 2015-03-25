X = load('train_features.txt');
Y = load('train_result.txt');

[m,n] = size(X);

YY = Y*Y';
XX = X*X';

Xi2 = diag(XX);
Xi2 = repmat(Xi2,1,m);
Xj2 = Xi2';

eX = Xi2+Xj2-2*XX;

gamma = 2.5*1e-4;

KM = exp(-gamma*eX);

Q = YY.*KM;

cvx_begin
    variable a(m)
    minimize(0.5*a'*Q*a-ones(m,1)'*a)
    subject to
        a >= 0
        a'*Y == 0
        a <= 1
cvx_end

%w = repmat((a.*Y),1,n).*X;
%w = sum(w);

actualTestY = load('test_result.txt');
testX = load('test_features.txt');
[tm,tn] = size(testX);

count = 1;

for i = 1:2000
    if(a(i)>1e-4 && a(i)<1-1e-4)
        supportV(count,1) = a(i);
        supportI(count,1) = i; % storing the index
        count = count + 1;
        
    end
end

%taking the first support vector
sum1 = 0;
for i = 1:count-1
    sum1 = sum1 + supportV(i,1)*Y(supportI(i,1))*KM(supportI(i,1),supportI(1,1));
end


if (count>1)
    b = Y(supportI(1,1)) - sum1;
end


for j = 1:tm
    sum2 = 0; %predicting for test data
    for i = 1:count-1
        sum2 = sum2 + supportV(i,1)*Y(supportI(i,1))*exp(-gamma*(norm(X(supportI(i,1))-testX(j),2)));
    end

    pTestY(j,1) = b+sum2;
end

%b = Y(support_vectors(1,1))- AY'*M(support_vector(1,1),:)';

%res = zeros(m,1);
%for i = 1:m
 %   res(i) = b + AY'*testM(i,:)';
%end

