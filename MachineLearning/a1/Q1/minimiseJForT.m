function [ t0,t1, thetas, vjTheta ] = minimiseJForT( X,Y )
%return the values of thetas for which the cost function parameterized by
%thethas is minimum and the theta values and jTheta values while the cost function minimises.

% m is no of training examples
    m = length(X);
    
     %learning parameter
    prompt = 'Learning rate? ';
    rs = input(prompt);

    eta = rs;
    
    %scatter plot of given data
    figure
    scatter(Y,X) 
    hold on

   
   
    std1 = std(X);
    mX = mean(X);
    X=(X-mX)/std1;
    
    % no of iterations
    iterations=0;

    %adding a column of 1's for x0s i.e taking intercept term into account
    dataX = [ones(m,1),X];
    
    %theta_old is initialised with the zero values
    theta_old = [0,0];
    
    %j_theta is the initial value of cost function
    j_theta = (1/2)*sumsqr(Y'-theta_old*dataX')/m;
    
    del_j_theta = ((Y'-theta_old*dataX')*dataX)/m;
    
    %updating theta for the first time
    theta_new = theta_old + eta *del_j_theta;
    
    del_j_theta_new = ((Y'-theta_new*dataX')*dataX)/m;
    %storing the updated value of parameters after one iteration of batch gradient
    thetas(1,:) = theta_old;
    vjTheta(1,:) = j_theta;
    
    %initial value of j
    
    while (abs(del_j_theta_new(1,1) - del_j_theta(1,1)) > 1e-6 || abs(del_j_theta_new(1,2) - del_j_theta(1,2)) > 1e-6)
        
        theta_old = theta_new;
        
        j = j_theta;
        
        del_j_theta = ((Y'-theta_old*dataX')*dataX)/m;
        
        j_theta = (1/2)*sumsqr(Y'-theta_old*dataX')/m;
        
        theta_new = theta_old + eta *del_j_theta ;

        del_j_theta_new = ((Y'-theta_new*dataX')*dataX)/m;
        
        iterations=iterations+1;
        
        %eta = eta/(iterations+1) ;
        
        %storing the value of thetas and the value of cost function
        thetas(iterations,:) = theta_old;
        vjTheta(iterations,:)=j;
      
        
    end
    
    thetas(length(thetas)+1,:) = theta_new;
    vjTheta(length(vjTheta)+1,:)=j_theta;

    %the values of theta for which the hypothesis function is minimum
    t0=theta_new(1);
    t1=theta_new(2);

    %plotting the hyposthesi function i.e theta'x
    y=dataX*theta_new';
    plot(y,X,'g')
    title('Least Squares Linear Regression')
    xlabel('area')
    ylabel('price')
    str_t0=num2str(theta_new(1));
    str_t1=num2str(theta_new(2));
    str = strcat('theta0: ',str_t0,' theta1: ',str_t1);
    legend(sprintf('%s',str) );
    fprintf('no of iterations: ''%s\n',num2str(iterations));
    fprintf('theta0 : \''%s\n' ,num2str(theta_new(1)));
    fprintf('theta1 : ''%s\n' ,num2str(theta_new(2)));
    hold off;

   

end

