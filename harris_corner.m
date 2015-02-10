clear all;
close all;

Nx1=10;Sigmax1=2;Nx2=10;Sigmax2=2;Theta1=pi/2;
Ny1=10;Sigmay1=2;Ny2=10;Sigmay2=2;Theta2=0;
alfa=0.1;

logfilter = LogFunction(9, 1.4);

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
filterx=d2dgauss(Nx1,Sigmax1,Nx2,Sigmax2,Theta1);
Ix= conv2(double(w),double(filterx),'same');
imshow(Ix, []);
title('Ix');

% Caculate the gradient on y
subplot(3,2,3);
filtery=d2dgauss(Ny1,Sigmay1,Ny2,Sigmay2,Theta2);
Iy=conv2(double(w),double(filtery),'same'); 
imshow(Iy, []);
title('Iy');

% Get norm of gradient
subplot(3,2,4);
NVI=sqrt(Ix.*Ix+Iy.*Iy);
imshow(NVI, []);
title('Norm of Gradient');

Ixy = Ix .* Iy;

% Apply the threshold
subplot(3,2,5);
k = 0.04;
Ibw=(Ix.^2.*Iy.^2 - Ixy.^2) - k*(Ix.^2 + Iy.^2).^2;
I_max=max(max(Ibw));
I_min=min(min(Ibw));
level=alfa*(I_max-I_min)+I_min;
imshow(Ibw, []);
title('After Harris Corner Matrix');

after = imdilate(Ibw, [1, 1, 1; 1, 0, 1; 1, 1, 1]);

corners = (Ibw > after) & (after > -0.005 * ones(size(after)));

subplot(3,2,6);
imshow(corners);
title('After Finding local maximum');
% subplot(1, 3, 2); 
% logfilter = LogFunction(9, 1.4);
% H = conv2(double(w), double(logfilter), 'same');
% imshow(H, []);
% title('H');