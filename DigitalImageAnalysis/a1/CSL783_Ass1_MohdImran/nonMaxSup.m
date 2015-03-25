%non maximal supression
function SuppressedGmag =nonMaxSup(Gmag,Gdir)
SuppressedGmag = Gmag;

rows = length(Gmag(:,1));
cols = length(Gmag(1,:));

for i = 2:rows-1
    for j = 2:cols-1
        switch (Gdir(i,j))
            case 0
                if(Gmag(i,j)<Gmag(i,j-1) || Gmag(i,j) < Gmag(i,j+1))
                    SuppressedGmag(i,j)=0;
%                     disp('gdir is 0');
                end
                
            case 45
                if(Gmag(i,j)<Gmag(i+1,j-1) || Gmag(i,j) < Gmag(i-1,j+1))
                    SuppressedGmag(i,j)=0;
                end
                
            case 90
                if(Gmag(i,j)<Gmag(i-1,j) || Gmag(i,j) < Gmag(i+1,j))
                    SuppressedGmag(i,j)=0;
                end
                
            case 135
                if(Gmag(i,j)<Gmag(i-1,j-1) || Gmag(i,j) < Gmag(i+1,j+1))
                    SuppressedGmag(i,j)=0;
                end
        end
    end
end

end