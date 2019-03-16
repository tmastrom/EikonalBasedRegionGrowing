function fastMarchingAlg(Dist, Seeds, State, img, SPs, Superpixels)

v4x = [-1 0 1 0];   % 4connexity neighbourhood x 
v4y = [0 1 0 -1];   % 4connexity neighbourhood y
heapL = struct('x', 0, 'y', 0, 'label',0 ,'dist', 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize the Heap with seeds
length = 1;
for k = 1:size(Seeds, 2)
    x = Seeds(k).x;
    y = Seeds(k).y;
    n = Seeds(k).label;     % associate n with the seed 

    % init heap struct item and add struct to heapL struct array
    heapL(length).x = Seeds(k).x;
    heapL(length).y = Seeds(k).y;
    heapL(length).label = Seeds(k).label;
    heapL(length).dist = 0;
    
    length = length + 1;
    
end   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main loop 
% while there are items on the heap
while(size(heapL) ~= 0)
    % pop the minimum item off the Heap
    %[x,y,n] = HeapL.pop()
    [item, heapL] = sortbystructfield(heapL);
    x = item.x; % x position
    y = item.y; % y position
    n = item.n; % associated seed
    
    % if the point is not COMPUTED
    if State(x,y) ~= -1
        % Set State to COMPUTED
        State(x,y) = -1;
        
        % update superpixel values using Eq.5
        Ci = SPs(n).meanColour;
        Ni = SPs(n).count;

        Ci = (Ci*Ni + img(x,y))/(Ni+1); % update mean colour 
        Ni = Ni + 1;                    % update count
        SPs(n).meanColour = Ci;
        SPs(n).count = Ni;
        
        % only updates the one pixel at current x,y 
        % need to keep track of all the pixels that are part of a SP
        % turn Superpixels into a cell array?
        Superpixels(x,y) = Ci;
    end
                
    % investigate 4-conn neighbourhood
    fourcon = img(x,y);
    for m = 1:4
        xx = x+v4x(m);
        yy = y+v4y(m);

        if img(xx,yy)             % if the pixel is in the image 
            q = 0;
            % compute the distance for pixels in the neighbourhood
            q = q + computeDistance(img(xx,yy), SPs(n).meanColour);

            if State(xx,yy)== -1  % if pixel state is -1 NOT COMPUTED
                % add to heapL
                
 
            end
        end
        end   
end
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            