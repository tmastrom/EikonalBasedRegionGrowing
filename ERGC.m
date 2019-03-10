% ERGC main function 
% img = input image
% K = number of seeds 

function ERGC(img, K)

Dist = 100000*ones([size(img, 1), size(img, 2)]);   % initialize distance map to FAR_AWAY 

State = -1*ones([size(img, 1), size(img, 2)]);      % intialize State map to -1 FAR AWAY

% place seeds in a regular grid pattern
Seeds = placeSeedsOnGrid(img, K); 
% initialize Distance and State images
[Dist, State] = initializeImages(Seeds, Dist, State);

display(Seeds)

% figure('Name', 'Distance Map2')
% imshow(Dist, [])
% 
% figure('Name', 'State Map2')
% imshow(State, [])


% initialize superpixels
SPs = initializeSuperpixels(img, Seeds, State);

display(SPs)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fast marching algorithm (img, Seeds, Dist, States, SPs, m)
% m is compacity value ??

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





