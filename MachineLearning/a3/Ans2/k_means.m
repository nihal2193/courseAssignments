%k=4 means clustering for digit recognition

filename = 'digitdata.txt';
urlname = ['file:///' fullfile(pwd,filename)];
tic;
try
    str = urlread(urlname);
catch err
    disp(err.message)
end

strM = strsplit(str,'\n');

pixel = strsplit(strrep(strrep(strM{1,1}(1,:),'"pixel',''),'"',''),' ');
pixel = cellfun(@str2num,pixel)';

X = zeros(1000,157);

%for calculation of y
filename = 'digitlabels.txt';
urlname = ['file:///' fullfile(pwd,filename)];
try
    str = urlread(urlname);
catch err
    disp(err.message)
end

labelM = strsplit(str,'\n');
digitLabel = zeros(1000,2);
for index = 2:1001
    labels = labelM{1,index};
    labels = strsplit(strrep(labels,'"',''),' ');
    digitLabel(index-1,:) = cellfun(@str2num,labels)';
end
Y = digitLabel;

for eIndex = 2:1001
    val = strsplit(strM{1,eIndex}(1,4:end),' ');
    val = cellfun(@str2num,val(1,2:end));
    X(eIndex-1,:)=val;
end

m = size(X,1);
%normalized X
%XN = (X - min(X(:)))/(max(X(:)) - min(X(:)));

%experimental determination of mu's
% mu = [
%     XN(5,:);
%     XN(6,:);
%     XN(2,:);
%     XN(4,:)
%     ];

%select four random rows
for trials = 1:5
randN = randperm(m);
mu = [X(randN(1,1),:);X(randN(1,2),:);X(randN(1,3),:);X(randN(1,4),:)];
     
%clusters c for every example
%they will have values from 1 to 4
c = zeros(1000,1);
iter = 1;
figure
hold on
error = zeros(30,1);
while(iter < 30)
    
    iter
    S = 0;
    for index = 1:1000
        argmin = [norm(X(index,:)- mu(1,:)),norm(X(index,:)- mu(2,:)),norm(X(index,:)- mu(3,:)),norm(X(index,:)- mu(4,:))];
        argminIndex = find(argmin==min(argmin));
        c(index) = argminIndex(1,1);
        S = S + min(argmin)^2 ; 
    end
    
    
    plot(iter,log(S),'-ro');
    
    %cluster indices
    cIndex1 = find(c==1);
    cIndex2 = find(c==2);
    cIndex3 = find(c==3);
    cIndex4 = find(c==4);
    
    mu= [
        mean(X(cIndex1,:));
        mean(X(cIndex2,:));
        mean(X(cIndex3,:));
        mean(X(cIndex4,:));
        ];
   
    
    %cost function
    
   c1 = mode(Y(cIndex1,2));
   c2 = mode(Y(cIndex2,2));
   c3 = mode(Y(cIndex3,2));
   c4 = mode(Y(cIndex4,2));
    
   e1 = size(find(Y(cIndex1,2)~=c1),1);
   e2 = size(find(Y(cIndex2,2)~=c2),1);
   e3 = size(find(Y(cIndex3,2)~=c3),1);
   e4 = size(find(Y(cIndex4,2)~=c4),1);
   
   error(iter,:) = (e1+e2+e3+e4)/10;
   
   iter = iter + 1;
end
hold off;
figure
hold on
plot(1:1:20,error(1:20,:),'-r*');
toc;
end