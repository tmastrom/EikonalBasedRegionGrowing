function [Superpixels] = fastMarchingAlg(Dist, Seeds, State, img, SPs, Superpixels, Seed_map)

% TODO 
% set superpixels to the seed number 
% make superpixel map corresponding to the seed number 
% at the end of fast marching set all sps in map to the mean value 
W = size(img, 1);       % image height
H = size(img, 2);       % image width
heapL = struct('x', 0, 'y', 0, 'label',1 ,'dist', 0);
INF = 100000;   % infinity value 

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
        
        
        v4x = [-1 0 1 0];   % 4connexity neighbourhood x 
        v4y = [0 1 0 -1];   % 4connexity neighbourhood y
        for m = 1:4
            xx = x+v4x(m);
            yy = y+v4y(m);
            fprintf('xx = %d \n',xx);
            fprintf('yy = %d \n',yy);
            
            % if the pixel is in the image 
            if xx<W && xx>0 && yy<=H && yy>0
                P = 0;
                for c = 1:255
                    P = P + computeDistance(double(Ci), double(img(xx,yy)));
                end
                fprintf('P = %d \n',P);
                
                a1 = INF;
                if xx<W
                    a1 = Dist(xx+1, yy);
                end 
                if xx>1
                    a11 = Dist(xx-1, yy);
                    if a11 < a1
                        a1 = a11; 
                    end       
                end
                
                a2 = INF;
                if yy<H
                    a2 = Dist(xx, yy+1);
                end
                if yy>1
                    a22 = Dist(xx, yy-1);
                    if a22 < a2
                        a2 = a22;
                    end
                end
                
                if a1 > a2
                    tmp = a1;
                    a1 = a2;
                    a2 = tmp;
                end
                
                A1 = 0;
                if P*P > (a2-a1)*(a2-a1)
                    fprintf('P*P > (a2-a1)^2 \n');
                    delta = 2*P*P-(a2-a1)*(a2-a1);
                    A1 = (a1+a2+sqrt(delta))/2;
                else
                    fprintf('P*P < (a2-a1)^2 \n');
                    A1 = a1 + P;
                end
                
                if State(xx,yy) == 0
                    if A1<Dist(xx,yy)
                        fprintf('State = 0, A1<Dist\n');
                        Dist(xx,yy) = A1;
                        
                        heapL(len +1).x = double(xx);
                        heapL(len +1).y = double(yy);
                        heapL(len +1).label = double(n);
                        
                        %fprintf('dist: %d \n', d)
                        heapL(len +1).dist = double(A1);
                        % update superpixel map 
                        Superpixels(xx,yy) = n;
                    end
                    
                else
                    if State(xx,yy) == 1
                        % add a new point
                        fprintf('State = 1\n')
                        State(xx,yy) = 0;
                        Dist(xx,yy) = A1;
%                         fprintf('Dist(xx,yy) = %d \n',Dist(xx,yy));
%                         fprintf('A1 = %d \n',A1);
%                         fprintf('double(A1) = %d \n',double(A1));

                        heapL(len +1).x = double(xx);
                        heapL(len +1).y = double(yy);
                        heapL(len +1).label = double(n);
                        heapL(len +1).dist = A1;
                        heapL(len +1)
                        Superpixels(xx,yy) = n;
                       
                    end
                    
                end

            end

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
figure('Name','Distance Map');
imshow(Dist, []);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            