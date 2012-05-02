img = uint16(randint(480,640,[0 65535]));


imgR = uint8((255/31)*bitshift(bitand(img,63488),-11));  %# Red component
imgG = uint8((255/63)*bitshift(bitand(img,2016),-5));    %# Green component
imgB = uint8((255/31)*bitand(img,31));                   %# Blue component
imgRGB = cat(3,imgR,imgG,imgB);  %# Concatenate along the third dimension

J = IMREAD('Center.bmp', 'bmp');

%# Perform the above conversions to get imgRGB
subplot(1,2,1);
imshow(img);
title('Random uint16 image');
subplot(1,2,2);
imshow(imgRGB);
title('Corresponding RGB image');


