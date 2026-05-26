clc; clear; close all;

f = [100 120 145 170 200 235 270 310 355 405 ...
     460 520 585 655 730 810 895 985 1080 1180 ...
     1290 1410 1540 1680 1830 1990 2160 2340 2530 2730];

Z = [152.3 149.1 146.8 144.9 142.0 139.5 137.9 136.1 134.8 133.6 ...
     132.7 131.9 131.4 131.1 130.9 131.0 131.3 131.9 132.7 133.8 ...
     135.2 136.9 138.9 141.1 143.5 146.1 149.0 152.2 155.6 159.2];

sp = spline(f,Z);
sp1 = fnder(sp,1);
sp2 = fnder(sp,2);

fg = linspace(min(f),max(f),10000);
dZdf = ppval(sp1,fg);

idx = find(dZdf(1:end-1).*dZdf(2:end) < 0);
fmin = fg(idx(1));
Zmin = ppval(sp,fmin);
segunda = ppval(sp2,fmin);

fprintf('Minimo aproximado: f = %.4f Hz\n', fmin);
fprintf('|Z| minimo = %.4f ohmios\n', Zmin);
fprintf('Segunda derivada = %.8f\n', segunda);

figure;
plot(fg,dZdf,'b','LineWidth',2);
hold on;
yline(0,'r--');
plot(fmin,0,'ko','MarkerFaceColor','k');
grid on;
xlabel('Frecuencia f (Hz)');
ylabel('d|Z|/df');
title('Primera derivada del spline cúbico');
legend('d|Z|/df','Eje cero','Cambio de signo');
