% fast marching algorithm 
% inputs 
% img = image matrix
% SPs = superpixels vector  

function fastMarch(Dist, Seeds, State, img, SPs, Superpixels)

% initialize heap of ALIVE points
HeapL = MinHeap(size(Seeds, 2));   %maximum elements is the number of seeds

% for all p in img
%   if p is a seed
%       state = ALIVE, Dist = 0, add p to HeapL
%   else 
%       state= FAR, Dist = inf
%   end
% end

for i=1:size(Seeds, 2)
    % add keys to list, should be sorted by Dist value but also
    % need x,y coords 
    % modify heap to handle structs and sort by Dist
    HeapL.InsertKey(); 
end
HeapL.Sort();

bool ok = false;
while(ok == false)
% pop point off the heap (root)
% pt = x,y
% if State is not fixed 
% if State(x,y) != -1
%   State(x,y) = 1 
%   update mean colour
%   investigate neighbourhood (see init superpixels)
    pt = HeapL.ExtractMin();
    x = pt.x;
    y = pt.y;
    
    fourcon = img(x,y);
    for m = 1:4
       xx = x+v4x(m);
       yy = y+v4y(m);
       if xx <= W && xx > 0 && yy > 0 && yy <= H
           P = 0;
           P = P + distanceAbs(SPs(k).meanColour, img(xx,yy));
           % how to relate point on heap to SPs????
           % combine all attributes into 1 struct?
       end
       
end




