X = load('train_features.txt');
Y = load('train_result.txt');

YY = Y*Y';
XX = X*X';

Q = YY.*XX;

n = length(X(1,:));
m = length(Y);

cvx_begin
    variable a(m)
    minimize(0.5*a'*Q*a-ones(m,1)'*a)
    subject to
        a >= 0
        a'*Y == 0
        a <= 1
cvx_end

w = repmat((a.*Y),1,n).*X;
w = sum(w);

support_vectors = find(a>1e-4);
b = Y(support_vectors(1,1)) - X(support_vectors(1,1),:)*w';

test_X = load('test_features.txt');
actual_test_Y = load('test_result.txt');

test_Y = test_X*w'+b;

accuracy = length(find(actual_test_Y.*test_Y>0))/10



