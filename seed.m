% Initialize K seeds in a regular grid
% interval S = sqrt(N/K), N = pixels in image

function seed(K, img) 

figure()
imshow(img, [0,255])    % display the image

seeds = zeros([size(img, 1), size(img, 2)], 'uint8');   % initialize sees img

N = size(img, 1)*size(img, 2);    % total image pixels 

S = round(sqrt(N/K));      % seed interval
display(S)

% find the mod of dividing the image by S to center the seeds 
rem = mod(size(img, 1),S);
if rem == 0
    rem = S;
else
    rem = round(rem/2);
end

%initialize seeds 
for i = rem:S:size(img, 1)-5    
    for j = rem:S:size(img, 2)-5
        seeds(i,j) = img(i,j);
    end
end

figure()
imshow(seeds)


% The mean and variance color of the seed pixel and its 4-connexity neigh-
% boring pixels is then computed. The same computation is performed for
% pixels that lie in a 3 × 3 neighborhood, and the seed is moved to the pixel
% that lowers the variance color. Such a perturbation of the initial seeds avoids
% potential outlier pixels as seeds, favorably initializes the diffusion, and gives
% a more robust initial mean color for each superpixel.



