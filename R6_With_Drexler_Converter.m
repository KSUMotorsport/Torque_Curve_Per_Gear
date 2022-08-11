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

RPM = zeros(s,1);
i = 1;
while i<s
    RPM(i,1) = MPH(i,1)*RPM_MPH_AVERAGE;
    i = i+1;
end

data(isnan(HP)) = 0;

Actual_HP = zeros(s,1);
i = 1;
while i<s
    Actual_HP(i,1) = HP(i,1)+10;
    i = i+1;
end

TORQUE = zeros(s,1);
i = 1;
while i<s
    TORQUE(i,1) = (Actual_HP(i,1)*5252)/RPM(i,1);
    i = i+1;
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