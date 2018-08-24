function y = powerCompress(input, Psat,Fs)
% y = powerCompress(input, Psat,Fs)
% Takes in a a signal makes sure that the maximum power in any frequency
% is less than or equal to Psat.  Also had some denoising capabilities, by
% zeroing out very low power frequencies.
% input - input Matlab sound file
% Psat  - Saturation power
% FS    - Sampling frequency of the input signal
x=input;
len=Fs*0.1;
iter=floor(length(x)/len);
Plow=0.008;
 
for rg=0:1:iter;
 start=rg*len+1;
 en= rg*len+len;
 if rg*len+len>length(x)
    en=length(x);
 end
 
clear signal X  X_pow Y_pow Y y z;
signal=x(start:en);
n = nextpow2(len);
N = 2^n;
X = fft(signal,N);
X_phase=angle(X);                % Save the old phase information
X_pow = abs(X)/N;
Y_pow = X_pow;
Y=zeros(N,1);
for k=0:N/2
   if Y_pow(k+1)<Plow              % Take out noise
      Y_pow(k+1)=0;
      Y_pow(N-k)=0;
   elseif Y_pow(k+1)>Psat          % Clip amplitudes higher than Psat
      Y_pow(k+1)=Psat;
      Y_pow(N-k)=Psat;
   end;
    Y(k+1) = Y_pow(k+1)*(cos(X_phase(k+1))+1i*sin(X_phase(k+1)));
    Y(N-k) = Y_pow(N-k)*(cos(X_phase(N-k))+1i*sin(X_phase(N-k)));
end;
y = real(ifft(Y,N));
z = y(1:en-start+1);
sig_out(start:en)=z;
end;
y = sig_out*5000; % Multiplying 5000 is just increasing the intensity of the o/p signal