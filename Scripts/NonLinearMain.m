%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Author: Jack Lambert
% Dale Lawrence
% Aircraft Dynmaics Homework 3
% Problem 2 and 4
% Purpose: This function gives ODE45 all the differntial equations to
% iterate through over each time step for the Non-Linear Model. Also
% implements a feedback control when initiated by global variable x = 1
% Date Modefied: 2/12/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dydt] = NonLinearMain(t,y)

global x

%% Contstants
mass = 68/1000; % [kg]
L_arm = 6/100; % [m]
eta = 1*10^(-3); % Aerodynamic Coefficient for drag [N /(m/s)^2]
zeta = 3*1^(-3);  % Aerodynamic Coefficient for drag [N /(m/s)^2]
alpha = 2*10^(-6); % Aerodynamic Coefficient for drag [N /(rad/s)^2]
beta = 1*10^(-6); % Aerodynamic Coefficient for drag [N /(rad/s)^2]
Ix = 6.8*10^(-5); % MOI about x-axis [kg*m^2]
Iy = 9.2*10^(-5); % MOI about x-axis [kg*m^2]
Iz = 1.35*10^(-4); % MOI about x-axis [kg*m^2]
R = sqrt(2)/2*L_arm; % Distance to COG [m]
k = 0.0024; % [m]
g = 9.81; % [m/s^2]

%% Forces about each Motor
f1 = (mass*g)/4; % Force for steady Level Flight about Motor 1 [N]
f2 = (mass*g)/4; % Force for steady Level Flight about Motor 2 [N]
f3 = (mass*g)/4; % Force for steady Level Flight about Motor 3 [N]
f4 = (mass*g)/4; % Force for steady Level Flight about Motor 4 [N]

%% Derivatives to be Integrated

% Translational Motion
dx = y(1); % N - location
dy = y(2); % E - location
dz = y(3); % -D - location
Vx = y(4); % u - component of velocity
Vy = y(5); % v compenent of velocity
Vz = y(6); % w component of velocity

% Rotational Motion
phi = y(7); % Attitude Euler Angles
theta = y(8); % Attitude Euler Angles
psi = y(9); % Attitude Euler Angles
p = y(10); % Angular velocity about the x-axis [rad/s]
q = y(11); % Angular Velocity about the y-axis [rad/s]
r = y(12); % Angular Velocity about the z-axis [rad/s]

%% Velocity
% Redefining for context
u = Vx;
v = Vy;
w = Vz;

%% Forces to Acceleration

% Aerodynimc Forces
A_c = [0 0 -(f1+f2+f3+f4)]; % Control Forces
A_a = [-eta*u^2*sign(u) -eta*v^2*sign(v) -zeta*w^2*sign(w)]; % Aerodynamics Forces
A_b = A_c + A_a; % Combined Forces

% Kinematic Equations
dydt(1) = u*cos(theta)*cos(psi)+ v*(sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi))...
    + w*(cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi)); 
dydt(2) = u*cos(theta)*sin(psi)+ v*(sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi))...
    + w*(cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi));
dydt(3) = -u*sin(theta)+v*sin(phi)*cos(theta)+w*cos(phi)*cos(theta);
dydt(4) = (A_b(1)-mass*g*sin(theta))/mass;
dydt(5) = (A_b(2)+mass*g*cos(theta)*sin(phi))/mass;
dydt(6) = (A_b(3)+mass*g*cos(theta)*cos(phi))/mass;

%% Moments to Rotations
G_a = [-(alpha*p^2)*sign(p) -(alpha*q^2)*sign(q) -(beta*r^2)*sign(r)]; % Aerodynamic Moments
G_c = [R*(f2+f3-f1-f4) R*(f3+f4-f2-f1) k*(f2+f4-f1-f2)]; % Control Moments

% Adding Feedbck Control
if x == 1
    Feedback = [-0.003*p -0.003*q -0.0012*r];
else
    Feedback = [0 0 0];
end
        
G_b = G_a + G_c + Feedback;
% Kinemeatic Equations
dydt(7) = p + (q*sin(phi)+r*cos(phi))*tan(theta);
dydt(8) = q*cos(phi)-r*sin(phi);
dydt(9) = (q*sin(phi)+r*cos(phi))*sec(theta);
dydt(10) = (G_b(1)+q*r*(Iy - Iz))/Ix;
dydt(11) = (G_b(2)+r*p*(Iz-Ix))/Iy;
dydt(12) = (G_b(3)+p*q*(Ix-Iy))/Iz;

dydt = dydt';
