% ERGC main function 
% img = input image
% K = number of seeds 

function ERGC(img, K)
% initialize distance map to very far
Dist = 100000*ones([size(img, 1), size(img, 2)]);   
% State map
% -1 = FAR
% 0 = ALIVE
% 1 = COMPUTED
State = -1*ones([size(img, 1), size(img, 2)]);      



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
% fastMarch(Dist, Seeds, State, img, SPs)
% m is compacity value ??

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





