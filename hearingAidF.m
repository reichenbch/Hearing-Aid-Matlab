function y = hearingAidF(input,g,Psat,transitionV,~)
% input - the input signal to the system. Should be a wave file.
% g - the maximum gain that will be applied to the signal
% Psat - the cut off power.  The output power will not be higher than this
% transitionV - 4 element vector that has the values of where the gain changes
%               to the next piecewise function
% newfile - desired name for the output sound file.  It will be in .au format
[x,fs] = audioread(input);
x = x(:, 1);
%info = audioinfo(input);
% Add Noise to the signal
x = awgn(x,30);
%figure;plot(x);title('sdadadad');
%auwrite(x,fs,info.BitsPerSample,'linear','noisyF');

xc = denoise(x);  % denoising filter

xf = freqshape(xc,g,transitionV,fs);       % frequency shaping filter
y = powerCompress(xf, Psat,fs);                % amplitude shaping filter
x_length = length(x);
t=0:1/fs:(x_length-1)/fs;

%ratio = snr(x,(x-xc))
% plots the input and output signals

figure;
subplot(2,1,1);
plot(t,x,'b');
axis tight;
xlabel('Time (sec)');
ylabel('Relative Magnitude');
title('Time Profile for Data in Signal 2');


subplot(2,1,2);
plot(t,y,'r');
axis tight;
xlabel('Time (sec)');
ylabel('Relative Magnitude');
title('Time Profile for Data in Adjusted Signal 2');

figure;
subplot(2,1,1);
specgram(x);
title('Spectrogram of Original Signal 2');

subplot(2,1,2);
specgram(y);
title('Spectrogram of Adjusted Signal 2');


%soundsc(input, fs);
sound(y,fs);
%auwrite(y,fs,info.BitsPerSample,'linear',newfile);