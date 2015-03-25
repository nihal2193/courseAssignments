clear;
clc;
Y = textread('train-5.data','%s','delimiter','\n');

X = zeros(10000,5);
for index = 1:10000
    temp = Y{index,1};
    for i = 1:5
        X(index,i) = (temp(1,2*i-1));
    end
end

X = X-48;
[r,c] = find(X==15);
missingIndex = r;

m = size(X,1);
Xcomp = X;
Xcomp(r,:) = [];
Xmiss = X(r,:);

[D,I,G,S,L] = fillTable(Xcomp);
%first column is weight
Xcopy = [ones(m,1),X];
for mMiss = 1:size(Xmiss,1)
    mIndex = find(X(r(mMiss,1),:)==15);
    switch(mIndex)
        case 1
            Xcopy(r(mMiss,1),1) = D(1,1);
            Xcopy(r(mMiss,1),mIndex+1) = 0;
            temp = [D(2,1),X(r(mMiss,1),:)];
            temp(1,mIndex+1) = 1;
            Xcopy = [Xcopy;temp];
        case 2
            Xcopy(r(mMiss,1),1) = I(1,1);
            Xcopy(r(mMiss,1), mIndex+1) = 0;
            temp = [I(2,1),X(r(mMiss,1),:)];
            temp(1,mIndex+1) = 1;
            Xcopy = [Xcopy;temp];
        case 3
            Xcopy(r(mMiss,1),1) = G(X(r(mMiss,1),1)+1, X(r(mMiss,1),2)+1,1);
            Xcopy(r(mMiss,1),mIndex+1) = 1;
            temp = [G(X(r(mMiss,1),1)+1, X(r(mMiss,1),2)+1,2),X(r(mMiss,1),:)];
            temp(1,mIndex+1) = 2;
            Xcopy = [Xcopy;temp];
            temp = [G(X(r(mMiss,1),1)+1, X(r(mMiss,1),2)+1,3),X(r(mMiss,1),:)];
            temp(1,mIndex+1) = 3;
            Xcopy = [Xcopy;temp];
        case 4
            Xcopy(r(mMiss,1),1) = S(X(r(mMiss,1),2)+1,1);
            Xcopy(r(mMiss,1),mIndex) = 0;
            temp = [S(X(r(mMiss,1),2)+1,2),X(r(mMiss,1),:)];
            temp(r(mMiss,1),mIndex) = 1;
            Xcopy =[Xcopy;temp] ;
            
        case 5
            Xcopy(r(mMiss,1),1) = L(X(r(mMiss,1),3),1);
            Xcopy(r(mMiss,1),mIndex) = 0;
            temp = [L(X(r(mMiss,1),3),2),X(r(mMiss,1),:)];
            temp(r(mMiss,1),mIndex) = 1;
            Xcopy = [Xcopy;temp];
    end
end

