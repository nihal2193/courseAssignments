%following 2 lines taken from stackoverflow

filename = '20ng-rec_talk.txt';
urlname = ['file:///' fullfile(pwd,filename)];
try
    str = urlread(urlname);
catch err
    disp(err.message)
end


strM = strsplit(str,'\n');
n = size(strM,2);
Xtext = cell(n,1);
dict =[];
%last line is empty
for i=1:n-1
    
    Xtext{i,1} = strsplit(strM{1,i},' ');
    tempstr = Xtext{i,1}(1,1);
    temp = strsplit( tempstr{1},'\t');
    Xtext{i,1}(1,1) = temp(1,2);
    dict = [dict Xtext{i,1}];
    i
end

dict = unique(dict);
X = cell(n-1,1);
for j = 1:n-1
    rowl = size(Xtext{j,1},2);
    %X = zeros(1,rowl);
    for i=1:rowl
        index = find(ismember(dict,Xtext{j,1}(1,i)));
        X{j} = [X{j} {index}];
    end
    j
end


