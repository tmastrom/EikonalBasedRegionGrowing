
function SPs = initializeSuperpixels(img, Seeds, State)

v4x = [-1 0 1 0];   % 4connexity neighbourhood x 
v4y = [0 1 0 -1];   % 4connexity neighbourhood y

SPs = struct('x', 0, 'y', 0, 'meanColour', 0); 
% compute meanColour based on 4 connexity neighbourhood

% create a vector of superpixels from the seeds 
for k=1:size(Seeds, 2)
    
   x = Seeds(k).x;
   y = Seeds(k).y;
   
   SPs(k).x = x;
   SPs(k).y = y;
   
%    display(x)
%    display(y)
   
   fourcon = img(x,y);
   for m = 1:4
       xx = x+v4x(m);
       yy = y+v4y(m);
       if img(xx,yy)             % if the pixel is in the image 
           if State(xx,yy)== -1  % if pixel state is not -1 Far Away
               fourcon = [fourcon img(xx,yy)];
           end
       end
   end
   SPs(k).meanColour = mean(fourcon);   
end
    
end


% return SPs 