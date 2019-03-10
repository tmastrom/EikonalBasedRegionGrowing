function [Seeds] = placeSeedsOnGrid(img, K)

Seeds = struct('x',0,'y',0,'dist',-1,'state',-1);      % x coord, ycoord, label: 0 = seed

% initialize seeds img 
seed_img = -1*ones([size(img, 1), size(img, 2)]); 

W = size(img, 1);       % image height
H = size(img, 2);       % image width

k = floor(sqrt(K));
K = k^2;

superpixelsize = (W*H)/K;
step = sqrt(superpixelsize);

xstrips = W/step;
ystrips = H/step;
xerr = W - step*xstrips;
yerr = H - step*ystrips;

if xerr < 0
    xstrips =  xstrips - 1;
    xerr = W-step*xstrips;
end

if yerr < 0
    ystrips = ystrips - 1;
    yerr = H-step*ystrips;
end

xerrperstrip = xerr/xstrips;
yerrperstrip = yerr/ystrips;

xoff = step/2;
yoff = step/2;

if step > W/2
    xoff = W/2;
end
if step > H/2
    yoff = W/2;
end

n = 1;          % Seeds index Seeds(n)
for y=0:ystrips-1   
    ye = y*yerrperstrip;
    for x=0:xstrips-1   
        xe = x*xerrperstrip;
        seed_img(round(x*step+xoff+xe),round(y*step+yoff+ye)) = 0;
        Seeds(n).x = round(x*step+xoff+xe);
        Seeds(n).y = round(y*step+yoff+ye);
        n = n + 1;
    end
end

% number of seeds is not equal to K
% 
figure('Name', 'Seed Img')
imshow(seed_img, [])

%display(Seeds)

