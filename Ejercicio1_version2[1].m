% Definición de los intervalos de tiempo discreto
nx = 2:6  % Intervalo de tiempo para x[n]
nh = 0:2  % Intervalo de tiempo para h[n]

% Definición de las señales x[n] y h[n] como pulsos rectangulares de valor unitario
x = ones(1, length(nx))
h = ones(1, length(nh))

% Convolución de x[n] y h[n]
y = conv(x, h)  % y[n] = x[n] * h[n]

% Definición de los nuevos intervalos de tiempo para la señal y[n]
ny = (nx(1) + nh(1)):(nx(end) + nh(end))

% Graficar las señales x[n], h[n] e y[n] usando subplot y stem
figure()

% Primer gráfico: señal de entrada x[n]
subplot(3, 1, 1)
stem(nx, x, 'filled')
title('Señal de entrada x[n]')
xlabel('n')
ylabel('x[n]')
xlim([min([nx, nh]), max(ny)])

% Segundo gráfico: respuesta al impulso h[n]
subplot(3, 1, 2)
stem(nh, h, 'filled')
title('Respuesta al impulso h[n]')
xlabel('n')
ylabel('h[n]')
xlim([min([nx, nh]), max(ny)])

% Tercer gráfico: respuesta del sistema y[n]
subplot(3, 1, 3)
stem(ny, y, 'filled')
title('Respuesta del sistema y[n]')
xlabel('n')
ylabel('y[n]')
xlim([min([nx, nh]), max(ny)])

