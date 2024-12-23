% This script shows the robustness of our controller when the gap metric is
% 1
clear
close all
clc

% Case 2: Use real trauma patient's data
actual_TF_params = [6.160505286	0.022829429	0.201408369	0.567863564]';
params = NS_parameter_generation(actual_TF_params);
params.x20 = 1e-8;
params.gamma = params.gamma/params.x20;
params.beta = params.beta/params.x20;
params.kp2 = params.x20*params.kd2;

% Controler parameters for Case 2
gamma_hat = 1;
kd_hat = 1;
Lambda = .08;
alpha = 80;     % Positivity is resolved with this value
% alpha = 5;      % Positivity is lost with this value
K = 0.12;
beta = 75;
eta = 75;
Ks = 0.15;

% initial conditions
x0 = [5e-9;0;0;500e-9];
xr0 = 0;
e3_0 = 2*(xr0 - x0(4));

% run simulation with the feedforward controller C3
% Note you have to manually switch the controller in the SimuLink File
simout_feedforward = sim('nonlinear_vs_linear.slx', StopTime="80");

% run simulation with the feedforward controller C3
% Set a Breakpoint HERE! Manually switch the controller to feedback C3 and
% then continue this script!
simout_feedback = sim('nonlinear_vs_linear.slx', StopTime="80");

% Plots
figure('Position', [1 1 560 100])
plot(simout_feedforward.ns_x.Time, simout_feedforward.ns_x.Data(:,4), 'Color', "#EDB120",'LineWidth', 2, 'DisplayName', '$u_{2_{ff}}$')
hold on
grid on
plot(simout_feedback.ns_x.Time, simout_feedback.ns_x.Data(:,4), 'magenta', 'LineWidth', 2, 'DisplayName', '$u_{2_{fb}}$')
plot(simout_feedback.xr.Time, simout_feedback.xr.Data(:,1), 'black', 'DisplayName', '$x_r(t)$', 'LineWidth', 2)
xlabel('Time [min]')
ylabel('IIa [M]')
legend('Interpreter','latex')
hold off
fontname("Times New Roman")
ax = gca;
ax.FontSize = 12; 