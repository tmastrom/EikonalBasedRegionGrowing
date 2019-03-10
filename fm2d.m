% fast marching algorithm 
% inputs 
% img = image matrix
% SPs = superpixels vector  

function fm2d(img, SPs)

W = size(img, 1);   % image height
H = size(img, 2);   % image width
inf = 100000;       % infinity (large enough)

v4x = [-1 0 1 0];   % 4connexity neighbourhood x 
v4y = [0 1 0 -1];   % 4connexity neighbourhood y

Sz = W*H/SPs;        % total number of pixels / number of seeds 

% initialize heap of ALIVE points
HeapL = MinHeap(SPs);   %maximum elements is the number of seeds

% add seeds to heap with tag ALIVE

for i = 1:W
    for j = 1:H
        % if p(i,j) is in SPs then add to the heap
    end
end

fmm2d(distances, seeds, states, im, SPs, m);

py.dict(pyargs('Robert',357,'Mary',229,'Joe',391))

    // call to initialize_images function that initializes :
    // - distances image
    // - states image