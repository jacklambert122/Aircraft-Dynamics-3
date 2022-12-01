%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Author: Jack Lambert
% Dale Lawrence
% Aircraft Dynmaics Homework 3
% Problem 2 and 4
% Purpose: This code iterates through the different intial condition matrix
% for the different variations and applies a feedback control that is
% proportionate to the angular rates along each of their corresponding axis
% Date Modefied: 2/12/18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global x

%% Initial Conditions
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

for i = 1:6
    condition{i}= [c1(i) c2(i) c3(i) c4(i) c5(i) c6(i) c7(i) c8(i) c9(i) c10(i) c11(i) c12(i)]; 
end

%% With Feedback Control Moments
x = 1;% Intiates feed back control moments
string = ["+5 [deg] Bank","+5 [deg] Pitch","+5 [deg] Azimuth",...
    "+0.1 [rad/s] Roll Rate", "+0.1 [rad/s] Pitch Rate", "+0.1 [rad/s] Yaw Rate"];

% First we plot the trajecotry of the copter to see its new path
for i = 1:6
    [t,z] = ode45('NonLinearMain',[0 5],condition{i});
    figure(i)
    plot3(z(:,1),z(:,2),-z(:,3),'-o')
    tit = sprintf('%s %s','Trajectory of Quad-Copter w/',string(i));
    title(tit)
    xlabel('N Displacement [m]')
    ylabel('E Displacement [m]')
    zlabel('-D Displacement [m]')
    axis equal
end

% Now we plot the Bank, Pitch, Azimuth, Roll Rate, Pitch Rate, ans Yaw Rate
% as a function of time to see what is occuring when rotations are induced
for i = 4:6
    [t,z] = ode45('NonLinearMain',[0 2],condition{i});
    tit = sprintf('%s %s','Trajectory of Quad-Copter w/',string(i));
    if i == 4 
        figure
        plot(t,z(:,7))
        title(tit)
        xlabel('time [s]')
        ylabel('Bank [rad]')
        figure
        plot(t,z(:,10))
        title(tit)
        xlabel('time [s]')
        ylabel('Roll Rate [rad]')
    elseif i == 5
        figure
        plot(t,z(:,8))
        title(tit)
        xlabel('time [s]')
        ylabel('Pitch [rad]')
        figure
        plot(t,z(:,11))
        title(tit)
        xlabel('time [s]')
        ylabel('Pitch rate [rad/s]')
    elseif i == 6
        figure
        plot(t,z(:,9))
        title(tit)
        xlabel('time [s]')
        ylabel('Azimuth [rad]')
         figure
        plot(t,z(:,12))
        title(tit)
        xlabel('time [s]')
        ylabel('Yaw Rate [rad]')
    end
  
end




