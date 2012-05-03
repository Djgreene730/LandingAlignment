clear;

%% Prepare Test File
% Read Bitmap from File
J = uint16(imread('./TestImages/test_landing.bmp', 'bmp'));


% Prepare each color
jR = uint16(bitand(bitshift((J(:,:,1) * (31/255)), 11),63488));
jG = uint16(bitand(bitshift((J(:,:,2) * (63/255)), 5),2016));
jB = uint16(bitand(bitshift((J(:,:,3) * (31/255)), 0),31));

% Combine into 16-Bit RGB565 format
imgJ = bitor(bitor(jR, jG), jB);


%% First Pass - Perform Spacial Filtering & Hough Transform

% Sobel Adjustments
s_Divisor = 32768;
h_Radius = 60;

% Create Empty Image
sobelJ = uint16(zeros(480,640));
houghJ = uint8(zeros(480,640));

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
        
        if (sobelJ(y, x) > 0)
            % Add color to the edge
            sobelJ(y, x) = 1024;
            
            % Add Point to Hough Accumulator
            if (((x > (h_Radius + 1)) && (y > (h_Radius + 1))) && ((x < (640 - h_Radius)) && (y < (480 - h_Radius))))
                f = 1 - h_Radius;
                ddF_x = 1;
                ddF_y = -2 * h_Radius;
                r = 0;
                t = h_Radius;

                houghJ(y + h_Radius, x) = houghJ(y + h_Radius, x) + 1;
                houghJ(y - h_Radius, x) = houghJ(y - h_Radius, x) + 1;
                houghJ(y, x + h_Radius) = houghJ(y, x + h_Radius) + 1;
                houghJ(y, x - h_Radius) = houghJ(y, x - h_Radius) + 1;

                while(r < t)
                    if(f >= 0)
                        t = t - 1;
                        ddF_y = ddF_y + 2;
                        f = f + ddF_y;
                    end;
                    r = r + 1;
                    ddF_x = ddF_x + 2;
                    f = f + ddF_x;    
                    houghJ(y + t, x + r) = houghJ(y + t, x + r) + 1;
                    houghJ(y + t, x - r) = houghJ(y + t, x - r) + 1;
                    houghJ(y - t, x + r) = houghJ(y - t, x + r) + 1;
                    houghJ(y - t, x - r) = houghJ(y - t, x - r) + 1;
                    houghJ(y + r, x + t) = houghJ(y + r, x + t) + 1;
                    houghJ(y + r, x - t) = houghJ(y + r, x - t) + 1;
                    houghJ(y - r, x + t) = houghJ(y - r, x + t) + 1;
                    houghJ(y - r, x - t) = houghJ(y - r, x - t) + 1;
                end;
            end;
        end;
    end;
end;

%% Second Pass - Locate Circle Centers from Hough Accumulator



%% Convert Sobel Image to 24-Bit True Color
imgR = uint8((255/31)*bitshift(bitand(sobelJ,63488),-11));  %# Red component
imgG = uint8((255/63)*bitshift(bitand(sobelJ,2016),-5));    %# Green component
imgB = uint8((255/31)*bitand(sobelJ,31));                   %# Blue component
imgRGB = cat(3,imgR,imgG,imgB);  %# Concatenate along the third dimension


%% Save Output Images to File
imwrite(imgRGB, 'sobelOutput_n.bmp', 'bmp');
imwrite(houghJ, 'houghOutput_n.bmp', 'bmp');

%% Plot Data
% Perform the above conversions to get imgRGB
subplot(1,3,1);
imshow(imgJ);
title('Original Bitmap Image');
subplot(1,3,2);
imshow(imgRGB);
title('Algebraic Sobel Edge Filter');
subplot(1,3,3);
imagesc(640,480,houghJ);
axis square
axis off
title('Hough Transform Accumulator');