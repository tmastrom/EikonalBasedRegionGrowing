% ERGC main function 
% img = input image
% K = number of seeds 

function ERGC(img, K)

Seeds = -1*ones([size(img, 1), size(img, 2)]);      % initialize seeds img 
Dist = 100000*ones([size(img, 1), size(img, 2)]);   % initialize distance map to FAR_AWAY 
State = -1*ones([size(img, 1), size(img, 2)]);      % intialize State map to -1 FAR AWAY

Seeds = placeSeedsOnGrid(img, K);

[Seeds, Dist, State] = initialize_images(img, K, Seeds, Dist, State);

figure('Name', 'Seeds')
imshow(Seeds, [])

figure('Name', 'Distance Map')
imshow(Dist, [])

figure('Name', 'State Map')
imshow(State, [])


% initialize superpixels
SPs = initialize_superpixels(img, Seeds);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fast marching algorithm (img, Seeds, Dist, States, SPs, m)
% m is compacity value ??

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





