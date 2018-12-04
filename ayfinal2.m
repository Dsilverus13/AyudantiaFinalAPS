x = audioread('cp0834.wav'); % lee señal --> x
t = (1 : length(x)) * (1/8000); % eje de tiempo
close; figure(1); subplot 411; plot(t, x); grid
title('Señal original del pulsar');
% Rectificación en onda completa
m = abs(x);
subplot 412; plot(t, m); grid
title('Señal del pulsar rectificada en onda completa');
% LPF IIR antialias @ 15 Hz, para poder reducir la tasa de muestreo
a = 0.998; e = filter((1-a), [1 -a], m);
subplot 413; plot(t, e); grid
title('Envolvente filtrada con LPF @ 15 Hz, 8000 m/s');


e = e(1 : 100 : length(e)); % decimación
t = (1 : length(e)) * (1/80); % nuevo eje de tiempo @ 80 m/s

a = 0.95; f = filter((1-a), [1 -a], e);

e = e - f; 
% Autocorrelación de la envolvente centrada en cero
[AC, d] = xcorr(e, 10*80); % desplazamiento máximo: 10 seg
t = d * (1/80); % desplazamiento en [seg]
subplot 414; plot(t, AC); grid
title('Autocorrelación de la envolvente, desplazamiento máx. 10 seg');