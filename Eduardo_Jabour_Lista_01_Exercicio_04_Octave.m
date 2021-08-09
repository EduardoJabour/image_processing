L = 1; A = 1; a = 1/1000; p = 1/1000; paux = 1/p;

x = linspace(-L/2, L/2, paux);
u = [zeros(1, paux/2) A*ones(1, paux/2)];

for i = 1 : paux
    G(i) = (1/(2*(sqrt(pi*a))))*(exp(-1*((x(i)^2))/(4*a)));
endfor

for i = 1 : paux
    G01(i) = (1/(4*(sqrt(pi*(a*a*a)))))*(-x(i)*(exp(-1*((x(i)^2))/(4*a))));
endfor

for i = 1 : paux
    G02(i) = ((1/(4*(sqrt(pi*(a*a*a)))))*(exp(-1*((x(i)^2))/(4*a))))*(((x(i)^2)/(2*a))-1);
endfor

C01 = conv(G01, u);
C01ajustada = C01(750:end-250);
C02 = conv(G02, u);
C02ajustada = C02(750:end-250);

figure;
subplot(5, 1, 1);
plot(x, G);
title('Gaussiana');
subplot(5, 1, 2);
plot(x, G01);
title('Gaussiana Primeira Derivada');
subplot(5, 1, 3);
plot(x, G02, 'g');
title('Gaussiana Segunda Derivada');
subplot(5, 1, 4);
plot(x, C01ajustada);
title('Gauss Prim Der Convolução com degrau');
subplot(5, 1, 5);
plot(x, C02ajustada);
title('Gauss Seg Der Convolução com degrau');

