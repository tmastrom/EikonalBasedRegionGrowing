%Iterates through all files in a directory and converts .dmc file to .png
%Created for coverting dataset to desried format.

dcm_files = dir; %Create structure array of files in current directory
dcm_files(1) = []; %remove first three elements of array
dcm_files(1) = [];
dcm_files(1) = [];
numfiles = length(dcm_files); %number of files
for i = 1:numfiles
    f_name = dcm_files(i).name; % current filename
    Image = uint16(dicomread(f_name)); %current image
    newfilename = f_name(1:end-4); %remove '.dmc' from filename
    imwrite(mat2gray(Image), [newfilename,'.png']); %write to '.png' format
    
end



 