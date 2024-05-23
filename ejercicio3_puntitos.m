% Parámetros
Fs = 1000; % Frecuencia de muestreo (Hz)
Ts = 1/Fs; % Período de muestreo (s)

% Definición de la señal analógica x(t)
t = 0:Ts:0.2; % Vector de tiempo continuo (201 muestras)
x_analog = 2*cos(2*pi*50*t) + 3*sin(2*pi*500*t); % Señal analógica x(t)

% Definición de la señal de entrada en tiempo discreto x[n]
Nx = length(t); % Número de muestras
x = 2*cos(2*pi*50*t) + 3*sin(2*pi*500*t); % Señal de entrada x[n]

% Parámetros de la respuesta al impulso h[n]
Fc = 200; % Frecuencia de corte (Hz)
Nh = 101; % Longitud de la respuesta al impulso (debe ser impar)
nh = -(Nh-1)/2:(Nh-1)/2; % Vector de tiempo para h[n]
h = 2*Fc*Ts*sinc(2*Fc*Ts*nh); % Respuesta al impulso h[n]

% Dimensión N = 2^r
N = 2^nextpow2(Nx + Nh - 1); % Dimensión final

% Cero-padding de x[n] y h[n]
x_pad = [x, zeros(1, N - Nx)];
h_pad = [h, zeros(1, N - Nh)];

% Transformadas de Fourier
X = fft(x_pad);
H = fft(h_pad);

% Convolución en el dominio de la frecuencia
Y = X .* H;

% Transformada inversa para obtener y[n]
y = ifft(Y);

% Gráficos

% Dominios de tiempo
n_x = 0:Nx-1;
n_h = -(Nh-1)/2:(Nh-1)/2;
n_y = 0:N-1;

% Dominios de frecuencia
k = 0:N-1;
f = k*Fs/N; % Vector de frecuencias en Hz

% Tamaño del marcador
marker_size = 3;

figure()

% Primer gráfico: señal de entrada x[n] en tiempo
subplot(3, 2, 1)
stem(n_x, x, 'filled', 'MarkerSize', marker_size)
title('Señal de entrada x[n]')
xlabel('n')
ylabel('x[n]')
xlim([-50, 250])

% Segundo gráfico: módulo de X[k]
subplot(3, 2, 2)
stem(f, abs(X), 'filled', 'MarkerSize', marker_size)
title('Espectro de x[n] (|X[k]|)')
xlabel('Frecuencia (Hz)')
ylabel('|X[k]|')
xlim([-50, 1000])

% Tercer gráfico: respuesta al impulso h[n] en tiempo
subplot(3, 2, 3)
stem(n_h, h, 'filled', 'MarkerSize', marker_size)
title('Respuesta al impulso h[n]')
xlabel('n')
ylabel('h[n]')
xlim([-50, 50])

% Cuarto gráfico: módulo de H[k]
subplot(3, 2, 4)
stem(f, abs(H), 'filled', 'MarkerSize', marker_size)
title('Espectro de h[n] (|H[k]|)')
xlabel('Frecuencia (Hz)')
ylabel('|H[k]|')
xlim([0, 900])
ylim([0,1.5])

% Quinto gráfico: respuesta del sistema y[n] en tiempo
subplot(3, 2, 5)
stem(n_y, y, 'filled', 'MarkerSize', marker_size)
title('Respuesta del sistema y[n]')
xlabel('n')
ylabel('y[n]')
xlim([0, 300])

% Sexto gráfico: módulo de Y[k]
subplot(3, 2, 6)
stem(f, abs(Y), 'filled', 'MarkerSize', marker_size)
title('Espectro de y[n] (|Y[k]|)')
xlabel('Frecuencia (Hz)')
ylabel('|Y[k]|')
xlim([0, Fs])
