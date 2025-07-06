clc; clear;

f = @(v) [v(1)^2 + v(2)^2 - 4;  % Circle
          v(1)^2 - v(2) - 1];   % Parabola

initial_guesses = [1, 1; -1, 1; 1, -1; -1, -1];

% Loop through guesses to find all intersection points
fprintf("Intersection points:\n");
for i = 1:size(initial_guesses, 1)
    guess = initial_guesses(i, :);
    sol = fsolve(f, guess);
    fprintf("(x, y) = (%.4f, %.4f)\n", sol(1), sol(2));
end
