clc;
clear;
close all;

% Datos del ensayo
f = [10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0 32.5 ...
    35.0 37.5 40.0 42.5 45.0 47.5 50.0 52.5 55.0 57.5 ...
    60.0 62.5 65.0 67.5 70.0 72.5 75.0 77.5 80.0 82.5 ...
    85.0 87.5 90.0 92.5 95.0 97.5 100.0 102.5 105.0 107.5];

V = [0.842 0.911 0.986 1.062 1.143 1.227 1.314 1.401 1.482 1.551 ...
    1.216 1.048 0.866 0.689 0.521 0.364 0.223 0.103 0.012 -0.041 ...
    -0.057 -0.034 0.018 0.096 0.197 0.318 0.452 0.579 0.700 0.809 ...
    0.611 0.688 0.756 0.811 0.856 0.894 0.926 0.954 0.980 1.004];

Z = [182.4 178.9 175.1 171.0 166.8 162.7 158.9 155.4 152.0 149.0 ...
    146.1 145.2 145.8 147.3 149.9 153.5 158.0 163.2 168.9 174.8 ...
    180.5 186.2 191.5 196.2 200.1 203.1 205.2 206.3 206.1 204.7 ...
    198.0 194.4 190.9 187.8 185.1 183.0 181.6 180.8 180.6 180.9];

% Construccion de splines cubicos
spline_V = spline(f,V);
spline_Z = spline(f,Z);

% Frecuencias a evaluar
f_eval = [41.0 73.0];

% Evaluacion
V_eval = ppval(spline_V,f_eval);
Z_eval = ppval(spline_Z,f_eval);

% Resultados
fprintf('Resultados con spline cubico:\n\n');

fprintf('V(41 kHz) = %.4f V\n', V_eval(1));
fprintf('|Z|(41 kHz) = %.4f ohmios\n', Z_eval(1));

fprintf('V(73 kHz) = %.4f V\n', V_eval(2));
fprintf('|Z|(73 kHz) = %.4f ohmios\n', Z_eval(2));

% Mostrar coeficientes por tramos
disp('Coeficientes del spline para V(f):');
disp(spline_V.coefs);

disp('Coeficientes del spline para |Z|(f):');
disp(spline_Z.coefs);

% Graficas
fino = linspace(min(f),max(f),1000);

figure;
plot(f,V,'ko','MarkerFaceColor','k');
hold on;
plot(fino,ppval(spline_V,fino),'b','LineWidth',2);
plot(f_eval,V_eval,'ro','MarkerFaceColor','r');
grid on;
xlabel('Frecuencia f (kHz)');
ylabel('Voltaje V (V)');
title('Spline cubico para V(f)');
legend('Datos','Spline','Valores evaluados');

figure;
plot(f,Z,'ko','MarkerFaceColor','k');
hold on;
plot(fino,ppval(spline_Z,fino),'b','LineWidth',2);
plot(f_eval,Z_eval,'ro','MarkerFaceColor','r');
grid on;
xlabel('Frecuencia f (kHz)');
ylabel('|Z| (ohmios)');
title('Spline cubico para |Z|(f)');
legend('Datos','Spline','Valores evaluados');