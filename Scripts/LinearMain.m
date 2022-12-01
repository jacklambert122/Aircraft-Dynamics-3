%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Author: Jack Lambert
% Dale Lawrence
% Aircraft Dynmaics Homework 3
% Problem 3
% Purpose: This function gives ODE45 all the differntial equations to
% iterate through over each time step for the Linear Model
% Date Modefied: 2/12/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dydt] = LinearMain(t,y)

%% Constants
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

% Changes in Forces about each motor
delta_f1 = 0; % Force for steady Level Flight about Motor 1
delta_f2 = 0; % Force for steady Level Flight about Motor 1
delta_f3 = 0; % Force for steady Level Flight about Motor 1
delta_f4 = 0; % Force for steady Level Flight about Motor 1

%% Derivatives to be Integrated

% Translational Motion
delta_xE = y(1); % N - location
delta_yE = y(2); % E - location
delta_zE = y(3); % -D - location
delta_u = y(4); % u - component of velocity
delta_v = y(5); % v compenent of velocity
delta_w = y(6); % w component of velocity

% Rotational Motion
delta_phi = y(7); % Bank [rad]
delta_theta = y(8); % Pitch [rad]
delta_psi = y(9); % Azimuth [rad]
delta_p = y(10); % Roll Rate [rad/s]
delta_q = y(11); % Pitch Rate [rad/s]
delta_r = y(12); % Yaw Rate [rad/s]

% Transformation matrix expanded for position in inertial to position in
% body
dydt(1) = delta_u*cos(delta_theta)*cos(delta_psi)+ delta_v*(sin(delta_phi)*sin(delta_theta)*cos(delta_psi)-cos(delta_phi)*sin(delta_psi))...
    + delta_w*(cos(delta_phi)*sin(delta_theta)*cos(delta_psi)+sin(delta_phi)*sin(delta_psi)); 
dydt(2) = delta_u*cos(delta_theta)*sin(delta_psi)+ delta_v*(sin(delta_phi)*sin(delta_theta)*sin(delta_psi)+cos(delta_phi)*cos(delta_psi))...
    + delta_w*(cos(delta_phi)*sin(delta_theta)*sin(delta_psi)-sin(delta_phi)*cos(delta_psi));
dydt(3) = -delta_u*sin(delta_theta)+delta_v*sin(delta_phi)*cos(delta_theta)+delta_w*cos(delta_phi)*cos(delta_theta);

% delta_Udot delta_Vdot delta_Wdot
dydt(4) = -g*delta_theta;
dydt(5) = g*delta_phi;
dydt(6) = -(delta_f1 + delta_f2 + delta_f3 + delta_f4 )/mass;

%% Moments to Rotations
dydt(7) = delta_p;
dydt(8) = delta_q;
dydt(9) = delta_r;
dydt(10) = (R/Ix)*(delta_f2 + delta_f3 - delta_f1 - delta_f4);
dydt(11) = (R/Iy)*(delta_f3 + delta_f4 - delta_f2 - delta_f1);
dydt(12) = (k/Iz)*(delta_f3 + delta_f4 - delta_f1 - delta_f2);

dydt = dydt';