clc; clear;

r = 8;                          % Compression ratio
P1 = 100;                       % kPa
T1 = 30 + 273.15;               % K
V1 = 0.0038;                    % m^3
T3 = 1200 + 273.15;             % K
gamma = 1.4;                    % Specific heat ratio (Cp/Cv) for air
R = 0.287;                      % kJ/kg.K
Cv = R / (1 - 1/gamma);         % Cv
Cp = Cv * gamma;

% State 1
V2 = V1 / r;

% Isentropic compression (1 -> 2)
T2 = T1 * (V1/V2)^(gamma - 1);
P2 = P1 * (V1/V2)^gamma;

% Constant volume heat addition (2 -> 3)
P3 = P2 * T3 / T2;
V3 = V2;

% Isentropic expansion (3 -> 4)
V4 = V1;
T4 = T3 * (V3/V4)^(gamma - 1);
P4 = P3 * (V3/V4)^gamma;

% Heat calculations (Qin at 2->3, Qout at 4->1)
Qin = Cv * (T3 - T2);           % in kJ/kg
Qout = Cv * (T4 - T1);          % in kJ/kg
Wnet = Qin - Qout;              % Net work output

% Efficiency
eta = 1 - (1 / r^(gamma - 1));

% Mean effective pressure (MEP)
MEP = Wnet / (V1 - V2);         % in kPa

fprintf('Heat Rejection (Qout): %.3f kJ/kg\n', Qout);
fprintf('Net Work Output (Wnet): %.3f kJ/kg\n', Wnet);
fprintf('Thermal Efficiency (eta): %.2f %%\n', eta * 100);
fprintf('Mean Effective Pressure (MEP): %.2f kPa\n', MEP);

% P-V Diagram
n_points = 100;

% Compression: 1 -> 2
V_comp = linspace(V1, V2, n_points);
P_comp = P1 * (V1 ./ V_comp).^gamma;

% Expansion: 3 -> 4
V_exp = linspace(V3, V4, n_points);
P_exp = P3 * (V3 ./ V_exp).^gamma;

figure;
plot([V1 V2], [P1 P2], 'ko'); hold on;
plot(V_comp, P_comp, 'b', 'LineWidth', 2);
plot([V2 V3], [P2 P3], 'r', 'LineWidth', 2);    
plot(V_exp, P_exp, 'g', 'LineWidth', 2);        
plot([V4 V1], [P4 P1], 'm', 'LineWidth', 2);    
xlabel('Volume (m^3)');
ylabel('Pressure (kPa)');
title('P-V Diagram of Ideal Otto Cycle');
legend('States', 'Compression', 'Heat Addition', 'Expansion', 'Heat Rejection');
grid on;
