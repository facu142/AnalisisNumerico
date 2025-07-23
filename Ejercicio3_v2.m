clc
clear
close all

% Intervalo de tiempo
dt = 0.0001;

% Cantidad de muestras
Nx = 301;

t = 0:dt:1;
n = 0:Nx-1;

% Señal de entrada x[n]
x = -5 * cos(2 * pi * 100 * n * dt) + 3 * sin(2 * pi * 1500 * n * dt);

% Frecuencia de corte
Fc = 800;

% Longitud de la respuesta al impulso
Nh = 2 * Fc * dt * Nx;
nh = -(Nh-1)/2:(Nh-1)/2;

h = 2 * Fc * dt * sinc(2 * Fc * dt * nh);

% Redefinir vectores x[n] y h[n] con dimensión N = 2^r
N = 2^nextpow2(Nx + length(nh) - 1);

x_padded = [x, zeros(1, N - length(x))];
h_padded = [h, zeros(1, N - length(h))];

% Realizar la convolución utilizando FFT
X = fft(x_padded);
H = fft(h_padded);
Y = X .* H;
y_fft = ifft(Y);

marker_size = 4;

% Crear gráficos
figure()

% Primer gráfico: señal de entrada x[n]
subplot(3, 2, 1)
stem(0:N-1, x_padded, 'filled', 'MarkerSize', marker_size)
title('Señal de entrada x[n]')
xlabel('n')
ylabel('x[n]')
xlim([0, N-1])

% Segundo gráfico: módulo de la FFT de x[n]
subplot(3, 2, 2)
stem(0:N-1, abs(X), 'filled', 'k', 'MarkerSize', marker_size)
title('FFT de x[n]')
xlabel('k')
ylabel('|X[k]|')
xlim([0, N-1])

% Tercer gráfico: respuesta al impulso h[n]
subplot(3, 2, 3)
stem(0:N-1, h_padded, 'filled', 'r', 'MarkerSize', marker_size)
title('Respuesta al impulso h[n]')
xlabel('n')
ylabel('h[n]')
xlim([0, N-1])

% Cuarto gráfico: módulo de la FFT de h[n]
subplot(3, 2, 4)
stem(0:N-1, abs(H), 'filled', 'k', 'MarkerSize', marker_size)
title('FFT de h[n]')
xlabel('k')
ylabel('|H[k]|')
xlim([0, N-1])

% Quinto gráfico: respuesta del sistema y[n] (en el tiempo)
subplot(3, 2, 5)
stem(0:N-1, y_fft, 'filled', 'm', 'MarkerSize', marker_size)
title('Respuesta del sistema y[n]')
xlabel('n')
ylabel('y[n]')
xlim([0, N-1])

% Sexto gráfico: módulo de la FFT de y[n]
subplot(3, 2, 6)
stem(0:N-1, abs(Y), 'filled', 'k', 'MarkerSize', marker_size)
title('FFT de y[n]')
xlabel('k')
ylabel('|Y[k]|')
xlim([0, N-1])

