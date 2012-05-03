%% Prepare Test File
% Read Bitmap from File
J = uint16(imread('./TestImages/Center.bmp', 'bmp'));

% Prepare each color
jR = uint16(bitand(bitshift((J(:,:,1) * (31/255)), 11),63488));
jG = uint16(bitand(bitshift((J(:,:,2) * (63/255)), 5),2016));
jB = uint16(bitand(bitshift((J(:,:,3) * (31/255)), 0),31));

% Combine into 16-Bit RGB565 format
imgJ = bitor(bitor(jR, jG), jB);


%% Perform Spacial Filtering - Sobel Operation

% Sobel Adjustments
s_Divisor = 512;

% Create Empty Image
sobelJ = uint16(zeros(480,640));

% Loop through Each Line
for x = 2:639
    % Loop through each column
    for y = 2:479
        % Create Links
        p = [imgJ(y-1, x-1) imgJ(y-1, x) imgJ(y-1, x+1) imgJ(y, x-1) imgJ(y, x) imgJ(y, x+1) imgJ(y+1, x-1) imgJ(y+1, x) imgJ(y+1, x+1)];
        p = p ./ s_Divisor;
        
        % Process the +Horizontal Filter
        sobelJ(y, x) = (((p(1) + p(3)) + (p(2) + p(2))) - ((p(7) + p(9)) + (p(8) + p(8))));

        % Process the -Horizontal Filter
        sobelJ(y, x) = sobelJ(y, x) + (((p(7) + p(9)) + (p(8) + p(8))) - ((p(1) + p(3)) + (p(2) + p(2))));

        % Process the +Vertical Filter
        sobelJ(y, x) = sobelJ(y, x) + (((p(3) + p(9)) + (p(6) + p(6))) - ((p(1) + p(7)) + (p(4) + p(4))));
        
        % Process the -Vertical Filter
        sobelJ(y, x) = sobelJ(y, x) + (((p(1) + p(7)) + (p(4) + p(4))) - ((p(3) + p(9)) + (p(6) + p(6))));
    end
end

%% Convert Sobel Image to 24-Bit True Color
imgR = uint8((255/31)*bitshift(bitand(sobelJ,63488),-11));  %# Red component
imgG = uint8((255/63)*bitshift(bitand(sobelJ,2016),-5));    %# Green component
imgB = uint8((255/31)*bitand(sobelJ,31));                   %# Blue component
imgRGB = cat(3,imgR,imgG,imgB);  %# Concatenate along the third dimension
imwrite(imgRGB, 'sobelOutput.bmp', 'bmp');

%% Plot Data
% Perform the above conversions to get imgRGB
subplot(2,1,1);
imshow('./TestImages/Center.bmp');
title('Original Bitmap Image');
subplot(2,1,2);
imshow(imgRGB);
title('Algebraic Sobel Edge Filter');
