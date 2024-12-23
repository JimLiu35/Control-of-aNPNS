function xdot = nonlinear_ode(x, u, params)
x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);

x1dot = -params.kd1*x1 - params.beta*x1*x2 + u;
x2dot = params.kp2 - params.kd2*x2 - params.beta*x1*x2 + u;
x3dot = params.gamma*x1*x2 - params.kd3*x3;
x4dot = params.kn4*x3 - params.kd4*x4;

xdot = [x1dot x2dot x3dot x4dot]';