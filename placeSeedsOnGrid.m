function [Seeds, seed_img] = placeSeedsOnGrid(img, K)

Seeds = struct('x',0,'y',0,'dist',10000, 'label', 0);      % x coord, ycoord, label: 0 = seed

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

v4x = [-1 0 1 0];   % 4connexity neighbourhood x 
v4y = [0 1 0 -1];   % 4connexity neighbourhood y

n = 1;          % Seeds index Seeds(n)
for y=0:ystrips-1   
    ye = y*yerrperstrip;
    for x=0:xstrips-1   
        xe = x*xerrperstrip;
        
        xs = round(x*step+xoff+xe);
        ys = round(y*step+yoff+ye);
        xn = xs;
        yn = ys;
        
        % check variance of neighbourhood 
        % choose seed to be pixel with lowest 4conn variance
        
        x1 = xs-1; y1 = ys-1; x2 = xs; y2 = ys-1; x3 = xs+1; y3 = ys-1;
        x4 = xs-1; y4 = ys; x5 = xs+1; y5 = ys;
        x6 = xs-1; y6 = ys+1; x7 = xs; y7 = ys+1; x8 = xs+1; y8 = ys+1;
       
        v = [];
        for m = 1:4
            xx = xs+v4x(m);
            yy = ys+v4y(m);
            v = [v img(xx,yy)];
        end
        V = var(double(v));
        
        v1 = [];
        for m = 1:4
            xx = x1+v4x(m);
            yy = y1+v4y(m);
            v1 = [v1 img(xx,yy)];
        end
        V1 = var(double(v1));
        
        v2 = [];
        for m = 1:4
            xx = x2+v4x(m);
            yy = y2+v4y(m);
            v2 = [v2 img(xx,yy)];
        end
        V2 = var(double(v2));
        
        v3 = [];
        for m = 1:4
            xx = x3+v4x(m);
            yy = y3+v4y(m);
            v3 = [v3 img(xx,yy)];
        end
        V3 = var(double(v3));
                
        v4 = [];
        for m = 1:4
            xx = x4+v4x(m);
            yy = y4+v4y(m);
            v4 = [v4 img(xx,yy)];
        end
        V4 = var(double(v4));
        
        v5 = [];
        for m = 1:4
            xx = x5+v4x(m);
            yy = y5+v4y(m);
            v5 = [v5 img(xx,yy)];
        end
        V5 = var(double(v5));
                v6 = [];
        for m = 1:4
            xx = x6+v4x(m);
            yy = y6+v4y(m);
            v6 = [v6 img(xx,yy)];
        end
        V6 = var(double(v6));
   
               v7 = [];
        for m = 1:4
            xx = x7+v4x(m);
            yy = y7+v4y(m);
            v7 = [v7 img(xx,yy)];
        end
        V7 = var(double(v7));
        
             v8 = [];
        for m = 1:4
            xx = x8+v4x(m);
            yy = y8+v4y(m);
            v8 = [v8 img(xx,yy)];
        end
        V8 = var(double(v8));
        
        neigh_variance = [V V1 V2 V3 V4 V5 V6 V7 V8];
        var_min = min(neigh_variance);
        pos = find(neigh_variance == var_min);
        
        if pos == 1
            xn = xs;
            yn = ys;
        end
        if pos == 2
            xn = x1;
            yn = y1;
        end
        
        if pos == 3
            xn = x2;
            yn = y2;
        end
        
        if pos ==4
            xn = x3;
            yn = y3;
       
        end
        
        if pos == 5
            xn = x4;
            yn = y4;
       
        end
        
        if pos == 6
            xn = x5;
            yn = y5;
       
        end
        
        if pos == 7
            xn = x6;
            yn = y6;
       
        end
        
        if pos == 8
            xn = x7;
            yn = y7;
       
        end
        if pos == 9
            xn = x8;
            yn = y8;
       
        end
        
        
        Seeds(n).x = xn;
        Seeds(n).y = yn;
        Seeds(n).dist = 0;
        Seeds(n).label = n; % number the seeds
        
        seed_img(xn, yn) = 0;
        
        n = n + 1;
    end
end

% number of seeds is not equal to K
% 


