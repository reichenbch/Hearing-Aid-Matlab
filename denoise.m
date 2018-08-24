function y = denoise(x)
% y = denoise(x);
% method to denoise a given signal using wavelets
% x is the input Matlab sound file
%THR is the threshold, SORH is for soft or hard thresholding, KEEPAPP allows you to keep 
%approximation coefficients
[thr,sorh,keepapp]=ddencmp( 'den' , 'wv' ,x);  
% returns a de-noised version xc of input signal x (our one-dimensional speech signal) 
[y, ~, ~, ~, ~]=wdencmp( 'gbl' ,x, 'db3' ,2,thr,sorh,keepapp);  
