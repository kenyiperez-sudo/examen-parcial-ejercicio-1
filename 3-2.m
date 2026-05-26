clc;
clear;
close all;

% Datos de frecuencia
f = [10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0 32.5 ...
    35.0 37.5 40.0 42.5 45.0 47.5 50.0 52.5 55.0 57.5 ...
    60.0 62.5 65.0 67.5 70.0 72.5 75.0 77.5 80.0 82.5 ...
    85.0 87.5 90.0 92.5 95.0 97.5 100.0 102.5 105.0 107.5];

% Datos de voltaje
V = [0.842 0.911 0.986 1.062 1.143 1.227 1.314 1.401 1.482 1.551 ...
    1.216 1.048 0.866 0.689 0.521 0.364 0.223 0.103 0.012 -0.041 ...
    -0.057 -0.034 0.018 0.096 0.197 0.318 0.452 0.579 0.700 0.809 ...
    0.611 0.688 0.756 0.811 0.856 0.894 0.926 0.954 0.980 1.004];

% Construccion del spline
sp = spline(f,V);

% Funcion g(f)=V(f)
g = @(x) ppval(sp,x);

% Intervalo inicial
a = 55.0;
b = 57.5;

tol = 1e-6;

% Metodo de biseccion
while (b-a)/2 > tol

    c = (a+b)/2;

    if g(a)*g(c) < 0
        b = c;
    else
        a = c;
    end

end

raiz = (a+b)/2;

fprintf('Primera raiz aproximada = %.4f kHz\n', raiz);

% Grafica
fino = linspace(50,60,1000);

figure;
plot(fino,ppval(sp,fino),'b','LineWidth',2);
hold on;
yline(0,'r--');
plot(raiz,0,'ko','MarkerFaceColor','k');

grid on;

xlabel('Frecuencia (kHz)');
ylabel('V(f)');

title('Primera raiz usando biseccion');

legend('Spline V(f)','Nivel cero','Raiz');