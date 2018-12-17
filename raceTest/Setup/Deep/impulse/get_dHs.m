clear all
close all

for i=1:14

filename=['Rundata' num2str(i) '.mat'];
load(filename,'Hmin_Result','Hmax_Result');
dHMin(i)=Hmin_Result;
dHMax(i)=Hmax_Result;
clear Hmin_Result Hmax_Result
Error(i)=(((abs(dHMin(i))+dHMax(i))-1.5)/1.5)*100;
end

figure
plot(Error);
grid on