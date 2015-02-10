clear all;
close all;

Nx1=10;Sigmax1=2;Nx2=10;Sigmax2=2;Theta1=pi/2;
Ny1=10;Sigmay1=2;Ny2=10;Sigmay2=2;Theta2=0;
alfa=0.1;
dx = [-1 0 1; -1 0 1; -1 0 1];
dy = dx';
g = fspecial('gaussian',max(1,fix(12)), 6);

% Read the image
% [x, map] = imread('lena.gif');
% w = ind2gray(x, map);
% figure(1);
% colormap(gray);
w = checkerboard();
subplot(3,2,1);
imshow(w, []);
title('Image: lena.gif');

% Caculate the gradient on x
subplot(3,2,2);
Ix = conv2(double(w), double(dx), 'same');
Ix2 = conv2(Ix.^2, g, 'same');
imshow(Ix, []);
title('Ix');

% Caculate the gradient on y
subplot(3,2,3);
Iy = conv2(double(w), double(dy), 'same');
Iy2 = conv2(Iy.^2, g, 'same');
imshow(Iy, []);
title('Iy');

Ixy = conv2(Ix.*Iy, g,'same');

% Apply the threshold
subplot(3,2,5);
k = 0.04;
Ibw=(Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;
imshow(Ibw, []);
title('After Harris Corner Matrix');

corners = Ibw > imdilate(Ibw, [1, 1, 1; 1, 0, 1; 1, 1, 1]);

subplot(3,2,6);
imshow(corners);
title('After Finding local maximum');
% subplot(1, 3, 2); 
% logfilter = LogFunction(9, 1.4);
% H = conv2(double(w), double(logfilter), 'same');
% imshow(H, []);
% title('H');