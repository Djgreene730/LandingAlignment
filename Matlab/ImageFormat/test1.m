%% Prepare Test File
% Read Bitmap from File
J = uint16(imread('./TestImages/Center.bmp', 'bmp'));

% Prepare each color
jR = uint16(bitand(bitshift((J(:,:,1) * (31/255)), 11),63488));
jG = uint16(bitand(bitshift((J(:,:,2) * (63/255)), 5),2016));
jB = uint16(bitand(bitshift((J(:,:,3) * (31/255)), 0),31));

% Combine into 16-Bit RGB565 format
imgJ = bitor(bitor(jR, jG), jB);

%% Convert back to TrueColor 24-Bit Format to View
imgR = uint8((255/31)*bitshift(bitand(imgJ,63488),-11));  %# Red component
imgG = uint8((255/63)*bitshift(bitand(imgJ,2016),-5));    %# Green component
imgB = uint8((255/31)*bitand(imgJ,31));                   %# Blue component
imgRGB = cat(3,imgR,imgG,imgB);  %# Concatenate along the third dimension


%% Plot Data
% Perform the above conversions to get imgRGB
subplot(1,3,1);
imshow('./TestImages/Center.bmp');
title('Original Bitmap Image');
subplot(1,3,2);
imshow(imgJ);
title('16-Bit RGB565 Converter Image');
subplot(1,3,3);
imshow(imgRGB);
title('Reconverted to 24-Bit TrueColor');
