% ERGC main function 
% img = input image
% K = number of seeds 

function ERGC(img, K)
% initialize distance map to very far
figure('Name', 'Input')
imshow(img, [])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize seeds in a grid 
Seeds = placeSeedsOnGrid(img, K); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize Distance and State images
Dist = 100000*ones([size(img, 1), size(img, 2)]);   

% State map
% -1 = FAR
% 0 = ALIVE
% 1 = COMPUTED
State = -1*ones([size(img, 1), size(img, 2)]);      

[Dist, State] = initializeImages(Seeds, Dist, State);
display(Seeds)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize superpixels
Superpixels = zeros([size(img, 1), size(img, 2)]);
[SPs, Superpixels] = initializeSuperpixels(img, Seeds, State, Superpixels);
% display(SPs)
figure('Name', 'Superpixels')
imshow(Superpixels)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fastMarch(Dist, Seeds, State, img, SPs, Superpixels)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





