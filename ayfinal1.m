clear all
clc
% Datos
fc = 200; % inicio de la banda de rechazo en [Hz]
Fs = 1000; % frec. de muestreo en [Hz]
N = 6; % orden del filtro
Rp = 3; % ripple en dB en la banda de paso
Rs = 60; % ripple (atenuación) en dB en la banda de rechazo
f1 = 0; % frec. mínima para el cálculo de la rpta de frecuencia
f2 = 500; % frec. máxima para el cálculo de la rpta de frecuencia
m1 = 1e-6; % límite inferior del gráfico de magnitud
% Diseño del filtro
Wn = 2 * fc / Fs;
[b1, a1] = butter(N, Wn, 'low');
% Despliega coeficientes
b1
a1
% Diseño del filtro
[b2, a2] = cheby1(N, Rp, Wn, 'low');
% Despliega coeficientes
b2
a2
% Diseño del filtro
[b3, a3] = cheby2(N, Rs, Wn, 'low');
% Despliega coeficientes
b3
a3
% Calcula respuesta de frecuencia obtenida
f = [f1 : (f2-f1)/511 : f2];
H1 = freqz(b1, a1, f, Fs);
H2 = freqz(b2, a2, f, Fs);
H3 = freqz(b3, a3, f, Fs);
% Grafica Mag[H(f)]
semilogy(f, abs(H1)); axis([f1 f2 m1 1.1])
xlabel('f[Hz]'); title('Mag(H1)'); grid;
hold on;
semilogy(f, abs(H2)); axis([f1 f2 m1 1.1])
xlabel('f[Hz]'); title('Mag(H2)'); grid;
semilogy(f, abs(H3)); axis([f1 f2 m1 1.1])
xlabel('f[Hz]'); title('Mag(H): Respuesta en frecuencia de Filtros'); grid;
legend('Butterworth','Chebyshev 1','Chebyshev 2')
hold off;