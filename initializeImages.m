
function [Dist, State] = initializeImages(Seeds, Dist, State)

for i=1:size(Seeds, 2)
    x = Seeds(i).x;
    y = Seeds(i).y;
    
    Dist(x,y) = 0;  % Geodesic distance to seed = 0 
    State(x,y) = 0; % 0 = ALIVE, 1 = COMPUTED, -1 = FARAWAY
end

