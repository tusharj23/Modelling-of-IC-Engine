clc; clear;

y1 = @(x) 2*x + 1;
y2 = @(x) (2*x)./(1 + 0.2*x);

f1 = @(x) 2 ./ (y1(x) + y2(x));
f2 = @(x) 2 ./ (y1(x) - y2(x));

x_lower = 0;
x_upper = 7; % since y1 = 2x + 1 ⇒ x = (y1 - 1)/2, so y1=15 ⇒ x=7

I1 = integral(f1, x_lower, x_upper);
I2 = integral(f2, x_lower, x_upper);

fprintf('Integral of 1/(y1 + y2) dy1 = %.6f \n', I1);
fprintf('Integral of 1/(y1 - y2) dy1 = %.6f \n', I2);
