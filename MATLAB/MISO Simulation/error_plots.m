% Error plots
clear
close all
clc

% Case 1
% % system parameters
% params.kd1 = 0.1370;
% params.kd2 = 1.2523;
% params.kd3 = 1.2622;
% params.kd4 = 1.0137;
% params.kp2 = 1.812e-11;
% params.kn4 = 1;
% params.x20 = 1e-8;
% params.beta = 0.1370/params.x20;
% params.gamma = 1/params.x20;
% % controller parameters
% gamma_hat = 1;
% kd_hat = 1;
% Lambda = .1;
% alpha = 5;
% K = 0.15;
% beta = 75;
% eta = 50;
% Ks = 0.0224;

% initial conditions
x0 = [0;1e-8;0;500e-9];
xr0 = 0;
e3_0 = 2*(xr0 - x0(4));

% Case 2
% System parameters for Case 2
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
alpha = 80;
K = 0.12;
beta = 75;
eta = 75;
Ks = 0.15;

% run simulation with feedback control
simout = sim('nonlinear_vs_linear.slx');
error_feedback = simout.ns_x.Data(:,4) - simout.xr.Data(:,1);

figure(1)
plot(simout.e1.Time, error_feedback, 'DisplayName', 'Feedback', 'LineWidth', 2)
hold on
grid on

% run simulation with feedforward control
simout = sim('nonlinear_vs_linear.slx');
error_feedforward = simout.ns_x.Data(:,4) - simout.xr.Data(:,1);
figure(1)
plot(simout.e1.Time, error_feedforward, 'DisplayName', 'Feedforward', 'LineWidth', 2)
xlabel('Time [min]')
ylabel('e [nM]')
title('Error')
legend('Location','best')