X = load('mnist_all.mat');
T = input('input a string as ''testX'' where X is the digit \nfor which original data is displayed? \n');

test = X.(T);
 rows = ceil(sqrt(size(test,1)));
 for j=1:rows
    if(j==1)
        zzzz=[]; 
    end
    for i=1:rows
        if(rows*(j-1)+i<= size(test,1))
            z(i,:) = test(rows*(j-1)+i,:);
        else
            z(i,:)=0;
        end
        zz = reshape(z(i,:),28,28)';
        if (i==1)
            zzz =[];
        end
        zzz = [zzz;zz];
    end
zzzz = [zzzz zzz];
end
imshow(zzzz);