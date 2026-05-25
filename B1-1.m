clc;
clear;
close all;

% Datos experimentales
f = [100 120 145 170 200 235 270 310 355 405 ...
    460 520 585 655 730 810 895 985 1080 1180 ...
    1290 1410 1540 1680 1830 1990 2160 2340 2530 2730];

Z = [152.3 149.1 146.8 144.9 142.0 139.5 137.9 136.1 134.8 133.6 ...
    132.7 131.9 131.4 131.1 130.9 131.0 131.3 131.9 132.7 133.8 ...
    135.2 136.9 138.9 141.1 143.5 146.1 149.0 152.2 155.6 159.2];

% Número de datos
n = length(f);

% Normalización para evitar problemas numéricos
x = (f - mean(f)) / std(f);

% Matriz de Vandermonde
A = zeros(n,n);

for i = 1:n
    for j = 1:n
        A(i,j) = x(i)^(j-1);
    end
end

% Coeficientes del polinomio
coef = A\Z';

% Mostrar coeficientes
disp('Coeficientes del polinomio desde a0 hasta a29:');
disp(coef);

% Mostrar polinomio
fprintf('\nPolinomio interpolante:\n');
fprintf('P(x) = ');

for j = 1:n
    if j == 1
        fprintf('%.6e', coef(j));
    else
        fprintf(' + %.6e*x^%d', coef(j), j-1);
    end
end

fprintf('\n\nDonde x = (f - mean(f)) / std(f)\n');

% Evaluar el polinomio
f_graf = linspace(min(f), max(f), 1000);
x_graf = (f_graf - mean(f)) / std(f);

Z_interp = zeros(size(x_graf));

for j = 1:n
    Z_interp = Z_interp + coef(j)*x_graf.^(j-1);
end

% Gráfica
figure;
plot(f,Z,'ko','MarkerFaceColor','k');
hold on;
plot(f_graf,Z_interp,'b','LineWidth',1.5);

grid on;
xlabel('Frecuencia f (Hz)');
ylabel('|Z| (Ohm)');
title('Interpolación polinómica por método matricial');
legend('Datos experimentales','Polinomio interpolante');