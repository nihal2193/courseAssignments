clear;
clc;
data = load('train-0.data');
test = load('test.data');

d0 = find(data(:,1)==0);
d1 = find(data(:,1)==1);
i0 = find(data(:,2)==0);
i1 = find(data(:,2)==1);

%diff = zeros(2,1);
D = [size(d0,1);size(d1,1)]/10000;
logD = log(D);

I =[size(i0,1);size(i1,1)]/10000;
logI =log(I);


G = zeros(2,2,3);
for d = 1:2
    for i = 1:2
        for grd = 1:3
            dd = find(data(:,1)==d-1);
            ii = find(data(:,2) == i-1);
            di = intersect(dd,ii);
            g = find(data(:,3) == grd);
            G(d,i,grd) = size(intersect( di,g),1)/size(di,1);      
        end
    end
end
logG = log(G);

S = zeros(2,2);
for i = 1:2
    for s = 1:2
        ii = find(data(:,2)==i-1);
        ss = find(data(:,4)==s-1);
        S(i,s) = size(intersect(ii,ss),1)/size(ii,1);
    end
end
logS = log(S);

L = zeros(3,2);
for g = 1:3
    for l = 1:2
        gg = find(data(:,3)==g);
        ll = find(data(:,5)==l-1);
        L(g,l) = size(intersect(gg,ll),1)/size(gg,1);
    end
end
logL = log(L);

P =0;
for m = 1:size(test,1)
    for features = 1:5
        switch(features)
            case 1
                P = P + logD(test(m,1)+1,1);
                
            case 2
                P = P + logI(test(m,2)+1,1);
                %break;
            case 3
                P = P + logG(test(m,1)+1,test(m,2)+1,test(m,3));
                %break;
            case 4
                P = P + logS(test(m,2)+1,test(m,4)+1);
                %break;
            case 5
                P = P + logL(test(m,3),test(m,5)+1);
        end
    end
end

Y = textread('train-5.data','%s','delimiter','\n');

X = zeros(10000,5);
for index = 1:10000
    temp = Y{index,1};
    for i = 1:5
        X(index,i) = (temp(1,2*i-1));
    end
end

X = X-47;
[r,c] = find(X==16);
missingIndex = r;

Xcomp = X;
Xcomp(r,:) = [];
Xmiss = X(r,:);
