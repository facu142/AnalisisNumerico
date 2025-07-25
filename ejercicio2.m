clc
clear
close all

% dt: Intervalo de tiempo entre muestras.
% Se define el intervalo de tiempo (dt) entre cada muestra de la señal.
dt = 0.003;

% Nx: Número total de muestras de la señal x(t) para formar la señal x[n]
% Se define el número total de muestras (Nx) para la señal.
Nx = 301;

% t: Se crea un vector t que contiene los puntos en el tiempo continuo, desde 0 hasta (Nx-1)*dt, con un total de Nx puntos.
t = 0:dt:(Nx-1)*dt; % Ajuste para asegurar que t tiene exactamente Nx puntos

% Señal analógica original en tiempo continuo.
% Se genera la señal analógica x_analog como una combinación de una cosenoidal de 50 Hz y una senoidal de 500 Hz.
x_analog = -5*cos(2*pi*100*t) + 3*sin(2*pi*1500*t);

% Vector de tiempo discreto para la señal de entrada. Define los puntos en el tiempo discreto para la señal de entrada x[n]
% Se crea un vector n que contiene los índices de tiempo discreto, desde 0 hasta Nx-1.
n = 0:Nx-1;

% Señal de entrada en tiempo discreto. x[n]
% Se genera la señal x en tiempo discreto usando los mismos componentes que la señal analógica, pero evaluada en los puntos de tiempo discreto n*dt.
x = -5*cos(2*pi*100*n*dt) + 3*sin(2*pi*1500*n*dt);

% Frecuencia de corte para el filtro. (Entre 100Hz y 1500Hz)
% Se define la frecuencia de corte Fc del filtro en 200 Hz.
Fc = 800;

% Longitud de la respuesta al impulso h[n]
Nh = 101; % Debería ser impar y suficientemente grande

% Vector de tiempo discreto para la respuesta al impulso h[n].
% Se crea un vector nh que contiene los índices de tiempo discreto para la respuesta al impulso, centrado en cero.
nh = -(Nh-1)/2:(Nh-1)/2;

% Respuesta al impulso del sistema.
h = 2 * Fc * dt * sinc(2 * Fc * dt * nh);

% Salida del sistema LTI
% utilizando la función sinc ajustada a la frecuencia de corte Fc.
y = conv(x, h);

% Vector de tiempo discreto para la salida y[n]
ny = (n(1) + nh(1)):(n(end) + nh(end));

% Ajustar tamaño de las fuentes
fontSize = 18;

% GRÁFICOS

figure();
% Primer gráfico: señal de entrada x[n]
subplot(3, 1, 1);
stem(n, x, 'filled');
title('Señal de entrada x[n]', 'FontSize', fontSize);
xlabel('n', 'FontSize', fontSize);
ylabel('x[n]', 'FontSize', fontSize);
xlim([min(ny)-10, max(ny)+10]);

% Segundo gráfico: respuesta al impulso h[n]
subplot(3, 1, 2);
stem(nh, h, 'filled');
title('Respuesta al impulso h[n]', 'FontSize', fontSize);
xlabel('n', 'FontSize', fontSize);
ylabel('h[n]', 'FontSize', fontSize);
xlim([min(ny)-10, max(ny)+10]);

% Tercer gráfico: respuesta del sistema y[n]
subplot(3, 1, 3);
stem(ny, y(1:length(ny)), 'filled');
title('Respuesta del sistema y[n]', 'FontSize', fontSize);
xlabel('n', 'FontSize', fontSize);
ylabel('y[n]', 'FontSize', fontSize);
xlim([min(ny)-10, max(ny)+10]);

% Cambiar el tamaño de las fuentes para todo el gráfico
set(findall(gcf, '-property', 'FontSize'), 'FontSize', fontSize);

