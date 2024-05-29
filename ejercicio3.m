clc
clear
close all

dt = 0.0003;   % Intervalo de tiempo
Nx = 201;  % Cantidad de muestras

t = 0:dt:(Nx-1)*dt;



n = 0:Nx-1;

x = 2*cos(2*pi*50*n*dt) + 3*sin(2*pi*500*n*dt); % Señal de entrada x[n]

Fc = 200; % Frecuencia de corte
Nh = 101; % Longitud de la respuesta al impulso
nh = -(Nh-1)/2:(Nh-1)/2;

h = 2*Fc*dt*sinc(2*Fc*dt*nh);

% vectores x[n] y h[n] con dimensión N = 2^r
N = 2^nextpow2(Nx + length(nh) - 1);

% Cero-padding de x[n] y h[n]
x_pad = [x, zeros(1, N - length(x))];
h_pad = [h, zeros(1, N - length(h))];

% convolución utilizando FFT
X = fft(x_pad);
H = fft(h_pad);
Y = X .* H;
y_fft = ifft(Y);

ny = 0:N-1;

% gráficos
figure()

% Primer gráfico: señal de entrada x[n]
subplot(3, 2, 1)
stem(0:N-1, x_pad, 'filled')
title('Señal de entrada x[n]')
ylabel('x[n]')
xlim([-50, 300])

% Segundo gráfico: módulo de la FFT de x[n]
subplot(3, 2, 2)
stem(0:N-1, abs(X), 'filled')
title('Espectro de x[n] (|X[k]|)')
xlabel('Frecuencia (Hz)')
ylabel('|X[k]|')
xlim([0, 510])

% Tercer gráfico: respuesta al impulso h[n]
subplot(3, 2, 3)
stem(0:N-1, h_pad, 'filled')
title('Respuesta al impulso h[n]')
xlabel('n')
ylabel('h[n]')
xlim([-50, 300])

% Cuarto gráfico: módulo de la FFT de h[n]
subplot(3, 2, 4)
stem(0:N-1, abs(H), 'filled')
title('Espectro de h[n] (|H[k]|)')
xlabel('Frecuencia (Hz)')
ylabel('|H[k]|')
xlim([0, 510])
ylim([0,1.5])

% Quinto gráfico: respuesta del sistema y[n] (en el tiempo)
subplot(3, 2, 5)
stem(0:N-1, y_fft, 'filled')
title('Respuesta del sistema y[n]')
xlabel('n')
ylabel('y[n]')
xlim([0, 300])

% Sexto gráfico: módulo de la FFT de y[n]
subplot(3, 2, 6)
stem(0:N-1, abs(Y), 'filled')
title('Espectro de y[n] (|Y[k]|)')
xlabel('Frecuencia (Hz)')
ylabel('|Y[k]|')
xlim([0, 510])
