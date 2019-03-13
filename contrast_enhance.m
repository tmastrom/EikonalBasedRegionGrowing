function J = contrast_enhance(I)
%This function takes a gray-scale image (I) and performs various contrast
%enhancement techniques to obtain the output image (J)
%Displays original image (I), enhanced image (J) and the corresponding histograms
%Measurements are performed for MSE and PSNR using I as a reference

I = mat2gray(I);

%Display Histogram of Original Image
figure(1)
imhist(I)
title('Histogram of Original Image')

%Display Original Image
figure(2)
imshow(I)
title('Original Image')

%Contrast Adjustment
J = imadjust(I);

%Display enhanced image
figure(3)
imshow(J)
title('Image After Contrast Enhancement')

%Noise Measurements
imadjust_mse = immse(I,J);
imadjust_psnr = psnr(J,I);

%Display histogram of enhanced image
figure(4)
imhist(J)
title('Histogram of Image After Contrast Enhancement')

%Histogram Equalization
J_histeq = histeq(I,256);

%Histogram after equalization
figure(5)
imhist(J_histeq)
title('Histogram of Image After Histogram Equalization')

%Display Image after histogram equalization
figure(6)
imshow(J_histeq)
title('Image After Histogram Equalization')

%Noise Measurements
histeq_mse = immse(I,J_histeq);
histeq_psnr = psnr(J_histeq,I);


%After Median Filtering
%Jf = medfilt2(J_histeq);
%figure(99)
%imshow(Jf)
%title('Image After Median Filtering')

%filt_psnr = psnr(Jf,I);
%filt_mse = immse(I,Jf);


%Contrast-limited adaptive histogram equalization
J_adapthisteq = adapthisteq(I);

%Histogram after adaptive equalization
figure(7)
imhist(J_adapthisteq)
title('Histogram of Image After Contrast-Limited Adaptive Histogram Equalization')

%Display image after adaptive histogram equalization
figure(8)
imshow(J_adapthisteq)
title('Image After Contrast-Limited Adaptive Histogram Equalization')

adapthisteq_mse = immse(I,J_adapthisteq);
adapthisteq_psnr = psnr(J_adapthisteq,I);

%imadjust() & then adapthisteq()
Jnew = adapthisteq(J);
figure(9)
imshow(Jnew)
title('imadjust() & then adapthisteq()')

figure(10)
imhist(Jnew)
title('imadjust() & then adapthisteq')

%Noise Measurements
mse1 = immse(I,Jnew);
psnr1 = psnr(Jnew,I);

%adapthisteq() & then imadjust()
J2 = imadjust(J_adapthisteq);
figure(11)
imshow(J2)
title('adapthisteq() & then imadjust()')

figure(12)
imhist(J2)
title('adapthisteq() & then imadjust()')

mse2 = immse(I,J2);
psnr2 = psnr(J2,I);

%Binarized Image
%level = graythresh(I);
%BW = imbinarize(I,level);
%imshowpair(I,BW,'montage')

end





