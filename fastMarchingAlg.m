function [Superpixels] = fastMarchingAlg(Dist, Seeds, State, img, SPs, Superpixels, Seed_map)

INF = 100000;           % infinity value 
W = size(img, 1);       % image height
H = size(img, 2);       % image width

thresh = 200;       % TODO make this a parameter to be chosen by user


% Initialize the Heap with seeds

heapL = struct('x', 0, 'y', 0, 'label',1 ,'dist', 0);

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

    length = length + 1;
end
% end heap initialization

%
% main loop 
%  
while(size(heapL) ~= 0)
    
    % pop the minimum item off the Heap
    [item, heapL] = sortbystructfield(heapL);
    
    x = item.x; % x position
    y = item.y; % y position
    n = item.label; % associated seed

    if State(x,y) ~= -1   % if the point is not COMPUTED yet   
        State(x,y) = -1;    % Set State to COMPUTED
        
        % update superpixel values using Eq.5
        Ci = double(SPs(n).meanColour); % mean colour of the region
        Ni = double(SPs(n).count);      % num pixels in region
        Ci = (Ci*Ni + double(img(x,y)))/(Ni+1); % update mean colour 
        if Seed_map(x,y) ~= 0   % update count if not a seed
            Ni = Ni + 1; 
        end
        
        % update superpixel values
        SPs(n).meanColour = Ci;
        SPs(n).count = Ni;
        % add pixel to superpixel map with intensity 'label'
        Superpixels(x,y) = n; 

 
        % investigate 4-conn neighbourhood to find the next closest pixel         
        v4x = [-1 0 1 0];   % 4connexity neighbourhood x 
        v4y = [0 1 0 -1];   % 4connexity neighbourhood y
        
        for m = 1:4
            xx = x+v4x(m);
            yy = y+v4y(m);
            
            % check if the pixel is in the image 
            if xx<=W && xx>0 && yy<=H && yy>0
                
                % compute the weight function (see Eq. 3)
                c1 = double(img(x,y));
                c2 = double(img(xx,yy));
                d = (c1 - c2)*(c1 - c2);
                
                % if distance is below threshold add to the heap 
                if d <= thresh               
                    % update heap len value 
                    heap_len = size(heapL, 2);

                    if State(xx,yy) == 0         
                        if d<Dist(xx,yy)
                            % update distance
                            Dist(xx,yy) = d;
                            % add point to the heap
                            heapL(heap_len +1).x = double(xx);
                            heapL(heap_len +1).y = double(yy);
                            heapL(heap_len +1).label = double(n);
                            heapL(heap_len +1).dist = double(d);
                            % update superpixel map 
                            Superpixels(xx,yy) = n;
                        end

                    else
                        % first time this point has been visited 
                        % initialize this point on maps and heap
                        if State(xx,yy) == 1
                            % update State and Distance maps with new point
                            State(xx,yy) = 0;
                            Dist(xx,yy) = d;
                            % add point to the heap
                            heapL(heap_len +1).x = double(xx);
                            heapL(heap_len +1).y = double(yy);
                            heapL(heap_len +1).label = double(n);
                            heapL(heap_len +1).dist = double(d);
                            % update superpixel map 
                            Superpixels(xx,yy) = n;                           
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
% end main loop 

    
%
% Create the Mean Colour Map
% fill superpixel regions based on their mean colour value
%
mean_map = 255*ones([size(img, 1), size(img, 2)]);

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

% display the mean map figure
figure('Name','Mean Colour Map')
imshow(mean_map, [1, 255], 'InitialMagnification' ,'fit');

% overlay the segmented boundary on the input image 
img = mat2gray(img);
figure('Name','Boundary Overlay')
%BW2 = boundarymask(mean_map);
BW = imbinarize(mean_map, 250);
BW1 = imcomplement(BW);
BW2 = bwperim(BW1, 8);
imshow(imoverlay(img,BW2,'cyan'),'InitialMagnification' ,'fit');
% end

            