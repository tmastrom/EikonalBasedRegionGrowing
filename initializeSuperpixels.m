
function [SPs, Superpixels] = initializeSuperpixels(img, Seeds, State, Superpixels)

v4x = [-1 0 1 0];   % 4connexity neighbourhood x 
v4y = [0 1 0 -1];   % 4connexity neighbourhood y

% xs,ys is the associated seed location
SPs = struct('x',[], 'y', [], 'meanColour', [], 'count', [], 'label',[]); 

% compute meanColour based on 4 connexity neighbourhood

% create a vector of superpixels from the seeds 
for k=1:size(Seeds, 2)
    
   x = Seeds(k).x;
   y = Seeds(k).y;
   State(x,y) = -1;     % set state of the seed to COMPUTED
   SPs(k).x = x;
   SPs(k).y = y;
   SPs(k).count = 1;
   SPs(k).label = Seeds(k).label;   % links a superpixel to its seed 
   
%    display(x)
%    display(y)
   fourcon = img(x,y);
   for m = 1:4
       xx = x+v4x(m);
       yy = y+v4y(m);
       if img(xx,yy)             % if the pixel is in the image 
           if State(xx,yy)~= -1  % if pixel state is not -1 = computed
               fourcon = [fourcon img(xx,yy)];
               SPs(k).count = SPs(k).count + 1; % increase count 
           end
       end
   end
   SPs(k).meanColour = mean(fourcon); 
   Superpixels(x,y) = k;
end


end


% return SPs 