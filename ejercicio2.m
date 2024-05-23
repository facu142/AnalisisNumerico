%clc
%clear
%close all


dt = 0.0003
Nx = 201

t = 0:dt:1
x_analog= 2*cos(2*pi*50*t) + 3*sin(2*pi*500*t)

n = 0:Nx-1

x = 2*cos(2*pi*50*n*dt) + 3*sin(2*pi*500*n*dt); % Señal de entrada x[n]

Fc=200 %frecuencia entre 50 y 500 (señal analogica x(t))

Nh = 2*Fc*dt*Nx; % Longitud de la respuesta al impulso

nh = -(Nh-1)/2:(Nh-1)/2

h = 2* Fc * dt * sinc(2*Fc*dt*nh)

y = conv(x,h)

ny = (n(1) + nh(1)):(n(end) + nh(end));


figure()
% Primer gráfico: señal de entrada x[n]
subplot(3, 1, 1)
stem(n, x, 'filled')
title('Señal de entrada x[n]')
xlabel('n')
ylabel('x[n]')
xlim([min(ny)-10, max(ny)+10])

% Segundo gráfico: respuesta al impulso h[n]
subplot(3, 1, 2)
stem(nh, h, 'filled')
title('Respuesta al impulso h[n]')
xlabel('n')
ylabel('h[n]')
xlim([min(ny), max(ny)])

% Tercer gráfico: respuesta del sistema y[n]
subplot(3, 1, 3)
stem(ny, y(1:length(ny)), 'filled')
title('Respuesta del sistema y[n]')
xlabel('n')
ylabel('y[n]')
xlim([min(ny), max(ny)])
