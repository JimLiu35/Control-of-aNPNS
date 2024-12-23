% This script sets up necessary parameters, run simulations, and perform
% analysis of the simulation data

clear
close all
clc

% parameters
params.kd1 = 0.1370;
params.kd2 = 1.2523;
params.kd3 = 1.2622;
params.kd4 = 1.0137;
params.kp2 = 1.812e-11;
params.kn4 = 1;
params.x20 = 1e-8;
params.beta = 0.1370/params.x20;
params.gamma = 1/params.x20;

gamma_hat = 1;
kd_hat = 1;
Lambda = .1;
alpha = 5;
K = 0.15;
beta = 75;
eta = 50;
Ks = 0.0224;
% Ks = 0.1;
% e3_0 = 0;

% initial conditions
% x0 = [5e-9;1e-8;0;500e-9];
x0 = [0;1e-8;0;500e-9];
xr0 = 0;
% xr_ss = 30e-9;
e3_0 = 2*(xr0 - x0(4));

% run simulation
simout = sim('nonlinear_vs_linear.slx');

% plots
figure(1)
subplot(4,1,1)
plot(simout.ns_x.Time, simout.ns_x.Data(:,1), 'DisplayName', 'Nonlinear$', 'LineWidth', 2)
hold on
grid on
plot(simout.ls_x.Time, simout.ls_x.Data(:,1), 'r', 'DisplayName', 'Linear$', 'LineWidth', 2)
% legend('Interpreter','latex')
xlabel('Time [min]')
ylabel('Tissue Factor [M]')
hold off
ax = gca;
ax.FontSize = 12; 

subplot(4,1,2)
plot(simout.ns_x.Time, simout.ns_x.Data(:,2), 'DisplayName', 'Nonlinear$', 'LineWidth', 2)
hold on
grid on
plot(simout.ls_x.Time, simout.ls_x.Data(:,2), 'r', 'DisplayName', 'Linear$', 'LineWidth', 2)
% legend('Interpreter','latex')
xlabel('Time [min]')
ylabel('VII [M]')
hold off
ax = gca;
ax.FontSize = 12; 

subplot(4,1,3)
plot(simout.ns_x.Time, simout.ns_x.Data(:,3), 'DisplayName', 'Nonlinear$', 'LineWidth', 2)
hold on
grid on
plot(simout.ls_x.Time, simout.ls_x.Data(:,3), 'r', 'DisplayName', 'Linear$', 'LineWidth', 2)
% legend('Interpreter','latex')
xlabel('Time [min]')
ylabel('Xa [M]')
hold off
ax = gca;
ax.FontSize = 12; 

subplot(4,1,4)
plot(simout.ns_x.Time, simout.ns_x.Data(:,4), 'DisplayName', 'Nonlinear', 'LineWidth', 2)
grid on
hold on
plot(simout.xr.Time, simout.xr.Data(:,1), 'black', 'DisplayName', '$x_r(t)$', 'LineWidth', 2)
plot(simout.ls_x.Time, simout.ls_x.Data(:,4), 'r', 'DisplayName', 'Linear', 'LineWidth', 2)
legend('Interpreter','latex')
xlabel('Time [min]')
ylabel('IIa [M]')
% sgtitle('PNS vs Linearization', 'FontSize', 18)
fontname("Times New Roman")
ax = gca;
ax.FontSize = 12; 


% figure(1)
% subplot(4,1,1)
% plot(simout.ns_x.Time, simout.ns_x.Data(:,1), 'DisplayName', '$x_1(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('Tissue Factor [M]')
% subplot(4,1,2)
% plot(simout.ns_x.Time, simout.ns_x.Data(:,2), 'DisplayName', '$x_2(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('VII [M]')
% subplot(4,1,3)
% plot(simout.ns_x.Time, simout.ns_x.Data(:,3), 'DisplayName', '$x_3(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('Xa [M]')
% subplot(4,1,4)
% plot(simout.ns_x.Time, simout.ns_x.Data(:,4), 'DisplayName', '$x_4(t)$', 'LineWidth', 2)
% grid on
% hold on
% plot(simout.xr.Time, simout.xr.Data(:,1), 'DisplayName', '$x_r(t)$', 'LineWidth', 2)
% hold off
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('IIa [M]')
% sgtitle('MISO Positive Nonlinear System')
% 
% figure(2)
% subplot(4,1,1)
% plot(simout.ls_x.Time, simout.ls_x.Data(:,1), 'DisplayName', '$x_1(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('Tissue Factor [M]')
% subplot(4,1,2)
% plot(simout.ls_x.Time, simout.ls_x.Data(:,2), 'DisplayName', '$x_2(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('VII [M]')
% subplot(4,1,3)
% plot(simout.ls_x.Time, simout.ls_x.Data(:,3), 'DisplayName', '$x_3(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('Xa [M]')
% subplot(4,1,4)
% plot(simout.ls_x.Time, simout.ls_x.Data(:,4), 'DisplayName', '$x_4(t)$', 'LineWidth', 2)
% grid on
% hold on
% plot(simout.xr.Time, simout.xr.Data(:,1), 'DisplayName', '$x_r(t)$', 'LineWidth', 2)
% hold off
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('IIa [M]')
% sgtitle('MISO Linearized System')
% 
% figure(3)
% subplot(2,1,1)
% plot(simout.u.Time, simout.u.Data(:,1), 'DisplayName', '$u_1$', 'LineWidth', 2)
% hold on
% grid on
% plot(simout.g_uTau.Time, simout.g_uTau.Data(:,1), 'DisplayName', '$g_(u_1)$', 'LineWidth', 2)
% xlabel('Time [min]')
% ylabel('Tissue Factor [M]')
% legend('Interpreter', 'latex', 'Location', 'best')
% hold off
% subplot(2,1,2)
% plot(simout.u2.Time, simout.u2.Data(:,1), 'DisplayName', '$u_2$', 'LineWidth', 2)
% grid on
% xlabel('Time [min]')
% ylabel('Factor VII [M]')
% axis([0 simout.u2.Time(end) 0 1e-7])
% legend('Interpreter', 'latex', 'Location', 'best')
% sgtitle('Input Signals')

