

function [Seeds, Dist, State] = initializeImages(img, K, Seeds, Dist, State)

W = size(img, 1);       % image height
H = size(img, 2);       % image width
N = W*H;                % total pixels
Sz = W*H/K;             % total number of pixels / number of seeds 
S = round(sqrt(N/K));   % seed interval

SPs = struct('x', 0, 'y', 0, 'meanColour', 0,'isalive', false); 


% find the mod of dividing the image by S to center the seeds 
rem = mod(size(img, 1),S);
if rem == 0
    rem = S;
else
    rem = round(rem/2);
end

% initialize images %%%%%%%%%%%%%%%%%%%%%%

for i = rem:S:size(img, 1)-5    
    for j = rem:S:size(img, 2)-5
        Seeds(i,j) = 0;     % sets seeds pixel to 1 for visibility   
        Dist(i,j) = 0;      % Geodesic distance to seed = 0 
        State(i,j) = 0;     % seed state = ALIVE
    end
end

k = 1;
while k <= K
    
    
    
    
    i++


