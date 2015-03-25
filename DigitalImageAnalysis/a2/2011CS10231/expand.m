function [G_expand] = expand (toExpand)

I = toExpand;



G = im2double(I);

a = 0.375;

gaussian_kernel1D = [1/4-a/2,1/4,a,1/4,1/4-a/2];

%gaussian filter kernel
w = 4*kron(gaussian_kernel1D, gaussian_kernel1D');

rows_expand = 2*size(G,1)-1;
cols_expand = 2*size(G,2)-1;

G_expand = zeros(rows_expand(1,1), cols_expand(1,1), size(G,3));

%4 kernels for odd and even combinations

wee = w(1:2:size(w,1), 1:2:size(w,2)); %3X3 for even even 
weo = w(1:2:size(w,1), 2:2:size(w,2)); %3X2 for even odd
woe = w(2:2:size(w,1), 1:2:size(w,2)); %2X3 for odd even
woo = w(2:2:size(w,1), 2:2:size(w,2)); %2X2 for odd odd



for i = 3:rows_expand
    for j = 3:cols_expand
        for color = 1:size(G,3)
%             G_(:,:,1) = G(:,:,1);
     
            %odd row and odd column
            if( mod(i,2)~=0 && mod(j,2)~= 0)
                moo = [-1,1];
                noo = [-1,1];
                for m = 1:size(woo,1)
                    for n = 1:size(woo,2)
                        G_expand(i,j,color) = G_expand(i,j,color) + woo(m,n)*G((i-moo(1,m))/2 , (j-noo(1,n))/2, color);
                    end
                end
           
            
            %odd row and even column
            elseif( mod(i,2)~=0 && mod(j,2)== 0)
                moe = [-1, 1];
                noe = [-2, 0, 2];
                 for m = 1:size(woe,1)
                    for n = 1:size(woe,2)
                        G_expand(i,j,color) = G_expand(i,j,color) + woe(m,n)*G((i-moe(1,m))/2 , (j-noe(1,n))/2, color);
                    end
                end
                
           

            
            %even row and odd column
            elseif( mod(i,2)==0 && mod(j,2)~= 0)
                meo = [-2, 0, 2];
                neo = [-1,1];
                 for m = 1:size(weo,1)
                    for n = 1:size(weo,2)
                        G_expand(i,j,color) = G_expand(i,j,color) + weo(m,n)*G((i-meo(1,m))/2 , (j-neo(1,n))/2, color);
                    end
                end
           
            
            %even row and even column
            elseif( mod(i,2)==0 && mod(j,2)== 0)
                mm = [-2, 0, 2];
                nn = [-2, 0, 2];
                 for m = 1:size(wee,1)
                    for n = 1:size(wee,2)
                        G_expand(i,j,color) = G_expand(i,j,color) + wee(m,n)*G((i-mm(1,m))/2 , (j-nn(1,n))/2, color);
                    end
                end
            end


            
        end
    end
end