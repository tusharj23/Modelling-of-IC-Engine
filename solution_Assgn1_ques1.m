clc; clear;
R = 8.314; % J/mol·K
Cv = 1.5 * R;
Cp = 2.5 * R;
n = 1; % mol
T1 = 343.15; % K (70°C)
P1 = 1e5; % Pa

%%
%Reversible Process
%Adiabatic Compression (T1 -> T2)
T2 = 423.15; % K (150°C)
gamma = Cp / Cv;
V1 = n * R * T1 / P1;
V2 = V1 * (T1 / T2)^(1/(gamma - 1));
P2 = n * R * T2 / V2;
W1 = (n * R / (1 - gamma)) * (T2 - T1);
Q1 = 0;
U1 = n * Cv * (T2 - T1);
H1 = n * Cp * (T2 - T1);

%Isobaric Cooling (T2 -> T3)
T3 = T1; % Back to 70°C
P3 = P2;
V3 = n * R * T3 / P3;
W2 = P2 * (V3 - V2);
Q2 = n * Cp * (T3 - T2);
U2 = n * Cv * (T3 - T2);
H2 = n * Cp * (T3 - T2);

%Isothermal Expansion (T3 -> T1)
P4 = P1;
V4 = V1;
W3 = n * R * T3 * log(V4 / V3);
Q3 = W3;
U3 = 0;
H3 = n * R * (T1 - T3);

W_total = W1 + W2 + W3;
Q_total = Q1 + Q2 + Q3;
dU_total = U1 + U2 + U3;
dH_total = H1 + H2 + H3;

fprintf("Reversible Process:\n");
fprintf("Total Work: %.2f J\n", W_total);
fprintf("Total Heat: %.2f J\n", Q_total);
fprintf("Total ΔU: %.2f J\n", dU_total);
fprintf("Total ΔH: %.2f J\n\n", dH_total);

V = linspace(V1, V2, 100);
P_adiabatic = P1 * (V1 ./ V).^gamma;

V_isobar = linspace(V2, V3, 100);
P_isobar = P2 * ones(size(V_isobar));

V_isoT = linspace(V3, V4, 100);
P_isoT = n * R * T1 ./ V_isoT;

figure
subplot(1,3,1);
plot(V, P_adiabatic, 'r', V_isobar, P_isobar, 'g', V_isoT, P_isoT, 'b');
xlabel('Volume (m^3)'); 
ylabel('Pressure (Pa)');
title('P-V Diagram'); 
legend('Adiabatic','Isobaric','Isothermal');

subplot(1,3,2);
plot(V, T1*(V1./V).^(gamma-1), 'r', V_isobar, linspace(T2,T3,100), 'g', V_isoT, T3*ones(size(V_isoT)), 'b');
xlabel('Volume (m^3)'); 
ylabel('Temperature (K)');
title('T-V Diagram'); 
legend('Adiabatic','Isobaric','Isothermal');

subplot(1,3,3);
plot(linspace(P1,P2,100), linspace(T1,T2,100), 'r', linspace(P2,P3,100), linspace(T2,T3,100), 'g', linspace(P3,P4,100), T3*ones(1,100), 'b');
xlabel('Pressure (Pa)'); 
ylabel('Temperature (K)');
title('P-T Diagram'); 
legend('Adiabatic','Isobaric','Isothermal');

W1_trapz = -trapz(V, P_adiabatic);
W2_trapz = trapz(V_isobar, P_isobar);
W3_trapz = trapz(V_isoT, P_isoT);
W_total_trapz = W1_trapz + W2_trapz + W3_trapz;

fprintf("Work from trapz (P-V area): %.2f J\n", W_total_trapz);


%%
%Irreversible Process
e = 0.75;

W1_irr = e * W1; % less negative (more work input)
Q1_irr = U1 - W1_irr;
W2_irr = W2; % same as reversible
Q2_irr = U2 - W2_irr;
W3_irr = e * W3; % less work output
Q3_irr = W3_irr;

W_total_irr = W1_irr + W2_irr + W3_irr;
Q_total_irr = Q1_irr + Q2_irr + Q3_irr;

fprintf("Total Work: %.2f J\n", W_total_irr);
fprintf("Total Heat: %.2f J\n", Q_total_irr);

V_irr1 = linspace(V1, V2, 100);
P_irr1 = P1 * (V1 ./ V_irr1).^gamma;

V_irr2 = linspace(V2, V3, 100);
P_irr2 = P2 * ones(size(V_irr2));

V_irr3 = linspace(V3, V4, 100);
P_irr3 = n * R * T3 ./ V_irr3;

figure
subplot(1,3,1);
plot(V_irr1, P_irr1, 'r--', V_irr2, P_irr2, 'g--', V_irr3, P_irr3, 'b--');
xlabel('Volume (m^3)'); ylabel('Pressure (Pa)');
title('P-V Diagram (Irreversible)'); legend('Adiabatic','Isobaric','Isothermal');

subplot(1,3,2);
T_irr1 = T1 * (V1 ./ V_irr1).^(gamma - 1);
T_irr2 = linspace(T2, T3, 100);
T_irr3 = T3 * ones(size(V_irr3));
plot(V_irr1, T_irr1, 'r--', V_irr2, T_irr2, 'g--', V_irr3, T_irr3, 'b--');
xlabel('Volume (m^3)'); ylabel('Temperature (K)');
title('T-V Diagram (Irreversible)'); legend('Adiabatic','Isobaric','Isothermal');

subplot(1,3,3);
P_irr_pt1 = linspace(P1, P2, 100);
T_irr_pt1 = linspace(T1, T2, 100);
P_irr_pt2 = linspace(P2, P3, 100);
T_irr_pt2 = linspace(T2, T3, 100);
P_irr_pt3 = linspace(P3, P4, 100);
T_irr_pt3 = T3 * ones(size(P_irr_pt3));
plot(P_irr_pt1, T_irr_pt1, 'r--', P_irr_pt2, T_irr_pt2, 'g--', P_irr_pt3, T_irr_pt3, 'b--');
xlabel('Pressure (Pa)'); ylabel('Temperature (K)');
title('P-T Diagram (Irreversible)'); legend('Adiabatic','Isobaric','Isothermal');