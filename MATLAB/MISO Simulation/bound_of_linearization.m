% This script finds a conservative bound for the linearization
% approximation
clear
close all
clc

% Load parameters
actual_TF_params = [6.160505286	0.022829429	0.201408369	0.567863564]';
params = NS_parameter_generation(actual_TF_params);
params.x20 = 1e-8;
params.gamma = params.gamma/params.x20;
params.beta = params.beta/params.x20;
params.kp2 = params.x20*params.kd2;

% Calculate the gap metric
% syms kd1 kd2 kd3 kd4 kn4 beta gamma x1op x2op s real
% A = [-kd1-beta*x2op -beta*x1op 0 0;
%      -beta*x2op -kd2-beta*x1op 0 0;
%      gamma*x2op gamma*x1op -kd3 0;
%      0 0 kn4 -kd4];
% B = [1 0 0 0]';
% C = [0 0 0 1];
% s = tf('s');

% TF_op = simplify(C\(s*eye(4)-A)*B);
kn = params.gamma*params.kn4*params.x20;
k0 = params.kd1*params.kd3*params.kd4 + params.beta*params.kd3*params.kd4*params.x20;
k1 = params.kd1*params.kd3 + params.kd1*params.kd4 + params.kd3*params.kd4 + params.beta*params.kd3*params.x20 + ...
    params.beta*params.kd4*params.x20;
k2 = params.kd1 + params.kd3 + params.kd4 + params.beta*params.x20;
TF_bl = tf(kn, [1 k2 k1 k0]);

% TF_op
x1op = 5e-9;
x2op = 1e-5;
n1 = params.gamma*params.kn4*x2op;
n0 = params.gamma*params.kn4*x2op*params.kd2;

d3 = params.kd1 + params.kd2 + params.kd3 + params.kd4 + params.beta*x1op + params.beta*x2op;
d2 = (params.kd1*params.kd2 + params.beta*params.kd1*x1op + params.beta*params.kd2*x2op) + ...
    (params.kd3 + params.kd4)*(params.kd1 + params.kd2 + params.beta*x1op + params.beta*x2op) + params.kd3*params.kd4;
d1 = (params.kd3 + params.kd4)*(params.kd1*params.kd2 + params.beta*params.kd1*x1op + params.beta*params.kd2*x2op) + ...
    params.kd3*params.kd4*(params.kd1 + params.kd2 + params.beta*x1op + params.beta*x2op);
d0 = params.kd3*params.kd4*(params.kd1*params.kd2 + params.beta*params.kd1*x1op + params.beta*params.kd2*x2op);

TF_op = tf([n1 n0], [1 d3 d2 d1 d0]);

% compute the gap metric
[gap,nugap] = gapmetric(TF_bl,TF_op);




