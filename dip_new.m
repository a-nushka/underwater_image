clc;
 clear all;
% Load the underwater image
underwaterImage = imread('galdran1_input.jpg');


% Convert the image to double precision for processing
underwaterImage_DP = im2double(underwaterImage);


disp("IMAGE OPERATIONS \n 1.Basic Dehazing \n 2..Sharpened & Color Adjusted Image \n 3.Color Corrected Image \n4.End")
continueloop=true;
while continueloop
n=input("Enter choice:");
switch n
    case 1

% Apply a basic dehazing algorithm
dehazedImage = imreducehaze(underwaterImage_DP);

% Display the original image
subplot(1, 2, 1);
imshow(underwaterImage);
title('Original Image');

% Display the restored image
subplot(1, 2, 2);
imshow(dehazedImage);
title('Restored Image');
PSNR_1 = psnr(dehazedImage,underwaterImage_DP);
SSIM_1 = ssim(dehazedImage,underwaterImage_DP);
display(PSNR_1);
display(SSIM_1);


    case 2
        figure(2);
        subplot(2,2,1);
 imshow(underwaterImage);

title('Orignal image');


%Apply histogram equalization  to enhance the contrast of an image by redistributing the intensity values
enhanced_img = histeq(underwaterImage);
subplot(2,2,2);
imshow(enhanced_img);
title("Contrast Image");
PSNR_2 = psnr(enhanced_img,underwaterImage);
SSIM_2 = ssim(enhanced_img,underwaterImage);
display(PSNR_2);
display(SSIM_2);


%Sharpening
sharpened_img = imsharpen(underwaterImage);
subplot(2,2,3);
imshow(sharpened_img);
title("Sharpened image");
PSNR_3 = psnr(sharpened_img, underwaterImage);
SSIM_3 = ssim(sharpened_img, underwaterImage);
display(PSNR_3);
display(SSIM_3);


%Color adjustment
img_hsv = rgb2hsv(underwaterImage);
img_hsv(:, :, 2) = img_hsv(:, :, 2) * 1.5; % Adjust the saturation factor
color_adj_img = hsv2rgb(img_hsv);
subplot(2,2,4);
imshow(color_adj_img);
title('Color adjusted image');
PSNR_4 = psnr(color_adj_img, underwaterImage_DP);
SSIM_4 = ssim(color_adj_img, underwaterImage_DP);
    display(PSNR_4);
    display(SSIM_4);
 case 3
        figure(3);


% Convert the image to double for accurate processing
underwater_image_1 = double(underwaterImage) / 255;

% Apply color correction (compensate for color shift)
R_channel = underwater_image_1(:, :, 1);
G_channel = underwater_image_1(:, :, 2);
B_channel = underwater_image_1(:, :, 3);

% Apply color correction based on a simple model (you may need to adapt this)
R_corrected = R_channel * 1.2;
G_corrected = G_channel * 0.9;
B_corrected = B_channel * 0.6;

% Combine the corrected color channels
restored_image = cat(3, R_corrected, G_corrected, B_corrected);

% Enhance contrast (you may need to fine-tune parameters)
restored_image = imadjust(restored_image, [], [], 1.5);

% Display the restored image

subplot(1, 2, 1);
imshow(underwaterImage);
title('Underwater Image');

subplot(1, 2, 2);
imshow(restored_image);
title('Restored Image');
PSNR_5= psnr(restored_image, underwater_image_1);
SSIM_5 = ssim(restored_image, underwater_image_1);
display(PSNR_5);
display(SSIM_5);
case 4
     disp("Enter proper choice");
     
     
end

userChoice = input('Do you want to continue (Y or N)? ', 's');
       if strcmpi(userChoice,'N')
           continueloop=false;
           break;
       else 
           continueloop=true;
       end  
end
