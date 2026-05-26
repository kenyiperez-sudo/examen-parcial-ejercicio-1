clc;
clear;
close all;

% Datos
f = [10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0 32.5 ...
    35.0 37.5 40.0 42.5 45.0 47.5 50.0 52.5 55.0 57.5 ...
    60.0 62.5 65.0 67.5 70.0 72.5 75.0 77.5 80.0 82.5 ...
    85.0 87.5 90.0 92.5 95.0 97.5 100.0 102.5 105.0 107.5];

V = [0.842 0.911 0.986 1.062 1.143 1.227 1.314 1.401 1.482 1.551 ...
    1.216 1.048 0.866 0.689 0.521 0.364 0.223 0.103 0.012 -0.041 ...
    -0.057 -0.034 0.018 0.096 0.197 0.318 0.452 0.579 0.700 0.809 ...
    0.611 0.688 0.756 0.811 0.856 0.894 0.926 0.954 0.980 1.004];

% Construccion del spline de V(f)
spline_V = spline(f,V);

% Derivada del spline
derivada_spline = fnder(spline_V,1);

% Frecuencias solicitadas
f_eval = [40.0 70.0 100.0 10.0];

% Evaluacion de la derivada
dVdf_spline = ppval(derivada_spline,f_eval);

% Mostrar resultados
fprintf('Derivada usando spline cubico:\n\n');
fprintf('dV/df en 40 kHz = %.4f V/kHz\n', dVdf_spline(1));
fprintf('dV/df en 70 kHz = %.4f V/kHz\n', dVdf_spline(2));
fprintf('dV/df en 100 kHz = %.4f V/kHz\n', dVdf_spline(3));
fprintf('dV/df en 10 kHz = %.4f V/kHz\n', dVdf_spline(4));

% Grafica de la derivada
fino = linspace(min(f),max(f),1000);
dVdf_fino = ppval(derivada_spline,fino);

figure;
plot(fino,dVdf_fino,'b','LineWidth',2);
hold on;
plot(f_eval,dVdf_spline,'ro','MarkerFaceColor','r');

grid on;
xlabel('Frecuencia f (kHz)');
ylabel('dV/df (V/kHz)');
title('Derivada del spline cubico de V(f)');
legend('Derivada del spline','Puntos evaluados');