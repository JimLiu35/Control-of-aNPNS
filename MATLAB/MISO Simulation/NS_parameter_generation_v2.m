% This script calculates coefficients for the Damon's nonlinear model that
% can produce the same TF function obtained from patient's CAT profile
function params_struct = NS_parameter_generation_v2(actualTFparams)
% Input: actual_TF_params in the form of [K0, K1, K2, Kn]
% Output: params for the Damon's Nonlinear System
params0 = ones(6,1);
options = optimset('MaxFunEvals',1e6,'MaxIter',1e6,'TolFun',1e-12,'TolX',1e-12);
% actualTFparams = [0.3505;1.903;2.54;1]; % [K0, K1, K2, Kn]
% actualTFparams = [0.8003; 3.6071; 2.6172; 364.3693];
x20 = 1;
[params, ] = lsqcurvefit(@coeffFit, params0, x20, actualTFparams, [], [], options);
kd1 = params(1);
kd2 = 1.812e-3;
kd3 = params(2);
kd4 = params(3);
beta = params(4);
gamma = params(5);
kn4 = params(6);

k0 = kd1*kd3*kd4 + beta*kd3*kd4*x20;
k1 = kd1*kd3 + kd1*kd4 + kd3*kd4 + beta*kd3*x20 + beta*kd4*x20;
k2 = kd1 + kd2 + kd4 + beta*x20;
kn = gamma * kn4*x20;

num = kn;
den = [1 k2 k1 k0];

% s = tf('s');
fittedTF = tf(num, den)

params_struct.kd1 = params(1);
params_struct.kd2 = 1.812e-3;
params_struct.kd3 = params(2);
params_struct.kd4 = params(3);
params_struct.beta = params(4);
params_struct.gamma = params(5);
params_struct.kn4 = params(6);
params_struct.kp2 = 1.812e-11;
end

function estimatedTFparams = coeffFit(params, x20)
kd1 = params(1);
kd2 = 1.812e-3;
kd3 = params(2);
kd4 = params(3);
beta = params(4);
gamma = params(5);
kn4 = params(6);

k0 = kd1*kd3*kd4 + beta*kd3*kd4*x20;
k1 = kd1*kd3 + kd1*kd4 + kd3*kd4 + beta*kd3*x20 + beta*kd4*x20;
k2 = kd1 + kd2 + kd4 + beta*x20;
kn = gamma * kn4*x20;

estimatedTFparams = [k0;k1;k2;kn];

end