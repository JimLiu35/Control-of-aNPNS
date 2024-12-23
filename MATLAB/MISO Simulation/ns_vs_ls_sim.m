% This script sets up necessary parameters, run simulations, and perform
% analysis of the simulation data

clear
close all
clc

% parameters
% params.kd1 = 0.477808235763175;
% params.kd2 = 1.670914338660144;
% params.kd3 = 3.575293167268536;
% params.kd4 = 0.30745;
% params.kn4 = 0.468477366595364;
% params.x20 = 1e-8;
% params.kp2 = params.x20*params.kd2;
% params.beta = 0.999999390091586/params.x20;
% params.gamma = 1/params.x20;

% Fix kp2 to be small
% params.kd1 = 1.149681189411308;
% params.kd2 = 0.001812000000000;
% params.kd3 = 1.101344259493053;
% params.kd4 = 0.316025629130475;
% params.kn4 = 19.088459864535952;
% params.x20 = 1e-8;
% % params.kp2 = params.x20*params.kd2;
% params.kp2 = 1.812e-11;
% params.beta = 1.149681181458218/params.x20;
% params.gamma = 19.088459864535956/params.x20;

% Unfix kp2
% params.kd1 = 0.480902529222521;
% params.kd2 = 0.472940533013932;
% params.kd3 = 0.992888299485304;
% params.kd4 = 0.632602597429223;
% params.kn4 = 12.289207647362785;
% params.x20 = 1e-8;
% params.kp2 = params.x20*params.kd2;
% % params.kp2 = 1.812e-11;
% params.beta = 0.480902525334324/params.x20;
% params.gamma = 12.289207647362790/params.x20;

% params.kd1 = 0.1370;
% params.kd2 = 1.2523;
% params.kd3 = 1.2622;
% params.kd4 = 1.0137;
% params.kp2 = 1.812e-11;
% params.kn4 = 1;
% params.x20 = 1e-8;
% params.beta = 0.1370/params.x20;
% % params.beta = 0.1370;
% params.gamma = 1/params.x20;
% % params.gamma = 1;

% System parameters for Case 2
actual_TF_params = [6.160505286	0.022829429	0.201408369	0.567863564]';
params = NS_parameter_generation(actual_TF_params);
params.x20 = 1e-8;      % The equilibrium value of x2
params.gamma = params.gamma/params.x20;
params.beta = params.beta/params.x20;
params.kp2 = params.x20*params.kd2;

% Controler parameters for Case 1
% gamma_hat = 1;
% kd_hat = 1;
% Lambda = .1;
% alpha = 5;
% K = 0.15;
% beta = 75;
% eta = 50;
% Ks = 0.0224;

% Controler parameters for Case 2
gamma_hat = 1;
kd_hat = 1;
Lambda = .08;
alpha = 80;
% alpha = 5;
K = 0.12;
beta = 75;
eta = 75;
Ks = 0.15;

% initial conditions
% x0 = [5e-9;1e-8;0;100e-9];
x0 = [5e-9;0e-5;0;500e-9];
xr0 = 0;
% xr_ss = 30e-9;
e3_0 = 2*(xr0 - x0(4));

% u2 calculation
% u2 = params.kd2*params.x20 + params.beta/params.gamma*params.kd3*params.kd4/params.kn4*xr_ss;

% run simulation
simout = sim('nonlinear_vs_linear.slx');

% % run 3-dim simulation
% clear params
% params = Automatica_parameter_generation(actual_TF_params);

% plots
figure(1)
subplot(4,1,1)
plot(simout.ns_x.Time, simout.ns_x.Data(:,1), 'DisplayName', 'Nonlinear$', 'LineWidth', 2)
hold on
grid on
plot(simout.ls_x.Time, simout.ls_x.Data(:,1), 'r--', 'DisplayName', 'Linear$', 'LineWidth', 2)
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
plot(simout.ls_x.Time, simout.ls_x.Data(:,2), 'r--', 'DisplayName', 'Linear$', 'LineWidth', 2)
if min(simout.ls_x.Data(:,2) > 0)
    axis([0 80 0 inf])
end
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
plot(simout.ls_x.Time, simout.ls_x.Data(:,3), 'r--', 'DisplayName', 'Linear$', 'LineWidth', 2)
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
plot(simout.ls_x.Time, simout.ls_x.Data(:,4), 'r--', 'DisplayName', 'Linear', 'LineWidth', 2)
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
% ax = gca;
% ax.FontSize = 20; 
% 
% subplot(4,1,2)
% plot(simout.ns_x.Time, simout.ns_x.Data(:,2), 'DisplayName', '$x_2(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('VII [M]')
% ax = gca;
% ax.FontSize = 20; 
% 
% subplot(4,1,3)
% plot(simout.ns_x.Time, simout.ns_x.Data(:,3), 'DisplayName', '$x_3(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('Xa [M]')
% ax = gca;
% ax.FontSize = 20; 
% 
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
% ax = gca;
% ax.FontSize = 20; 
% 
% figure(2)
% subplot(4,1,1)
% plot(simout.ls_x.Time, simout.ls_x.Data(:,1), 'DisplayName', '$x_1(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('Tissue Factor [M]')
% ax = gca;
% ax.FontSize = 20; 
% 
% subplot(4,1,2)
% plot(simout.ls_x.Time, simout.ls_x.Data(:,2), 'DisplayName', '$x_2(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('VII [M]')
% ax = gca;
% ax.FontSize = 20; 
% 
% subplot(4,1,3)
% plot(simout.ls_x.Time, simout.ls_x.Data(:,3), 'DisplayName', '$x_3(t)$', 'LineWidth', 2)
% grid on
% legend('Interpreter','latex')
% xlabel('Time [min]')
% ylabel('Xa [M]')
% ax = gca;
% ax.FontSize = 20; 
% 
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
% ax = gca;
% ax.FontSize = 20; 
% 
figure(2)
subplot(2,1,1)
plot(simout.u.Time, simout.u.Data(:,1), 'DisplayName', '$u_1$', 'LineWidth', 2)
hold on
grid on
plot(simout.g_uTau.Time, simout.g_uTau.Data(:,1), 'DisplayName', '$g_(u_1)$', 'LineWidth', 2)
xlabel('Time [min]')
ylabel('Tissue Factor [M]')
legend('Interpreter', 'latex', 'Location', 'best')
hold off
ax = gca;
ax.FontSize = 12; 

subplot(2,1,2)
plot(simout.u2.Time, simout.u2.Data(:,1), 'DisplayName', '$u_2$', 'LineWidth', 2)
grid on
xlabel('Time [min]')
ylabel('Factor VII [M]')
% axis([0 simout.u2.Time(end) 0 1e-7])
legend('Interpreter', 'latex', 'Location', 'best')
ax = gca;
ax.FontSize = 12; 

% subplot(3,1,3)
% plot(simout.Tau_actual_ls.Time, simout.Tau_actual_ls.Data(:,1), 'DisplayName', '$\tau$', 'LineWidth', 2)
% grid on
% xlabel('Time [min]')
% ylabel('Actual Delay [min]')
% legend('Interpreter', 'latex', 'Location', 'best')
% sgtitle('Input Signals and Time Delay')
% ax = gca;
% ax.FontSize = 20; 
