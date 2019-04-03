# Eikonal Based Region Growing 
Repository for ECE 435 Medical Image Processing final project. 

![image](erg_bladder.gif)

This program grows superpixel regions based on a weight function describing the distance between pixel intensity values

# Running the Program 

*1. Call the function ERGC(img, T)* 

- img is a square grayscale image as a matrix
- T is the threshold value for the weight function 
- A good starting value for T is around 200

*2. Select your starting seed* 

- Your image will appear in a figure window, this is where you choose your seed by clicking on a spot in your image and hitting enter
- The program will now run to completion and display the final region boundaries


