clc; clear; close all;

f = [100 120 145 170 200 235 270 310 355 405 ...
     460 520 585 655 730 810 895 985 1080 1180 ...
     1290 1410 1540 1680 1830 1990 2160 2340 2530 2730];

Z = [152.3 149.1 146.8 144.9 142.0 139.5 137.9 136.1 134.8 133.6 ...
     132.7 131.9 131.4 131.1 130.9 131.0 131.3 131.9 132.7 133.8 ...
     135.2 136.9 138.9 141.1 143.5 146.1 149.0 152.2 155.6 159.2];

fg = linspace(min(f),max(f),1000);

sp = spline(f,Z);
Zs = ppval(sp,fg);

p5 = polyfit(f,Z,5);
Zp5 = polyval(p5,fg);

Z1000_spline = ppval(sp,1000);
Z1000_p5 = polyval(p5,1000);

fprintf('|Z|(1000) con spline = %.4f ohmios\n', Z1000_spline);
fprintf('|Z|(1000) con polinomio grado 5 = %.4f ohmios\n', Z1000_p5);

figure;
plot(f,Z,'ko','MarkerFaceColor','k');
hold on;
plot(fg,Zs,'b','LineWidth',2);
plot(fg,Zp5,'r--','LineWidth',2);
plot(1000,Z1000_spline,'mo','MarkerFaceColor','m');
grid on;
xlabel('Frecuencia f (Hz)');
ylabel('|Z| (\Omega)');
title('Comparación spline cúbico y polinomio grado 5');
legend('Datos','Spline cúbico','Polinomio grado 5','|Z|(1000)');
