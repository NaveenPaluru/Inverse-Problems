clear all;
close all;
clc;

%%

% This snipped solves a deblurring problem of the form Ax = y. A is the
% blurring operator (BCCB ), x is true image and the y is blurred image.

% A = m x m 
% x = m x 1  (in image form, x is a x b, where ab = m)
% y = m x 1  (in image form, y is a x b, where ab = m)

% We neither vectorize x nor y. Rather we solve the problem in the image
% domain using the properties of BCCB matrix.

% A = F'LF. 
% F = m x m (2D DFT matrix)
% L = m x m diagonal matrix with entries being 2D DFT of the Point spread
% function of the blur matrix A.

% Ref : https://angms.science/doc/CVX/ISTA0.pdf
% Ref : Deblurring Images: Matrices, Spectra, and Filtering % Per Christian 
%       Hansen, James G. Nagy, and Dianne P. O’Leary


%%
%Read the data and display the demo image and perform blur.

orgimg  = imread('cameraman.tif');
orgimg  = edge(orgimg,'canny');
figure;
subplot(131);
imshow(mat2gray(orgimg));
xlabel('Original Image');
[P, center] = psfGauss( size(orgimg) ,3);
Pbig = padPSF(P, size(orgimg));
L = fft2(circshift(Pbig, 1-center));
y = real(ifft2(L .* fft2(orgimg)));
subplot(132);
imshow(mat2gray(y));
xlabel('Blurred (Var = 3) ');
title(strcat(num2str(psnr(y,double(orgimg))),'dB '));
sgtitle('Deblurring by SD');

%% Inverse problem

% x_k+1 = x_k - alpha * A' (A * x_k - y)

xinit = zeros(size(orgimg));
iter  = 4000;
alpha = 1;

for i = 1:iter    
    xtemp = xinit - alpha * ifft2(L.^2 .* fft2(xinit)) + alpha * ifft2(L .* fft2(y));
    xinit = xtemp;
    snr(i)= psnr(double(orgimg),xinit);
end

subplot(133);
imshow(mat2gray(xinit));
xlabel('Reconstructed ');
title(strcat(num2str(psnr(xinit,double(orgimg))),'dB '));


figure;
plot(1:iter,snr,'r','LineWidth',3);
ax = gca;ax.FontSize = 10; 
xlabel('Iter','FontSize',15);ylabel('PSNR','FontSize',15);
grid on;





