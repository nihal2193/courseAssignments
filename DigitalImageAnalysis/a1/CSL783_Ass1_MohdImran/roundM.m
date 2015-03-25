%rounding the directinos obtained from the sobel filter to 0 45 90 135 degrees.
function RoundedDir=roundM(Mdir)
rows = length(Mdir(:,1));
cols = length(Mdir(1,:));
Tdir = Mdir;
for i= 1:rows
    for j= 1:cols
      
          if(Mdir(i,j)>=-180 && Mdir(i,j)<-157.5)
          Tdir(i,j)=0;  
          end
          
           if(Mdir(i,j)>=-157.5 && Mdir(i,j)<-112.5)
          Tdir(i,j)=45;  
           end
           
           if(Mdir(i,j)>=-112.5 && Mdir(i,j)<-67.5)
          Tdir(i,j)=90;  
           end
           
           if(Mdir(i,j)>=-67.5 && Mdir(i,j)<-22.5)
          Tdir(i,j)=135;
           end
           
          if(Mdir(i,j)>=-22.5 && Mdir(i,j)<22.5)
          Tdir(i,j)=0;
          end
          
           if(Mdir(i,j)>=22.5 && Mdir(i,j)<67.5)
          Tdir(i,j)=45;  
           end
           
           if(Mdir(i,j)>=67.5 && Mdir(i,j)<112.5)
          Tdir(i,j)=90;  
           end
           
           if(Mdir(i,j)>=112.5 && Mdir(i,j)<157.5)
          Tdir(i,j)=135;  
           end
           
          if(Mdir(i,j)>=157.5 && Mdir(i,j)<=180)
          Tdir(i,j)=0;  
          end
    end
end
RoundedDir=Tdir;
end
