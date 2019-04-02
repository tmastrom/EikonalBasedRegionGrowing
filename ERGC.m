% ERGC main function 
% img = input image
% K = number of seeds 

function ERGC(img, K)

close all

W = size(img, 1);       % image height
H = size(img, 2);       % image width

figure('Name','Input Image')
imshow(img, [], 'InitialMagnification' ,'fit')

[yi, xi] = getpts;
xi = int8(xi);
yi = int8(yi);


% initialize seeds in a grid 
% [Seeds, Seed_map] = placeSeedsOnGrid(img, K); 
Seeds = struct('x',xi,'y',yi,'dist',0, 'label', 1);      % x coord, ycoord, label: 0 = seed
Seed_map = -1*ones([size(img, 1), size(img, 2)]); 
Seed_map(xi,yi) = 0;


% initialize Distance and State images
Dist_map = 100000*ones([W, H]);   
% State map
% -1 = COMPUTED
% 0 = ALIVE
% 1 = NOT COMPUTED
State_map = ones([size(img, 1), size(img, 2)]);    
Dist_map(xi,yi) = 0;  % Geodesic distance to seed = 0 
State_map(xi,yi) = 0; % 0 = ALIVE, 1 = FAR AWAY, -1 = COMPUTED
%[Dist_map, State_map] = initializeImages(Seeds, Dist_map, State_map);


% initialize superpixels
Superpixels = 255*ones([size(img, 1), size(img, 2)]);
[SPs, Superpixels] = initializeSuperpixels(img, Seeds, State_map, Superpixels);

% fast marching algorithm
fastMarchingAlg(Dist_map, Seeds, State_map, img, SPs, Superpixels, Seed_map);


       