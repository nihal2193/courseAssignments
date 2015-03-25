X = load('q2x.dat');
Y = load('q2y.dat');

%no of test cases
m = length(Y);


X = [ones(m,1),X];

theta = [0;0;0];

%log likelyhood of the function parameterized by thetas
loglikelyhood = 1./(1+exp(-X*theta));

loglikelyhoodbar = 1- loglikelyhood;

%scaling the matrix to have column column elementwise multiplication
scale = repmat(loglikelyhood.*loglikelyhoodbar,1,3);
Xprime = scale.*X;


theta_new = theta + ((inv(X'*Xprime))*X')*(Y-loglikelyhood);

iterations = 1;

%first order derivative of cost function
FOD_log_reg = X'*(Y-loglikelyhood);

while(abs (FOD_log_reg(1,1)) > 1e-6 || abs (FOD_log_reg(2,1)) > 1e-6 || abs (FOD_log_reg(3,1)) > 1e-6)

    theta = theta_new;
    
    loglikelyhood = 1./(1+exp(-X*theta));

    loglikelyhoodbar = 1- loglikelyhood;

    scale = repmat(loglikelyhood.*loglikelyhoodbar,1,3);
    
    Xprime = scale.*X;
    
    theta_new = theta + ((inv(X'*Xprime))*X')*(Y-loglikelyhood);
    
    FOD_log_reg =  X'*(Y-loglikelyhood);
    
    iterations = iterations + 1;
end
figure
for i = 1:m
    if(Y(i,1)==0)
        scatter(X(i,2),X(i,3),'.r');
        hold on
    end

    if(Y(i,1)==1)
        scatter(X(i,2),X(i,3),'ob');
        hold on
    end    

end
xlabel({'x1 values';strcat('theta0: ',num2str(theta_new(1,1)));strcat('theta1: ',num2str(theta_new(2,1)));strcat('theta2: ',num2str(theta_new(3,1)))})
ylabel('x2 values')
legend('Red as negative points','Blue as positive points','Location','NorthWest')
x1 = linspace(min(X(:,2)),max(X(:,2)));
x2 = (-theta_new(1,1) - theta_new(2,1)*x1)/theta_new(3,1);

plot(x1,x2);
hold off;