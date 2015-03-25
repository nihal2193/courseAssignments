X = importdata('q1x.dat');
Y = importdata('q1y.dat');

%no of test cases
m = length(X);
%since there are a lot of values of theta so for better visibility every
%value at the multiple of interval is shown in the plots.
interval = 1;

std1 = std(X);
mX = mean(X);
X=(X-mX)/std1;
    
%taking care of intercept term
dataX = [ones(m,1),X];

%minimised cost function output
[t0,t1, thetas, jtheta] = minimiseJForT(X,Y);

%range of theta0 and theta1 to plot
range_t0=max(thetas(:,1))-min(thetas(:,1));
range_t1=max(thetas(:,2))-min(thetas(:,2));

tmin0 = min(thetas(:,1))-2*range_t0;
tmax0 = max(thetas(:,1))+2*range_t0;
tmin1 = min(thetas(:,2))-2*range_t1;
tmax1 = max(thetas(:,2))+2*range_t1;

theta0 = linspace(tmin0,tmax0,100);
theta1 = linspace(tmin1,tmax1,100);

%creating a mesh for 3d plot
[theta0g,theta1g] = meshgrid(theta0,theta1);


cost_function = zeros(length(theta0),length(theta1));
for i=1:length(theta0)
    for j=1:length(theta1)
        
        cost_function(i,j) = sumsqr(theta0g(i,j)*dataX(:,1)+theta1g(i,j)*dataX(:,2)-Y(:,1))/m/2;
       
    end
end

 j_theta_min = (1/2)*sumsqr(Y'-[t0,t1]*dataX')/m;
display(j_theta_min);
 
%plotting the contour and 3d plot of cost function with the values of theta
%being updated after every 0.2 seconds 
figure
surfc(theta0g,theta1g,cost_function);
xlabel('theta0')
ylabel('theta1')
zlabel('cost function')
hold on
for j=1:floor(length(thetas)/interval)
    plot3(thetas(interval*j,1),thetas(interval*j,2),jtheta(interval*j,1),'.r');
    view(65,50-50/j);
    pause(0.2);
end
hold off;

valuesToShow = mod(length(jtheta),interval);

jthetaToShow = zeros(floor(length(jtheta)/interval),1);

jthetaToShow(1) = jtheta(1,1);

for i=2:floor(length(jtheta)/interval)
    jthetaToShow(i,1) = jtheta(interval*i+valuesToShow,1);
end

figure
%contour(theta0g,theta1g,cost_function)
contour(theta0g,theta1g,cost_function,sort(jthetaToShow))
xlabel('theta0')
ylabel('theta1')

hold on
for j=1:floor(length(thetas)/interval)
plot(thetas(interval*j,1),thetas(interval*j,2),'.r');
pause(0.2);
end

hold off;
