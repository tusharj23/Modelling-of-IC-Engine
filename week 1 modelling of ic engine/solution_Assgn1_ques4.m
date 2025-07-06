clc; clear;

f = @(v) [ v(2) - (2*v(1))/(1 + v(1));                     % f1: point lies on the curve
           (v(2) - 1)/v(1) - 2/(1 + v(1))^2 ];              % f2: slope from A equals derivative

x0 = [1; 1];

sol = fsolve(f, x0);
xt = sol(1);
yt = sol(2);

% Slope of the tangent
m = (yt - 1)/xt;

% Equation of tangent: y = m*x + c; use A(0,1) to find c
c = 1;

fprintf("Point of tangency: (%.4f, %.4f)\n", xt, yt);
fprintf("Slope of tangent: %.4f\n", m);
fprintf("Equation of tangent: y = %.4f*x + %.4f\n", m, c);

fplot(@(x) 2*x./(1 + x), [0, 4], 'b', 'LineWidth', 2); hold on;
fplot(@(x) m*x + c, [0, 4], 'r--', 'LineWidth', 2);
plot(xt, yt, 'ko', 'MarkerFaceColor', 'k');
plot(0, 1, 'go', 'MarkerFaceColor', 'g');
legend('y = 2x/(1+x)', 'Tangent line', 'Point of Tangency', 'Point A(0,1)');
xlabel('x'); ylabel('y'); title('Tangent from A(0,1) to Curve');
grid on;
