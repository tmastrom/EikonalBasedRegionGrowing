% Initialize K seeds in a regular grid
% interval S = sqrt(N/K), N = pixels in image

function seed(K, img) 

figure()
imshow(img, [0,255])    % display the image

seeds = zeros([size(img, 1), size(img, 2)], 'uint8');   % initialize sees img

N = size(img, 1)*size(img, 2);    % total image pixels 

S = round(sqrt(N/K));      % seed interval
%display(S)

% find the mod of dividing the image by S to center the seeds 
rem = mod(size(img, 1),S);
if rem == 0
    rem = S;
else
    rem = round(rem/2);
end

%initialize seeds 
% be aware of edge neighbourhoods!
for i = rem:S:size(img, 1)-5    
    for j = rem:S:size(img, 2)-5

        % 4-conexity neighbourhood of img(i,j)
        fourcon = [img(i-1,j) img(i+1,j) img(i,j+1) img(i,j-1) img(i,j)];
        m4 = mean(fourcon);    
        v4 = var(fourcon);
        
        % 4 connexity  neighbourhood padded with 0s for visualization
        con4 = [ 0          img(i,j+1)   0
                img(i-1,j)  img(i,j)     img(i+1,j)
                0           img(i, j-1)  0];
        display(con4)
        display(m4)
        display(v4)
         
        % 3x3 neighbourhood
        threeby = [ img(i-1,j+1)    img(i,j+1)   img(i+1,j+1)
                    img(i-1,j)      img(i,j)     img(i+1,j)
                    img(i-1,j-1)    img(i, j-1)  img(i+1,j-1)];
                
        m3 = mean(threeby);    
        v3 = var(threeby);
        
        display(threeby)
        display(m3)
        display(v3)
        
        seeds(i,j) = img(i,j);  % sets seeds pixel to value of img pixel
       
    end
end

figure()
imshow(seeds)




