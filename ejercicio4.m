clc;
clear;
close all;

% Parámetros
dt = 0.0003;         % Intervalo de tiempo
Fm = 1/dt;           % Frecuencia de muestreo
Nx = 201;            % Cantidad de muestras

t = 0:dt:(Nx-1)*dt;
n = 0:Nx-1;

% Señal de entrada x[n]
x = 2*cos(2*pi*50*t) + 3*sin(2*pi*500*t);

% Frecuencia de corte
Fc = 200;            % Frecuencia de corte
Nh = 101;            % Longitud de la respuesta al impulso
nh = -(Nh-1)/2:(Nh-1)/2;

% Respuesta al impulso h[n] usando ventana de Hamming
h = 2*Fc*dt*sinc(2*Fc*dt*nh) .* hamming(Nh).';
h = h / sum(h);      % Normalización

% Convolución en el tiempo
y_time = conv(x, h, 'same');

% Vectores x[n] y h[n] con dimensión N = 2^r
N = 2^nextpow2(Nx + length(nh) - 1);

% Cero-padding de x[n] y h[n]
x_pad = [x, zeros(1, N - length(x))];
h_pad = [h, zeros(1, N - length(h))];

% Convolución utilizando FFT
X = fft(x_pad);
H = fft(h_pad);
Y = X .* H;
y_fft = ifft(Y);

% Gráficos
figure;

% Primer columna: señales en el tiempo
subplot(4, 2, 1);
stem(t, x, 'filled');
title('Señal de entrada x[n]');
xlabel('Tiempo (s)');
ylabel('x[n]');
xlim([0, (Nx-1)*dt]);

subplot(4, 2, 3);
stem(nh*dt, h, 'filled');
title('Respuesta al impulso h[n] (Hamming)');
xlabel('Tiempo (s)');
ylabel('h[n]');
xlim([min(nh)*dt, max(nh)*dt]);

subplot(4, 2, 5);
stem(t, y_time, 'filled');
title('Respuesta del sistema y[n] (Convolución)');
xlabel('Tiempo (s)');
ylabel('y[n]');
xlim([0, (Nx-1)*dt]);

subplot(4, 2, 7);
stem(t, y_fft(1:Nx), 'filled');
title('Respuesta del sistema y[n] (FFT)');
xlabel('Tiempo (s)');
ylabel('y[n]');
xlim([0, (Nx-1)*dt]);

% Segunda columna: módulos de los espectros
frequencies = (0:N-1)*(Fm/N);

subplot(4, 2, 2);
stem(frequencies, abs(X), 'filled');
title('Espectro de x[n] (|X[k]|)');
xlabel('Frecuencia (Hz)');
ylabel('|X[k]|');
xlim([0, 3300]);

subplot(4, 2, 4);
stem(frequencies, abs(H), 'filled');
title('Espectro de h[n] (|H[k]|)');
xlabel('Frecuencia (Hz)');
ylabel('|H[k]|');
xlim([0, 3300]);

subplot(4, 2, 6);
stem(frequencies, abs(fft(y_time, N)), 'filled');
title('Espectro de y[n] (Convolución)');
xlabel('Frecuencia (Hz)');
ylabel('|Y[k]|');
xlim([0, 3300]);

subplot(4, 2, 8);
stem(frequencies, abs(Y), 'filled');
title('Espectro de y[n] (FFT)');
xlabel('Frecuencia (Hz)');
ylabel('|Y[k]|');
xlim([0, 3300]);


