close all
clear all
% Wave parameters
H = 1.5; % Wave height in m
T = 8; % Wave period in seconds
h = 70; % Water depth in m
rampTime = 8;
Lambda = dispersion('T',T,'d',h);
k = 2*pi/Lambda; % Wavenumber in rad/m
omega = 2*pi/T; % Angular frequency in rad/s
g = 9.81; % Gravity in m/s^2
Time = 0:0.01:160;
%% Surface Elevation 2nd Order Approx.
x1 = 0; 
sigma=tanh(k*h);
a=H/2;
etaX1 = H/2*cos(k*x1-omega*Time);
Teta=k*x1-omega*Time;
ElevationRaw = a*(cos(Teta)+(k*a)*((3-sigma^2)/(4*sigma^4))*cos(2*Teta));
figure
plot (Time,etaX1,Time,ElevationRaw)
title ('Surface elevation function of time at a given position x')
xlabel ('Time in seconds')
ylabel ('Surface elevation in meters')
legend('1st','2nd')

for i=1:length(ElevationRaw)
  if Time(i)<=rampTime;
    Elevation(i)=ElevationRaw(i)*(Time(i)/rampTime);
  else 
    Elevation(i)=ElevationRaw(i);
  end
end

figure
plot(Time,ElevationRaw,'k','LineWidth',3);
grid on;hold on;
plot(Time,Elevation,'r--','LineWidth',3);
legend('Elevation Raw','Elevation Filtered');

save('-V7','Targeteta.mat','Time','Elevation')