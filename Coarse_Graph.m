clear
clc
filename = 'R6 With Drexler.txt';
fileID = fopen(filename);
import = readtable(filename);
fclose(fileID);
% import = uigetfile('*');
%%
MPH = import{:,1};
HP = import{:,2};
RPM_MPH = import{:,3};
s = size(import,1);
%%
x = 0;
i = 36;
while i<66
    RPM_MPH_AVERAGE = x + RPM_MPH(i,1);
    i = i+1;
end
o = s;

RPM = zeros(o,1);
i = 1;
while i<o
    RPM(i,1) = MPH(i,1)*RPM_MPH_AVERAGE;
    i = i+20;
end

data(isnan(HP)) = 0;

Actual_HP = zeros(o,1);
i = 1;
while i<o
    Actual_HP(i,1) = HP(i,1)+10;
    i = i+20;
end

TORQUE = zeros(o,1);
i = 1;
while i<o
    TORQUE(i,1) = (Actual_HP(i,1)*5252)/RPM(i,1);
    i = i+20;
end

scatter(RPM,Actual_HP,20,"filled")

hold on

scatter(RPM,TORQUE,20,"filled")
title ("Dyno With Drexler")
legend ('HP','Torque')
grid on
xlabel RPM
ylabel 'HP, TORQUE'
xlim([5000 15000])
ylim([10 80])