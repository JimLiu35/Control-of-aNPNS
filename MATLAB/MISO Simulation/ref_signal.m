function xr = ref_signal(t)

% regulation
% xr=130*(tanh(0.15*t)^2)*1e-9;

% sinusoidal tracking
xr = (130 + 50*sin(0.17*t))*1e-9;