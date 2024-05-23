clc
clear
close all

% dt: Intervalo de tiempo entre muestras.
dt = 0.0003;

% Nx: Número total de muestras de la señal x(t) para formar la señal x[n]
Nx = 201;

% t: Define los puntos en el tiempo continuo para evaluar la señal analógica x(t).
t = 0:dt:(Nx-1)*dt; % Ajuste para asegurar que t tiene exactamente Nx puntos

% Señal analógica original en tiempo continuo.
x_analog = 2*cos(2*pi*50*t) + 3*sin(2*pi*500*t);

% Vector de tiempo discreto para la señal de entrada. Define los puntos en el tiempo discreto para la señal de entrada x[n]
n = 0:Nx-1;

% Señal de entrada en tiempo discreto. x[n]
x = 2*cos(2*pi*50*n*dt) + 3*sin(2*pi*500*n*dt);

% Frecuencia de corte para el filtro. (Entre 50Hz y 500Hz)
Fc = 200;

% Longitud de la respuesta al impulso h[n]
Nh = 101; % Debería ser impar y suficientemente grande

% Vector de tiempo discreto para la respuesta al impulso h[n].
nh = -(Nh-1)/2:(Nh-1)/2;

% Respuesta al impulso del sistema.
h = 2 * Fc * dt * sinc(2 * Fc * dt * nh);

% Salida del sistema LTI
y = conv(x, h);

% Vector de tiempo discreto para la salida y[n]
ny = (n(1) + nh(1)):(n(end) + nh(end));

% GRÁFICOS

figure();
% Primer gráfico: señal de entrada x[n]
subplot(3, 1, 1);
stem(n, x, 'filled');
title('Señal de entrada x[n]');
xlabel('n');
ylabel('x[n]');
xlim([min(ny)-10, max(ny)+10]);

% Segundo gráfico: respuesta al impulso h[n]
subplot(3, 1, 2);
stem(nh, h, 'filled');
title('Respuesta al impulso h[n]');
xlabel('n');
ylabel('h[n]');
xlim([min(ny)-10, max(ny)+10]);

% Tercer gráfico: respuesta del sistema y[n]
subplot(3, 1, 3);
stem(ny, y(1:length(ny)), 'filled');
title('Respuesta del sistema y[n]');
xlabel('n');
ylabel('y[n]');
xlim([min(ny)-10, max(ny)+10]);

