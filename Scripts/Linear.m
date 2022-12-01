%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Jack Lambert
% Dale Lawrence
% Aircraft Dynmaics Homework 3
% Problem 3
% Purpose: This code gives the intial conditions for both the linear and
% non-linear models for ode45 to compute the diffeential equations. This
% function then plots the the trajectories and attitide for the linear and
% non-linear models with the variations in thier inital conditions whoch
% are set in an inital conditions matrix and iterated through for each case
% Date Modefied: 2/12/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global x

%% Nominal Condition for Steady Hovering Flight
xE_0 = [0 0 0 0 0 0]; % N - location [m]
yE_0 = [0 0 0 0 0 0]; % E - location [m]
zE_0 = [ 0 0 0 0 0 0]; % -D - location [m]
u_0 = [0 0 0 0 0 0]; % u - component of velocity [m/s]
v_0 = [0 0 0 0 0 0]; % v compenent of velocity [m/s]
w_0 = [0 0 0 0 0 0]; % w component of velocity [m/s]

% Rotational Motion
phi_0 = [0 0 0 0 0 0]; % Phi Euler Angle [rad]
theta_0 = [0 0 0 0 0 0]; % Theta Euler Angle [rad]
psi_0 = [0 0 0 0 0 0]; % Psi Euler Angle [rad]
p_0 = [0 0 0 0 0 0]; % Angular velocity about the x-axis [rad/s]
q_0 = [0 0 0 0 0 0]; % Angular Velocity about the y-axis [rad/s]
r_0 = [0 0 0 0 0 0]; % Angular Velocity about the z-axis [rad/s]

%% Pertubations
delta_xE = [0 0 0 0 0 0]; % N - location [m]
delta_yE = [0 0 0 0 0 0]; % E - location [m]
delta_zE = [0 0 0 0 0 0]; % -D - location [m]
delta_u = [0 0 0 0 0 0]; % u - component of velocity [m/s]
delta_v = [0 0 0 0 0 0]; % v compenent of velocity [m/s]
delta_w = [0 0 0 0 0 0]; % w component of velocity [m/s]

% Rotational Motion
delta_phi = [5*(pi/180) 0 0 0 0 0]; % Phi Euler Angle [rad]
delta_theta = [0 5*(pi/180) 0 0 0 0]; % Theta Euler Angle [rad]
delta_psi = [0 0 5*(pi/180) 0 0 0]; % Psi Euler Angle [rad]
delta_p = [0 0 0 0.1 0 0]; % Angular velocity about the x-axis [rad/s]
delta_q = [0 0 0 0 0.1 0]; % Angular Velocity about the y-axis [rad/s]
delta_r = [0 0 0 0 0 0.1]; % Angular Velocity about the z-axis [rad/s]

%% Initial Conditions for Non-Linear Case
c1 = [0 0 0 0 0 0]; % N - location [m]
c2 = [0 0 0 0 0 0]; % E - location [m]
c3 = [0 0 0 0 0 0]; % -D - location [m]
c4 = [0 0 0 0 0 0]; % u - component of velocity [m/s]
c5 = [0 0 0 0 0 0]; % v compenent of velocity [m/s]
c6 = [0 0 0 0 0 0]; % w component of velocity [m/s]

% Rotational Motion
c7 = [5*(pi/180) 0 0 0 0 0]; % Phi Euler Angle [rad]
c8 = [0 5*(pi/180) 0 0 0 0]; % Theta Euler Angle [rad]
c9 = [0 0 5*(pi/180) 0 0 0]; % Psi Euler Angle [rad]
c10 = [0 0 0 0.1 0 0]; % Roll Rate [rad/s]
c11 = [0 0 0 0 0.1 0]; % Pitch rate [rad/s]
c12 = [0 0 0 0 0 0.1]; % Yaw Rate [rad/s]

%% Running through each of the Cases for the Variations

% Linear Case
for i = 1:6
    conditionL{i}= [(delta_xE(i)+xE_0(i))   (delta_yE(i)+yE_0(i))       (delta_zE(i)+zE_0(i))...
                    (delta_u(i)+u_0(i))     (delta_v(i)+v_0(i))         (delta_w(i)+w_0(i))...
                    (delta_phi(i)+phi_0(i)) (delta_theta(i)+theta_0(i)) (delta_psi(i)+psi_0(i))...
                    (delta_p(i)+p_0(i))     (delta_q(i)+q_0(i))         (delta_r(i)+r_0(i))]; 
end

% Non-Linear Case
for i = 1:6
    conditionNL{i}= [c1(i) c2(i) c3(i) c4(i) c5(i) c6(i) c7(i) c8(i) c9(i) c10(i) c11(i) c12(i)]; 
end

%% Devaitations for Non Linear Case
string = ["+5 [deg] Bank","+5 [deg] Pitch","+5 [deg] Azimuth",...
    "+0.1 [rad/s] Roll Rate", "+0.1 [rad/s] Pitch Rate", "+0.1 [rad/s] Yaw Rate"];
x = 0;
for i = 1:6
    [tNL,zNL] = ode45('NonLinearMain',[0 5],conditionNL{i});
    [tL,zL] = ode45('LinearMain',[0 5],conditionL{i});
    figure(i)
    plot3(zNL(:,1),zNL(:,2),-zNL(:,3),'-o')
    hold on
    plot3(zL(:,1),zL(:,2),-zL(:,3),'-o')
    tit = sprintf('%s %s','Trajectory of Quad-Copter w/',string(i));
    title(tit)
    xlabel('N Displacement [m]')
    ylabel('E Displacement [m]')
    zlabel('-D Displacement [m]')
    legend('Non-Linear','Linear')
    axis equal
end

%% Plotting Rotation Differences
for i = 1:6
    [tNL,zNL] = ode45('NonLinearMain',[0 2],conditionNL{i});
    [tL,zL] = ode45('LinearMain',[0 2],conditionL{i});
    tit = sprintf('%s %s','Trajectory of Quad-Copter w/',string(i));
    if i == 1 
        % Plots Changes in Phi vs. Time
        figure
        plot(tNL,zNL(:,7),'LineWidth',1)
        hold on
        plot(tL,zL(:,7),'LineWidth',1)
        hold off
        title(tit)
        xlabel('time [s]')
        ylabel('Bank [rad]')
        legend('Non-Linear','Linear')
        
    elseif i == 2
        % Plots Changes in theta versus time
        figure
        plot(tNL,zNL(:,8),'LineWidth',1)
        hold on
        plot(tL,zL(:,8),'LineWidth',1)
        hold off
        title(tit)
        xlabel('time [s]')
        ylabel('Pitch [rad]')
        legend('Non-Linear','Linear')
        
    elseif i == 3
        % Plots changes in the azmimuth versus time
        figure
        plot(tNL,zNL(:,9),'LineWidth',1)
        hold on
        plot(tL,zL(:,9),'LineWidth',1)
        hold off
        title(tit)
        xlabel('time [s]')
        ylabel('Azimuth [rad]')
        legend('Non-Linear','Linear')
        
    elseif i == 4
        % Plots Changes in Roll Rate vs time
        figure
        plot(tNL,zNL(:,10),'LineWidth',1)
        hold on
        plot(tL,zL(:,10),'LineWidth',1)
        hold off
        title(tit)
        xlabel('time [s]')
        ylabel('Roll Rate [rad/s]')
        legend('Non-Linear','Linear')
        
        figure
        plot(tNL,zNL(:,7),'LineWidth',1)
        hold on
        plot(tL,zL(:,7),'LineWidth',1)
        hold off
        title(tit)
        xlabel('time [s]')
        ylabel('Bank [rad]')
        legend('Non-Linear','Linear')


    elseif i == 5
        % Plots changes in Pitch versus time
        figure
        plot(tNL,zNL(:,11),'LineWidth',1)
        hold on
        plot(tL,zL(:,11),'LineWidth',1)
        hold off
        title(tit)
        xlabel('time [s]')
        ylabel('Pitch rate [rad/s]')
        legend('Non-Linear','Linear')
        
        figure
        plot(tNL,zNL(:,8),'LineWidth',1)
        hold on
        plot(tL,zL(:,8),'LineWidth',1)
        hold off
        title(tit)
        xlabel('time [s]')
        ylabel('Pitch [rad]')
        legend('Non-Linear','Linear')
        

    else 
        % Plots changes in yaw rate versus time
        figure
        plot(tNL,zNL(:,12),'LineWidth',1)
        hold on
        plot(tL,zL(:,12),'LineWidth',1)
        hold off
        title(tit)
        xlabel('time [s]')
        ylabel('Yaw Rate [rad/s]')
        legend('Non-Linear','Linear')
        axis equal
        
        figure
        plot(tNL,zNL(:,9),'LineWidth',1)
        hold on
        plot(tL,zL(:,9),'LineWidth',1)
        hold off
        title(tit)
        xlabel('time [s]')
        ylabel('Azimuth [rad]')
        legend('Non-Linear','Linear')
        axis equal
    end
  
end


