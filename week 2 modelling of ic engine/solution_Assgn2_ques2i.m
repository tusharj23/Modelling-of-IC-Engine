clc; clear;

gamma = 1.35;                  % Specific heat ratio
P1 = 110;                      % Initial pressure in kPa
T1 = 400;                      % Initial temperature in K
T3 = 2800;                     % Max temperature in K
bore = 0.09;                   % in m
stroke = 0.1;                  % in m
L = 0.14;                      % Connecting rod length in m
CR = 8.5;                      % Compression ratio

%% ENGINE GEOMETRY
V_swept = (pi/4) * bore^2 * stroke;
V_clearance = V_swept / (CR - 1);
V1 = V_swept + V_clearance;
V2 = V_clearance;
V3 = V2;
V4 = V1;

%% STATE POINTS WITHOUT KINEMATICS
T2 = T1 * (V1/V2)^(gamma - 1);
P2 = P1 * (V1/V2)^gamma;

P3 = P2 * T3 / T2;
T4 = T3 * (V3/V4)^(gamma - 1);
P4 = P3 * (V3/V4)^gamma;

%% THERMAL EFFICIENCY
eta = 1 - 1 / (CR^(gamma - 1));

fprintf('Thermal efficiency: %.2f%%\n', eta * 100);

%% P-V DIAGRAM WITHOUT KINEMATICS
n = 200;
V_comp = linspace(V1, V2, n);
P_comp = P1 * (V1 ./ V_comp).^gamma;

V_exp = linspace(V3, V4, n);
P_exp = P3 * (V3 ./ V_exp).^gamma;

% Constant volume processes
P_23 = linspace(P2, P3, n);
V_23 = V2 * ones(1, n);

P_41 = linspace(P4, P1, n);
V_41 = V1 * ones(1, n);

%% PISTON KINEMATICS FUNCTION
theta = linspace(0, pi, n);          % crank angle from 0 to 180 deg
a = stroke / 2;                      % crank radius
R = L / a;                           % ratio of connecting rod to crank

vol_kin = @(th) V_clearance + V_swept/2 * (1 - cos(th) + (1/R) - sqrt(1 - (1/R^2)*sin(th).^2));

V_comp_kin = vol_kin(theta);
P_comp_kin = P1 * (V1 ./ V_comp_kin).^gamma;

V_exp_kin = fliplr(vol_kin(theta));
P_exp_kin = P3 * (V3 ./ V_exp_kin).^gamma;

figure

% Without Kinematics
subplot(1,2,1);
hold on;
plot(V_comp, P_comp, 'b', 'LineWidth', 2);      % 1-2
plot(V_23, P_23, 'r', 'LineWidth', 2);          % 2-3
plot(V_exp, P_exp, 'g', 'LineWidth', 2);        % 3-4
plot(V_41, P_41, 'm', 'LineWidth', 2);          % 4-1
title('P-V Diagram Without Piston Kinematics');
xlabel('Volume (m^3)');
ylabel('Pressure (kPa)');
grid on;
legend('Compression', 'Heat Addition', 'Expansion', 'Heat Rejection');

% With Kinematics
subplot(1,2,2);
hold on;
plot(V_comp_kin, P_comp_kin, 'b', 'LineWidth', 2);  % 1-2
plot(V2, P2:((P3-P2)/n):P3, 'r', 'LineWidth', 2);   % 2-3
plot(V_exp_kin, P_exp_kin, 'g', 'LineWidth', 2);    % 3-4
plot(V1, P4:((P1-P4)/n):P1, 'm', 'LineWidth', 2);   % 4-1
title('P-V Diagram With Piston Kinematics');
xlabel('Volume (m^3)');
ylabel('Pressure (kPa)');
grid on;
legend('Compression', 'Heat Addition', 'Expansion', 'Heat Rejection');
