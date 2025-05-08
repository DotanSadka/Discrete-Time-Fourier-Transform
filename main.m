clear;

% create 4 signals x1-4.
%___________________x1______________________
%x_1 [n]=cos⁡〖[ω_0⋅n]〗

n1 = -30:30; 
omega_0 = 2;
x1 = cos(omega_0.*n1);
Nw1 = 500;


[X1, omega_1] = my_DTFT(x1,n1,Nw1);

% signal
subplot(2,4,1);
stem(n1,x1,'.');
title('X_1 signal')
grid on
xlabel('n(time)');
ylabel('x1(n)');
%transform
subplot(2,4,5);
plot(omega_1,abs(X1));
title('X_1 Fourier Transform')
grid on
xlabel('omega');
ylabel('X1(e^jw)');

%_________________x2______________________

Nw2 = 500;
n2 = -30:30;
n2 = setdiff(n2,0);
B = 2;
x2 = (sin(B*n2))./(pi*n2);

[X2, omega_2] = my_DTFT(x2,n2,Nw2);

% signal
subplot(2,4,2);
stem(n2,x2,'.','g');
title('X_2 signal')
grid on
xlabel('n(time)');
ylabel('x2(n)');
%transform
subplot(2,4,6);
plot(omega_2,X2,'g');
title('X_2 Fourier Transform')
grid on
xlabel('omega');
ylabel('X2(e^jw)');

%___________________x3____________________


n3 = -30:30;
Ntrain = 8;
Nw3 = 500;
x3 = zeros(1,length(n3));
x3(1:Ntrain-1:end) = 1;

[X3,omega_3] = my_DTFT(x3,n3,Nw3);

% signal
subplot(2,4,3);
stem(n3,x3,'.');
title('X_3 signal')
grid on
xlabel('n(time)');
ylabel('x3(n)');
%transform
subplot(2,4,7);
plot(omega_3,abs(X3));
title('X_3 Fourier Transform')
grid on
xlabel('omega');
ylabel('X3(e^jw)');



%________________x4_______________________


n4 = -30:30;
Nw4 = 500;
N_4 = 4;

x4 = zeros(1,length(n4));
x4(30-N_4:1:30+N_4) = 1;

[X4,omega_4] = my_DTFT(x4,n4,Nw4);

% signal
subplot(2,4,4);
stem(n4,x4,'.','g');
title('X_4 signal')
grid on
xlabel('n(time)');
ylabel('x4(n)');
%transform
subplot(2,4,8);
plot(omega_4,abs(X4),'g');
title('X_4 Fourier Transform')
grid on
xlabel('omega');
ylabel('X4(e^jw)');


%_______________________________________



