filename = 'digitdata.txt';
urlname = ['file:///' fullfile(pwd,filename)];
try
    str = urlread(urlname);
catch err
    disp(err.message)
end


strM = strsplit(str,'\n');

pixel = strsplit(strrep(strrep(strM{1,1}(1,:),'"pixel',''),'"',''),' ');
pixel = cellfun(@str2num,pixel)';

img1 = zeros(1,784);
correctInput = 'false';
while(strcmp(correctInput,'false')==1) 
    eIndex = input('input Example Index in between 2 to 1001:\n');
    if(eIndex<1002 && eIndex>1)
        correctInput = 'true';
    end
end
val = strsplit(strM{1,eIndex}(1,4:end),' ');
val = cellfun(@str2num,val(1,2:end));
val = val';

img1(1,pixel)=val;

img1 = reshape(img1,[28,28]);
imshow(img1');




