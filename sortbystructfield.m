% takes struct array and finds it's minimum value
% returns the minimum item as well as the array with the minimum removed
function [minimum, heapL] = sortbystructfield(A)

for id = 1:length(A)
    fprintf('%d\n',id)
    disp(A(id))
end

Afields = fieldnames(A);
Acell = struct2cell(A);
sz = size(Acell)   

% Convert to a matrix
Acell = reshape(Acell, sz(1), []);      % Px(MxN)

% Make each field a column
Acell = Acell';                         % (MxN)xP

% Sort by 4th field "distance"
Acell = sortrows(Acell, 3)

% Put back into original cell array format
Acell = reshape(Acell', sz);

% Convert to Struct
Asorted = cell2struct(Acell, Afields, 1);

% for id = 1:length(Asorted)
%     fprintf('%d\n',id)
%     disp(Asorted(id))
% end

minimum = Asorted(1);

for i = 2:length(Asorted)
    heapL(i-1) = Asorted(i);
    fprintf('%d\n',i-1)
    disp(heapL(i-1))
end


% delete from array 