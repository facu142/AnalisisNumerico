clc;
clear;
close all;

% Parámetros
Nx = 201;            % Cantidad de muestras de la señal
Fm = 3333;           % Frecuencia de muestreo

n = 0:Nx-1;

% Señal de entrada x[n]
x = 2*cos(2*pi*50/Fm*n) + 3*sin(2*pi*500/Fm*n);

% Frecuencia de corte
Fc = 200;            % Frecuencia de corte
Nh = 101;            % Longitud de la respuesta al impulso
nh = -(Nh-1)/2:(Nh-1)/2;

% Respuesta al impulso h[n] usando ventana de Hamming
hv = 2*Fc/Fm*sinc(2*Fc/Fm*nh) .* hamming(Nh).';
hvn = hv / sum(hv);      % Normalización

% Convolución en el tiempo (filtrada)
y_tiempo = conv(x, hvn, 'same');

% Vectores x[n] y h[n] con dimensión N = 2^r
N = 2^nextpow2(Nx + length(nh) - 1);

% Cero-padding de x[n] y h[n]
x_pad = [x, zeros(1, N - length(x))];
h_pad = [hvn, zeros(1, N - length(hvn))];

% Convolución utilizando FFT
X = fft(x_pad);
H = fft(h_pad);
Y = X .* H;
y_fft = ifft(Y);

% Gráficos
figure;

% Primer columna: señales en el tiempo
subplot(4, 2, 1);
stem(n/Fm, x, 'filled');
title('Señal de entrada x[n]');
xlabel('Tiempo (s)');
ylabel('x[n]');
xlim([0, (Nx-1)/Fm]);

subplot(4, 2, 3);
stem(nh/Fm, hvn, 'filled');
title('Respuesta al impulso h[n] (Hamming)');
xlabel('Tiempo (s)');
ylabel('h[n]');
xlim([0, (Nx-1)/Fm]);

subplot(4, 2, 5);
stem(n/Fm, y_tiempo, 'filled');
title('Respuesta del sistema y[n] (Convolución)');
xlabel('Tiempo (s)');
ylabel('y[n]');
xlim([0, (Nx-1)/Fm]);

subplot(4, 2, 7);
stem(n/Fm, y_fft(1:Nx), 'filled');
title('Respuesta del sistema y[n] (FFT)');
xlabel('Tiempo (s)');
ylabel('y[n]');
xlim([0, (Nx-1)/Fm]);

% Segunda columna: módulos de los espectros
frequencias = (0:N-1)*(Fm/N);

subplot(4, 2, 2);
stem(frequencias, abs(X), 'filled');
title('Espectro de x[n] (|X[k]|)');
xlabel('Frecuencia (Hz)');
ylabel('|X[k]|');
xlim([0, Fm]);

subplot(4, 2, 4);
stem(frequencias, abs(H), 'filled');
title('Espectro de h[n] (|H[k]|)');
xlabel('Frecuencia (Hz)');
ylabel('|H[k]|');
xlim([0, Fm]);

subplot(4, 2, 6);
stem(frequencias, abs(fft(y_tiempo, N)), 'filled');
title('Espectro de y[n] (Convolución)');
xlabel('Frecuencia (Hz)');
ylabel('|Y[k]|');
xlim([0, Fm]);

subplot(4, 2, 8);
stem(frequencias, abs(Y), 'filled');
title('Espectro de y[n] (FFT)');
xlabel('Frecuencia (Hz)');
ylabel('|Y[k]|');
xlim([0, Fm]);
