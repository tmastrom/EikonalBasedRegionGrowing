function [Superpixels] = fastMarchingAlg(Dist, Seeds, State, img, SPs, Superpixels, Seed_map)

% TODO 
% Indexing issue in x direction, img(16,y) not visited 


W = size(img, 1);       % image height
H = size(img, 2);       % image width
heapL = struct('x', 0, 'y', 0, 'label',1 ,'dist', 0);
INF = 100000;   % infinity value 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize the Heap with seeds
length = 1;
num_seeds = size(Seeds, 2);

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

%thresh = 2500; % max difference = 50 values
%thresh = 3600; % max difference = 60 values
%thresh = 1600; % max difference = 40 values    
thresh = 200;

while(size(heapL) ~= 0)
    % pop the minimum item off the Heap
    
    [item, heapL] = sortbystructfield(heapL);
    %fprintf('new item from heap\n');
    
    x = item.x; % x position
    y = item.y; % y position
    n = item.label; % associated seed
    %fprintf('label n: %d \n', n);
    %SPs(n)
    
    % perform threshold operations here
    % make sure if condition is not met disassociate from superpixel  

    % if the point is not COMPUTED
    % point is not fixed 
    if State(x,y) ~= -1      
        % Set State to COMPUTED
        State(x,y) = -1;
        
        % update superpixel values using Eq.5
        Ci = double(SPs(n).meanColour);
        %fprintf('current mean colour %d \n',Ci); 
        Ni = double(SPs(n).count);

        Ci = (Ci*Ni + double(img(x,y)))/(Ni+1); % update mean colour 
        %fprintf('new mean colour %d \n', Ci);
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
        v4x = [-1 0 1 0];   % 4connexity neighbourhood x 
        v4y = [0 1 0 -1];   % 4connexity neighbourhood y
        for m = 1:4
            xx = x+v4x(m);
            yy = y+v4y(m);
%             fprintf('xx = %d \n',xx);
%             fprintf('yy = %d \n',yy);
%             
            % if the pixel is in the image 
            if xx<=W && xx>0 && yy<=H && yy>0
                
                d = computeDistance(double(img(x,y)), double(img(xx,yy)));
                
                % if distance is below threshold add to the heap 
                %(50 grayscale values)
                if d <= thresh               
                    % update heap len value 
                    heap_len = size(heapL, 2);
                    
                    % why is this the same for both cases?
                    if State(xx,yy) == 0
                        % if the new distance is less than the current
                        % distance
                        if d<Dist(xx,yy)
                            
                            Dist(xx,yy) = d;

                            heapL(heap_len +1).x = double(xx);
                            heapL(heap_len +1).y = double(yy);
                            heapL(heap_len +1).label = double(n);

                            %fprintf('dist: %d \n', d)
                            heapL(heap_len +1).dist = double(d);
                            % update superpixel map 
                            Superpixels(xx,yy) = n;
                        end

                    else
                        if State(xx,yy) == 1
                            % add a new point
                            %fprintf('State = 1\n')
                            State(xx,yy) = 0;
                            Dist(xx,yy) = d;
    %                         fprintf('Dist(xx,yy) = %d \n',Dist(xx,yy));
    %                         fprintf('A1 = %d \n',A1);
    %                         fprintf('double(A1) = %d \n',double(A1));
                            heapL(heap_len +1).x = double(xx);
                            heapL(heap_len +1).y = double(yy);
                            heapL(heap_len +1).label = double(n);

                            %fprintf('dist: %d \n', d)
                            heapL(heap_len +1).dist = double(d);

                            Superpixels(xx,yy) = n;
                            %figure(2)
                            %imshow(Superpixels, [], 'InitialMagnification' ,'fit');

                        end

                    end  
                else % distance greater than threshold
                    
                    %disp('distance greater than threshold');
                    % do nothing
                end
          
            end
            
            % live update the state map
            figure(2)  
            imshow(State, [], 'InitialMagnification' ,'fit');
  
        end

    end
    
end
    

mean_map = 256*ones([size(img, 1), size(img, 2)]);
% figure('Name','Superpixels')
% imshow(Superpixels, [1, 12], 'InitialMagnification' ,'fit')


for q = 1:W
    for p = 1:H
        
        ind = Superpixels(q,p);
        %fprintf('index %d\n',ind);
        if ind <= max(size(SPs))
            mean_map(q,p) = uint8(SPs(ind).meanColour);
        else 
            %disp('not associated with a Superpixel')
        end
        
        
    end
end

figure('Name','Mean Colour Map')
imshow(mean_map, [1, 255], 'InitialMagnification' ,'fit');

figure(1)
subplot(2,2,3)
imshow(Superpixels, [1, num_seeds], 'InitialMagnification' ,'fit')
title('Superpixels')

figure(1)
subplot(2,2,4)
Dist = Dist/1e5;
imshow(Dist, [], 'InitialMagnification' ,'fit');
title('Distance Map')

imwrite(mean_map, 'Mean_map.jpg')

% figure('Name','Boundary Overlay')
% BW = boundarymask(Superpixels);
% imshow(imoverlay(img,BW,'cyan'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            