% Inicialización
clc
clear
close all

% Definicion de parametros
Nx = 301;
Nh = 127;
nx = 0:(Nx-1);
nh = -(Nh-1)/2:(Nh-1)/2;

% Definición de Fc, dt y Fm
Fc = 800;
dt = 0.0001;
Fm = 3333;

% Definir las señales x[n] y h[n]
x_original = -5 * cos(2 * pi * 100 *nx / Fm) + 3 * sin(2 * pi * 1500 * nx / Fm);
h_original = 2 * Fc / Fm * sinc(2 * Fc * nh / Fm);

% Aplicar enventanado y normalización a h
ventana_hamming = hamming(Nh);
vh = h_original .* ventana_hamming';
vh_normalizada = vh / sum(vh);

% Ajustar las longitudes a una potencia de 2
N = 2^nextpow2(Nx + Nh - 1);
x = [x_original, zeros(1, N - Nx)];
h = [vh_normalizada, zeros(1, N - Nh)];

% Definir la función y1 a partir de la convolución de x y h normalizada y enventanada
y1 = conv(x, vh_normalizada);

% Transformada de Fourier de x[n], h[n] enventanada normalizada y de y1[n]
X = fft(x, N);
H = fft(vh_normalizada, N);
Y1 = fft(y1, N);

% Multiplicación en el dominio de la frecuencia de H(f) y X(f) para obtener Y2(F)
Y2 = X .* H;

% Transformada inversa de Y2(f) para obtener y2[n]
y2 = ifft(Y2);

% Definición de límites
limxA = nx(1) + nh(1);
limxB = nx(Nx) + nh(Nh);
ny1 = limxA : limxA + length(y1) - 1;
ny2 = limxA : limxA + length(y2) - 1;

% Tamaño de fuente
fontSize = 22;

figure()

% Graficar x[n]
subplot(4, 2, 1);
stem(nx, x_original, 'r'), legend('x');
title('Señal de Entrada x[n]', 'FontSize', fontSize);
ylabel('Amplitud', 'FontSize', fontSize);
xlabel('n', 'FontSize', fontSize);
xlim([limxA, limxB]);

% Graficar FFT de x[n]
subplot(4, 2, 2);
stem(abs(X), 'b'), legend('|X(f)|');
title('Modulo de X[f]', 'FontSize', fontSize);
ylabel('Amplitud', 'FontSize', fontSize);
xlabel('f', 'FontSize', fontSize);
xlim([0, (N-1)]);

% Graficar h[n]
subplot(4, 2, 3);
stem(nh, vh_normalizada, 'c'), legend('h');
title('Respuesta al Impulso h[n] enventanada y normalizada', 'FontSize', fontSize);
ylabel('Amplitud', 'FontSize', fontSize);
xlabel('n', 'FontSize', fontSize);
xlim([limxA, limxB]);

% Graficar FFT de h[n]
subplot(4, 2, 4);
stem(abs(H), 'g'), legend('|H(f)|');
title('Modulo de H[f]', 'FontSize', fontSize);
ylabel('Amplitud', 'FontSize', fontSize);
xlabel('f', 'FontSize', fontSize);
xlim([0, (N-1)]);

% Graficar y1 por convolución en el tiempo de x y h
subplot(4, 2, 5);
stem(ny1, y1, 'm:*'), legend('y');
title('Señal de Salida y1[n] por convolucion de x(n) y h(n)', 'FontSize', fontSize);
ylabel('Amplitud', 'FontSize', fontSize);
xlabel('n', 'FontSize', fontSize);
xlim([limxA, limxB]);

% Graficar Y1(f) por transformada FFT de y1
subplot(4, 2, 6);
stem(abs(Y1), 'k'), legend('|Y1(f)|');
title('Modulo de Y1(f) por transformada de y1', 'FontSize', fontSize);
ylabel('Amplitud', 'FontSize', fontSize);
xlabel('f', 'FontSize', fontSize);
xlim([0, (N-1)]);

% Graficar Y2(f) por propiedad de multiplicación de H y X
subplot(4, 2, 8);
stem(abs(Y2), 'k'), legend('|Y2(f)|');
title('Modulo de Y2(f) por multiplicacion de X(f) y H(f)', 'FontSize', fontSize);
ylabel('Amplitud', 'FontSize', fontSize);
xlabel('f', 'FontSize', fontSize);
xlim([0, (N-1)]);

% Graficar y2(n) por antitransformada de Y2(f)
subplot(4, 2, 7);
stem(ny2, y2, 'm:*'), legend('y');
title('Señal de Salida y2[n] Antitransformada de Y2(f)', 'FontSize', fontSize);
ylabel('Amplitud', 'FontSize', fontSize);
xlabel('n', 'FontSize', fontSize);
xlim([limxA, limxB]);

% Cambiar el tamaño de las fuentes en todos los gráficos
set(findall(gcf, '-property', 'FontSize'), 'FontSize', fontSize);

