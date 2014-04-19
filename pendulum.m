clear;
clc;
close all;

dt = 0.01; % Taking time in 0.01 step unit increments

for j=0:1:4
    phi = 2*pi*rand(); % initial value of phi
    v = 0; % initial value of v
    error = pi-phi;
    figure();
    hold on;
    plot(0:dt:40,pi);
    Kp = j*5;
    Kd = j;
    for i=0:dt:40
        phi = mod((phi+v*dt),(2*pi));
        u = Kp * (error) - (Kd * v);
        v = v + (-phi + u) * dt;
        error = pi - phi;
        hold on;
        plot(i,phi);
    end
    str = sprintf('Kp = %d and Kd = %d',Kp,Kd);
    ylim([0 5]);
    xlabel('Time');
    ylabel('Phi');
    title(str);
end
