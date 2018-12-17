%Create random trace to initialise AI learning
close all
clear all
load('Rundata6.mat');
%endTime=50
%delay=0 % Add 0 to end for creating delay data
%A=0.15;
%PeakToTrough=1;%1.0445;
%Umax=A;
%Scaling=10;
%Period=1.4;
%timeStep=Period/100;%0.01
pkg load signal
t=Time';%(0.0:timeStep:endTime-delay)';
%addedtime=(endTime-delay+timeStep:timeStep:endTime)';
%U=Umax.*(max(t)/2-abs((max(t)/2-t)))./max(t).*sin(2*pi/Period*t);

%U=Umax.*sin(2*pi/Period*t);
%for i=1:length(U)
%  if U(i)>=0
%    U(i)=U(i)*Scaling*PeakToTrough;
%  elseif U(i)<0
%    U(i)=U(i)*Scaling;
%  end
%end
%for i=1:400
%U(i)=U(i)*(t(i)/t(400));
%end
% irregular waves
%U=-2*Umax/6*sin(2*pi/Period/1.2*t)+Umax/8*sin(2*pi/Period/0.7*t)+Umax/3*sin(2*pi/Period/2*t)+Umax/6*sin(2*pi/Period/1.*t);
%U=[U; zeros(size(addedtime))];
%t=[t; addedtime];
U=Elevation'.*0.5;
figure
plot(U);hold on;plot(abs(U),'r');
U=num2cell(U);
t=num2cell(t);
Output=[cell2mat(t),cell2mat(U),zeros(size(cell2mat(U))),zeros(size(cell2mat(U))) ];
figure
plot(cell2mat(t),cell2mat(U))
fid = fopen('Wavemaker.dat', 'w');
fprintf(fid,'%i\n', size(t,1));
fprintf(fid,'(\n')
fprintf(fid,'(%f ( %f %f %f ))\n',Output' )
fprintf(fid,')\n')
fclose(fid)
save('-V7','Initialwavemakerinput.mat','t','U')
