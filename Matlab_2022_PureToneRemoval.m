close all
clc
clear
%% Generation of noisy signal
% Enter your ID 
ID = 318474657;
[inputSignal,fs,SNR_in] = inputSignalBuilder(ID);
soundsc(inputSignal,fs)
figure();plot(0:length(inputSignal)-1,inputSignal);
xlabel('n','fontsize',16);
ylabel('signal','fontsize',16);

audiowrite(['Input_' num2str(ID) '.wav'],inputSignal,fs)
[x, fs]= audioread('about_time.wav');
SNR_in = 10*log10(mean(x.^2)/mean((inputSignal-x).^2))

%% Noise frequency detection
%   In this part the input signal is examined. We assume a pure tone
%   disturbance of cos(w_0*n), and have to locate w_0=(2*pi/N)*k0
%   the cosine wave is periodic with N=512
%% Fourier Discrete Transform - Detect w_0 from the last frame of the signal
Nframe=512;
x_last_frame=inputSignal((end-Nframe+1):end);
n=-256:1:255;
[X,omega]=my_DTFT(x_last_frame,n,Nframe);
plot(omega,abs(X));
xlabel('omega')
ylabel('X(jw)')
title('X fourier transform')
% plot x_last_frame DTFT to detect w_0
% dont forget to define w axis to plot the DTFT in right scale
% we found that w_0 = 1.16583


%% Implemetation I : perfect filtering (FIR)
N = 1000;
n = -N:N;
B = pi/50;

w_0 = 1.16583; 
h_1 =  2*cos(w_0.*n).*sin(B.*n)./(pi.*n);
h_1(N+1)=0;
% Note- you can use conv() function to filter the signal. 
% use the option 'same' to get the same output length.
% for example if you have: input-x filter-h:
% y= conv(x,h,'same') 

subplot(2,3,1);
stem(n,h_1,'.');
title("h_1");
xlabel('n');
ylabel('h_1(n)');
subplot(2,3,4);
[H_1,omega]=my_DTFT(h_1,n,N);
plot(omega,abs(H_1));
title("H_1 Fourier Transform");
xlabel('omega');
ylabel('H_1(n)');
v_1 =conv(x,h_1,'same');
y_1=x-v_1;

 audiowrite(['Output_I_' num2str(ID) '.wav'],y_1,fs); SNR_out = 10*log10(mean(x.^2)/mean((y_1-x).^2));
 
% Freaquency response- H_1(e^jw)
%_____________________________________________________________________________
%TODO

%% Implemetation II : ZOH design (FIR)
N = 100;
n = -N:N;
w_0 = 1.16583;
h_2 = 2*cos(w_0*n)/(2*N+1);
v_2 = conv(x,h_2,'same');
y_2 = x-v_2;

subplot(2,3,2);
stem(n,h_2,'.','g');
title("h_2 ");
xlabel('n');
ylabel('h_2(n)');

[H_2,omega_2]=my_DTFT(h_2,n,N);
subplot(2,3,5);
plot(omega_2,abs(H_2),'g');

title("H_2 Fourier Transform");
xlabel('omega');
ylabel('H_2(n)');

 audiowrite(['Output_II_' num2str(ID) '.wav'],y_2,fs)
 SNR_out = 10*log10(mean(x.^2)/mean((y_2-x).^2))
% 
% Freaquency response- H_2(e^jw)
% _____________________________________________________________________________
% %TODO
% 
% %%
%% Implemetation III : recursive design (IIR)

w_0 =1.16583;
 alpha = 0.999;
 z_1=0; % initial rest
 z_2=0; % initial rest
 for n=1:length(inputSignal)
        z_1 = alpha*exp(1j*w_0)*z_1+(1-alpha)*inputSignal(n);
        z_2 = alpha*exp(-1j*w_0)*z_2+(1-alpha)*inputSignal(n);
        y_3(n,1) =inputSignal(n)-z_1-z_2;
 end

[X_3,Xomega3]=my_DTFT(inputSignal,1:length(inputSignal),length(inputSignal)/4);
[Y_3,Yomega3]=my_DTFT(y_3,1:length(y_3),length(y_3)/4);

H_3=Y_3./X_3; %H=Y/X


subplot(2,3,6);
plot(1:length(H_3),abs(H_3));
title("H_3 Fourier Transform");
xlabel('omega');
ylabel('H_3(n)');

subplot(2,3,3);
h_3 = ifft(H_3);%inverse transform
stem(1:length(h_3),h_3,'.');

title("h_3");
xlabel('n');
ylabel('h_3(n)');
audiowrite(['Output_III_' num2str(ID) '.wav'],y_3,fs)
SNR_out = 10*log10(mean(x.^2)/mean((y_3-x).^2))

%% Performace evaluation:

[Grade, SNR_out_ref]= GradeMyOutput(ID,y_1,1);
[Grade, SNR_out_ref]= GradeMyOutput(ID,y_2,2);
[Grade, SNR_out_ref]= GradeMyOutput(ID,y_3,3);
