% ERGC main function 
% img = input image
% K = number of seeds 

function ERGC(img, K)
% initialize distance map to very far
figure('Name', 'Input')
imshow(img, [])
W = size(img, 1);       % image height
H = size(img, 2);       % image width

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize seeds in a grid 
[Seeds, Seed_map] = placeSeedsOnGrid(img, K); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize Distance and State images
Dist_map = 100000*ones([size(img, 1), size(img, 2)]);   

% State map
% -1 = COMPUTED
% 0 = ALIVE
% 1 = NOT COMPUTED
State_map = ones([size(img, 1), size(img, 2)]);      

[Dist_map, State_map] = initializeImages(Seeds, Dist_map, State_map);
%display(Seeds)
%figure('Name','Dist')
%imshow(Dist_map, [])
%figure('Name','State')
%imshow(State_map, [])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize superpixels
Superpixels = ones([size(img, 1), size(img, 2)]);
[SPs, Superpixels] = initializeSuperpixels(img, Seeds, State_map, Superpixels);
% display(SPs)
figure('Name', 'Superpixels')
imshow(Superpixels)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
superpixel_map = fastMarchingAlg(Dist_map, Seeds, State_map, img, SPs, Superpixels, Seed_map);
%figure('Name','Fast Marching Output')
%imshow(superpixel_map, []);


        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%