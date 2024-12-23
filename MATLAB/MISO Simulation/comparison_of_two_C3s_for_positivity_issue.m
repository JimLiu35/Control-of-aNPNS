% This script demonstrates the incapability of the guaranteed positivity of
% the feedforward controller C3 and directly compared with the feedback C3
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
% alpha = 80;     % Positivity is resolved with this value
alpha = 5;      % Positivity is lost with this value
K = 0.12;
beta = 75;
eta = 75;
Ks = 0.15;

% initial conditions
x0 = [0;1e-8;0;500e-9];
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
figure
subplot(4,1,1)
plot(simout_feedforward.ls_x.Time, simout_feedforward.ls_x.Data(:,1), 'LineWidth', 2, 'DisplayName', 'Feedforward C3')
hold on
grid on
plot(simout_feedback.ls_x.Time, simout_feedback.ls_x.Data(:,1), '--', 'LineWidth', 2, 'DisplayName', 'Feedback C3')
xlabel('Time [min]')
ylabel('Tissue Factor [M]')
hold off
ax = gca;
ax.FontSize = 12; 

subplot(4,1,2)
plot(simout_feedforward.ls_x.Time, simout_feedforward.ls_x.Data(:,2), 'LineWidth', 2, 'DisplayName', 'Feedforward C3')
hold on
grid on
plot(simout_feedback.ls_x.Time, simout_feedback.ls_x.Data(:,2), '--', 'LineWidth', 2, 'DisplayName', 'Feedback C3')
xlabel('Time [min]')
ylabel('VII [M]')
hold off
ax = gca;
ax.FontSize = 12; 

subplot(4,1,3)
plot(simout_feedforward.ls_x.Time, simout_feedforward.ls_x.Data(:,3), 'LineWidth', 2, 'DisplayName', 'Feedforward C3')
hold on
grid on
plot(simout_feedback.ls_x.Time, simout_feedback.ls_x.Data(:,3), '--', 'LineWidth', 2, 'DisplayName', 'Feedback C3')
xlabel('Time [min]')
ylabel('Xa [M]')
hold off
ax = gca;
ax.FontSize = 12; 

subplot(4,1,4)
plot(simout_feedforward.ls_x.Time, simout_feedforward.ls_x.Data(:,4), 'LineWidth', 2, 'DisplayName', 'Feedforward C3')
hold on
grid on
plot(simout_feedback.ls_x.Time, simout_feedback.ls_x.Data(:,4), '--', 'LineWidth', 2, 'DisplayName', 'Feedback C3')
xlabel('Time [min]')
ylabel('IIa [M]')
hold off
legend('Interpreter','latex')
fontname("Times New Roman")
ax = gca;
ax.FontSize = 12; 

figure('Position', [1 1 560 100])
plot(simout_feedforward.ls_x.Time, simout_feedforward.ls_x.Data(:,2), 'Color', "#EDB120", 'LineWidth', 2, 'DisplayName', '$u_{2_{ff}}$')
hold on
grid on
plot(simout_feedback.ls_x.Time, simout_feedback.ls_x.Data(:,2), 'magenta', 'LineWidth', 2, 'DisplayName', '$u_{2_{fb}}$')
xlabel('Time [min]')
ylabel('VII [M]')
legend('Interpreter','latex')
hold off
fontname("Times New Roman")
ax = gca;
ax.FontSize = 12; 
