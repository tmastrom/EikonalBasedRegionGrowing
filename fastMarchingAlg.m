function [Superpixels] = fastMarchingAlg(Dist, Seeds, State, img, SPs, Superpixels, Seed_map)

% TODO 
% set superpixels to the seed number 
% make superpixel map corresponding to the seed number 
% at the end of fast marching set all sps in map to the mean value 
W = size(img, 1);       % image height
H = size(img, 2);       % image width
heapL = struct('x', 0, 'y', 0, 'label',1 ,'dist', 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize the Heap with seeds
length = 1;
for k = 1:size(Seeds, 2)
    xs = double(Seeds(k).x);
    ys = double(Seeds(k).y);
    label = double(Seeds(k).label);     % associate n with the seed 

    % init heap struct item and add struct to heapL struct array
    heapL(length).x = xs;
    heapL(length).y = ys;
    heapL(length).label = label;
    heapL(length).dist = double(0);
    
    % is length necessary? just use k?
    length = length + 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main loop 
% while there are items on the heap
while(size(heapL) ~= 0)
    % pop the minimum item off the Heap
    %[x,y,n] = HeapL.pop()
    [item, heapL, len] = sortbystructfield(heapL);
    fprintf('new item from heap\n');
    
    x = item.x; % x position
    y = item.y; % y position
    n = item.label; % associated seed
    fprintf('label n: %d \n', n);
    SPs(n)
    
    % if the point is not COMPUTED or a SEED
    % point is not fixed 
    if State(x,y) ~= -1      
        % Set State to COMPUTED
        State(x,y) = -1;
        
        % update superpixel values using Eq.5
        Ci = double(SPs(n).meanColour);
        fprintf('current mean colour %d \n',Ci); 
        Ni = double(SPs(n).count);

        Ci = (Ci*Ni + double(img(x,y)))/(Ni+1); % update mean colour 
        fprintf('new mean colour %d \n', Ci);
        if Seed_map(x,y) ~= 0   % update count if not a seed
            Ni = Ni + 1; 
        end
        
        SPs(n).meanColour = Ci;
        SPs(n).count = Ni;
        
        % only updates the one pixel at current x,y 
        % need to keep track of all the pixels that are part of a SP
        % turn Superpixels into a cell array?
        Superpixels(x,y) = n; % add pixel to superpixel map with intensity 'label' 

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % investigate 4-conn neighbourhood to find the next closest pixel 
        % if the pixel is in the image 
        if x+1<=W
            right = computeDistance(double(img(x+1,y)), double(Ci));
            fprintf('right %d \n', right)
            closest = 'right';
            d = right;
            xnew = x+1; ynew = y;
        end
        if x-1>0
            left = computeDistance(double(img(x-1,y)), double(Ci));
            fprintf('left %d \n', left)
            if left <= d
                closest = 'left';
                d = left;
                xnew = x-1; ynew = y;
            end
        end      
        if y+1<=H
            up = computeDistance(double(img(x,y-1)), double(Ci));
            fprintf('up %d \n', up)
            if up <= d
                closest = 'up';
                d = up;
                xnew = x; ynew = y-1;
            end
        end
        
        if y-1>0
            down = computeDistance(double(img(x,y+1)), double(Ci));
            fprintf('down %d \n', down)
            if down <= d
                closest = 'down';
                d = down;
                xnew = x; ynew = y+1;
            end
        end
        
        fprintf('the closest direction is %s\n', closest)
        % distance = the next distance
        % closest = the direction of the next closest pixel 
 
        if State(xnew,ynew) == 0    % if its a seed 
            % i dunno what to do here
            fprintf('it was a seed \n')
        end
        
        if State(xnew,ynew) == 0    % if ALIVE
            fprintf('xnew %d \n', xnew);
            fprintf('ynew %d \n', ynew);
            fprintf('length %d \n', len);
            % add to the heap list             
            heapL(len +1).x = double(xnew);
            heapL(len +1).y = double(ynew);
            heapL(len +1).label = double(n);
            fprintf('dist: %d \n', d)
            heapL(len +1).dist = double(d);
            %length = length + 1;
            % update superpixel map 
            Superpixels(xnew,ynew) = n;
            
            %figure()
            %imshow(Superpixels, []);
        end    
    end
    
end   

mean_map = 255*ones([size(img, 1), size(img, 2)]);
imshow(Superpixels, [1, 5])

for q = 1:W
    for p = 1:H
        ind = Superpixels(q,p);
        %fprintf('index %d\n',ind);
        mean_map(q,p) = uint8(SPs(ind).meanColour);
        
    end
end
figure('Name','Mean Colour Map');
imshow(mean_map, []);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            