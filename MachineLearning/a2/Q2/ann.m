XX = load('mnist_all.mat');
X3 = XX.train3;
X8 = XX.train8;

m3 = floor(size(X3,1)*(4/5));
X3t = X3(1:m3,:);
X3v = X3(m3+1:end,:);
m3v = size(X3v,1);

m8 = floor(size(X8,1)*(4/5));
X8t = X3(1:m8,:);
X8v = X8(m8+1:end,:);
m8v = size(X8v,1);

X = [X3t;X8t];

Xlabel = [ones(m3,1);zeros(m8,1)];

%X = X(randperm(size(X,1)),:);

t=1;
%%

m = size(X,1);
n = size(X,2);

%number of hidden layers
nH = 100;
nO = 2;

% bias is feeding to every neuron in the network
%weights at output layer 
wout = rand(nH+1,nO)./(nH+1);

%weights at first hidden layer
win = rand(n+1,nH)./n+1;

%initial bias 
bin = rand(nH+1,1);

bout = rand(nO,1);

%Output of neurons
O = zeros(nH,1);

%o weighted sum of the hidden neuron
o = zeros(nH,1);

%Y output of the output layers
Y = zeros(nO,1);

%y weighted sum at the output neuron
y = zeros(nO,1);

nbatch = 50;
batch = 100;

%%
%for calculating error errX,errY,errT inputvector,output,target
errX = zeros(batch,n);
errY = zeros(batch,nO);
errT = zeros(batch,nO);

target = zeros(2,1);
a = abs([1;0]-Y) > 1e-6;
err = 1;
while(err > 0.1)
    for k = 1:100
        
        
        randk = floor(rand(1,1)*m+1);
        
        eta = 0.01;
       
%normalise the image /256 
% toshow binary image use imshow(image ~=0)
%hidden layer output

        for i = 1:nH
            wtranspose = win(:,i)';
            ex = X(randk,:);
            label = Xlabel(randk,1);
            if(label == 1)
                target(1,1) = 1;
                target(2,1) = 0;
            else
                target(1,1) = 0;
                target(2,1) = 1;
            end
            o(i) = sum(wtranspose.*[1 double(ex)]); %wtranspose*[1 ex]';
            O(i) = sigmf(o(i),[1,0]);
        end
        errX(k,:) = ex;
        
        %final layer output
        for i = 1:nO
            y(i) = wout(:,i)'*[1,O']';
            Y(i) = sigmf(y(i),[1,0]);
        end
        errY(k,:) = Y';
        
        a = abs([1;0]- Y)>1e-6;
        %%
        %delj = -(dj/dnetj)
        %derivative of cost function is
        %(dj/dthetajk) = (dj/dnetj)*(dnetj/dthetajk)
        
        deljout = zeros(nO,1);
        
        %actualY 1 is for 3 and 0 is for 8
        actualY = [1,0];
        tempErrT = zeros(nO,1);
        for i = 1:nO
            tempErrT(i) = (target(i,1) - Y(i));
            deljout(i) = (target(i,1) - Y(i)) * (1-Y(i))*Y(i);
        end
        
        errT(k,:) = tempErrT';
        
        deljin = zeros(nH,1);
        for i = 1:nH
            wi = zeros(nO,1);
            del = zeros(nO,1);
            for j = 1:nO
                wi(j,1) = wout(i+1,j); %first weight is for bias
                del(j,1) = deljout(j);
            end
            deljin(i) = wi'*del;
            deljin(i) = deljin(i)*(O(i)*(1-O(i)));
        end
        %%
        %new weights at output layer woutU is del of cost function
        woutU = repmat(deljout',nH+1,1).*repmat([1;O],1,nO);
%         size(woutU)
%         size(wout)
        wout = wout + eta*woutU;
        
        %new weights at hidden layer
        winU = repmat(deljin',n+1,1).*repmat([1 double(X(randk,:))]',1,nH);
        win = win + eta*winU;
        display(t);
        t = t+1;
    end
    %err 
    
%     for j = 1:batch
    err = norm(errT,2);
%     end
    err = err/batch;
    error(floor(t/100)) = err;
    
end
plot(100:100:t,error);


%%validation
Xv = [X3v;X8v];
mv = size(Xv,1);
nv = size(Xv,2);
Xvlabel = [ones(m3v,1);zeros(m8v,1)];
%hidden layer output
correct = 0;
incorrect = 0;
for k = 1:mv
    for i = 1:nH
        wtranspose = win(:,i)';
        ex = Xv(k,:);
        label = Xvlabel(k,1);
        if(label == 1)
            target = 1;
        else
            target =0;
        end
        o(i) = sum(wtranspose.*[1 double(ex)]); %wtranspose*[1 ex]';
        O(i) = sigmf(o(i),[1,0]);
    end
    errX(k,:) = ex;
    
    %final layer output
    for i = 1:nO
        y(i) = wout(:,i)'*[1,O']';
        Y(i) = sigmf(y(i),[1,0]);
    end
    
    [x,y] = find(Y == max(max(Y)));
    if((Xvlabel(k,1) == 1 && x==1) || (Xvlabel(k,1) == 0 && x==0) )
        correct = correct + 1;
    else
        incorrect = incorrect + 1;
    end
    
end