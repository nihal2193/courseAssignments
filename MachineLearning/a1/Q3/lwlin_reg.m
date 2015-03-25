X = load('q3x.dat');
Y = load('q3y.dat');
m = length(Y);

minX = min(X);
maxX = max(X);

%generating the data which are linearly spaced between min and max
%calculated above
genData = linspace(minX,maxX,100);
len_genData = length(genData);

X = [ones(m,1),X];

%theta calculated from the normal equation
theta_norm = ((inv(X'*X))*X')*Y;

y = theta_norm'*X';
scatter(X(:,2),Y,'.r')
xlabel('x1 values')
ylabel('y values')

hold on
plot(X(:,2),y);

rs = input('tau?');
tau = rs;

for i = 1:len_genData
    W = exp(-(1/(2*tau^2))*((genData(1,i)-X(:,2)).^2));
    WY = W.*Y;
    W2 = repmat(W,1,2);
    WX = W2.*X;

    theta_gen = ((inv(X'*WX))*X')*WY;
    y = theta_gen(1,1)+theta_gen(2,1)*genData(1,i);
    plot(genData(1,i),y,'ob')
end