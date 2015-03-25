%hystThresh is for hysterysis and thresholding of non maximal supressed
%image
function hystThreshMag = hystThresh(nonMaxSupressed)
hystThreshMag = nonMaxSupressed;

% thresh1 = 0.3621 ;
% thresh2 = 0.3621/2;
thresh1 = 22;
thresh2 = 100;
% thresh1 = 60;
% thresh2 = 150;
% thresh1 = 0.66*mean2(nonMaxSupressed);
% thresh2 = 1.33*mean2(nonMaxSupressed);

row =  length(nonMaxSupressed(:,1));
col =  length(nonMaxSupressed(1,:));

%pixels higher than thresh2 are surely edge pixels 
%pixels lower than thresh1 are surely non edge pixels

for i = 1:row
    for j = 1:col
        if(nonMaxSupressed(i,j)>thresh2)
            hystThreshMag(i,j)=255;
        end
        
        if(nonMaxSupressed(i,j)<thresh1)
            hystThreshMag(i,j)=0;
        end
        
        
    end
end

%for pixels in between thresh1 to thresh2 hysterysis is being applied
for i = 2:row-1
    for j = 2:col-1
        if(hystThreshMag(i,j)==255)
            if(hystThreshMag(i-1,j-1)>thresh1 && hystThreshMag(i-1,j-1)<thresh2)
                hystThreshMag(i-1,j-1)=255;
            end

            if(hystThreshMag(i-1,j)>thresh1 && hystThreshMag(i-1,j)<thresh2)
                hystThreshMag(i-1,j)=255;
            end

            if(hystThreshMag(i-1,j+1)>thresh1 && hystThreshMag(i-1,j+1)<thresh2)
                hystThreshMag(i-1,j+1)=255;
            end

            if(hystThreshMag(i,j-1)>thresh1 && hystThreshMag(i,j-1)<thresh2)
                hystThreshMag(i,j-1)=255;
            end

            if(hystThreshMag(i,j+1)>thresh1 && hystThreshMag(i,j+1)<thresh2)
                hystThreshMag(i,j+1)=255;
            end

            if(hystThreshMag(i+1,j-1)>thresh1 && hystThreshMag(i+1,j-1)<thresh2)
                hystThreshMag(i+1,j-1)=255;
            end

            if(hystThreshMag(i+1,j)>thresh1 && hystThreshMag(i+1,j)<thresh2)
                hystThreshMag(i+1,j)=255;
            end

            if(hystThreshMag(i+1,j+1)>thresh1 && hystThreshMag(i+1,j+1)<thresh2)
                hystThreshMag(i+1,j+1)=255;
            end
            
        end
      
       
       
        if(hystThreshMag(row+1-i,col+1-j)==255)
            if(hystThreshMag(row+1-(i-1),col+1-(j-1))>thresh1 && hystThreshMag(row+1-(i-1),col+1-(j-1))<thresh2)
                hystThreshMag(row+1-(i-1),col+1-(j-1))=255;
            end

            if(hystThreshMag(row+1-(i-1),col+1-(j))>thresh1 && hystThreshMag(row+1-(i-1),col+1-(j))<thresh2)
                hystThreshMag(row+1-(i-1),col+1-(j))=255;
            end

            if(hystThreshMag(row+1-(i-1),col+1-(j+1))>thresh1 && hystThreshMag(row+1-(i-1),col+1-(j+1))<thresh2)
                hystThreshMag(row+1-(i-1),col+1-(j+1))=255;
            end

            if(hystThreshMag((row+1)-(i),col+1-(j-1))>thresh1 && hystThreshMag((row+1)-(i),col+1-(j-1))<thresh2)
                hystThreshMag((row+1)-(i),col+1-(j-1))=255;
            end

            if(hystThreshMag(row+1-(i),col+1-(j+1))>thresh1 && hystThreshMag(row+1-(i),col+1-(j+1))<thresh2)
                hystThreshMag(row+1-(i),col+1-(j+1))=255;
            end

            if(hystThreshMag(row+1-(i+1),col+1-(j-1))>thresh1 && hystThreshMag(row+1-(i+1),col+1-(j-1))<thresh2)
                hystThreshMag(row+1-(i+1),col+1-(j-1))=255;
            end

            if(hystThreshMag(row+1-(i+1),col+1-(j))>thresh1 && hystThreshMag(row+1-(i+1),col+1-(j))<thresh2)
                hystThreshMag(row+1-(i+1),col+1-(j))=255;
            end

            if(hystThreshMag(row+1-(i+1),col+1-(j+1))>thresh1 && hystThreshMag(row+1-(i+1),col+1-(j+1))<thresh2)
                hystThreshMag(row+1-(i+1),col+1-(j+1))=255;
            end
        end
    end
end
%only to check the border
hystThreshMag(:,1)=0;
hystThreshMag(:,col)=0;
hystThreshMag(1,:)=0;
hystThreshMag(row,:)=0;

end
