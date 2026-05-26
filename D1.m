clc; clear; close all;

f = [100 120 145 170 200 235 270 310 355 405 ...
     460 520 585 655 730 810 895 985 1080 1180 ...
     1290 1410 1540 1680 1830 1990 2160 2340 2530 2730];

Z = [152.3 149.1 146.8 144.9 142.0 139.5 137.9 136.1 134.8 133.6 ...
     132.7 131.9 131.4 131.1 130.9 131.0 131.3 131.9 132.7 133.8 ...
     135.2 136.9 138.9 141.1 143.5 146.1 149.0 152.2 155.6 159.2];

Zth = 150;
sp = spline(f,Z);

g = @(x) ppval(sp,x) - Zth;

raiz1 = fzero(g,[100 120]);
raiz2 = fzero(g,[2160 2340]);

fprintf('Raiz 1 = %.4f Hz\n', raiz1);
fprintf('Raiz 2 = %.4f Hz\n', raiz2);

fg = linspace(min(f),max(f),1000);
G = ppval(sp,fg) - Zth;

figure;
plot(fg,G,'b','LineWidth',2);
hold on;
yline(0,'r--');
plot(raiz1,0,'ko','MarkerFaceColor','k');
plot(raiz2,0,'ko','MarkerFaceColor','k');
grid on;
xlabel('Frecuencia f (Hz)');
ylabel('S(f) - 150');
title('Raíces de |Z|(f) - 150');
legend('S(f)-150','Eje cero','Raíces');
