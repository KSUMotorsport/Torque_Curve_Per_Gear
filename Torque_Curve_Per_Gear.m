clear all
clc
filename = 'R6 With Drexler.txt';
fileID = fopen(filename);
import = readtable(filename);
fclose(fileID);
% import = uigetfile('*');

MPH = import{:,1};
HP = import{:,2};
RPM_MPH = import{:,3};
s = size(import,1);

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

g1 = 2.583;
g2 = 2.000;
g3 = 1.670;
g4 = 1.444;
g5 = 1.286;
g6 = 1.150;

front_sprocket = 11;
rear_sprocket = 30;
final_drive = rear_sprocket/front_sprocket;
Primary = 2.078;

diam = 18;
tire_rollout = pi*diam;
tire_rollout_mile = tire_rollout*000015783;

rev_limit = 14000;

g1f = g1*final_drive*Primary;
g2f = g2*final_drive*Primary;
g3f = g3*final_drive*Primary;
g4f = g4*final_drive*Primary;
g5f = g5*final_drive*Primary;
g6f = g6*final_drive*Primary;

MaxTireRPM_G1 = rev_limit/g1f;
MaxTireRPM_G2 = rev_limit/g2f;
MaxTireRPM_G3 = rev_limit/g3f;
MaxTireRPM_G4 = rev_limit/g4f;
MaxTireRPM_G5 = rev_limit/g5f;
MaxTireRPM_G6 = rev_limit/g6f;

g1_top_speed = MaxTireRPM_G1 * diam * 1/63360 * 60 * pi;
g2_top_speed = MaxTireRPM_G2 * diam * 1/63360 * 60 * pi;
g3_top_speed = MaxTireRPM_G3 * diam * 1/63360 * 60 * pi;
g4_top_speed = MaxTireRPM_G4 * diam * 1/63360 * 60 * pi;
g5_top_speed = MaxTireRPM_G5 * diam * 1/63360 * 60 * pi;
g6_top_speed = MaxTireRPM_G6 * diam * 1/63360 * 60 * pi;

g1_torque = g1f*TORQUE;
g2_torque = g2f*TORQUE;
g3_torque = g3f*TORQUE;
g4_torque = g4f*TORQUE;
g5_torque = g5f*TORQUE;
g6_torque = g6f*TORQUE;

g1_speed = ((RPM/g1f)*60)* diam * pi * 1/63360;
g2_speed = ((RPM/g2f)*60)* diam * pi * 1/63360;
g3_speed = ((RPM/g3f)*60)* diam * pi * 1/63360;
g4_speed = ((RPM/g4f)*60)* diam * pi * 1/63360;
g5_speed = ((RPM/g5f)*60)* diam * pi * 1/63360;
g6_speed = ((RPM/g6f)*60)* diam * pi * 1/63360;

Car_Mass = 458; %(lbs)
Mass = Car_Mass/2;
Tire_Mu = 1.3;
Max_Wheel_Force = Mass*Tire_Mu*2;
radius_FT = diam/24;
Theoretica_Max_Wheel_Torque = Max_Wheel_Force*radius_FT;

figure(69);

yline(446.550)
hold on
scatter(g1_speed,g1_torque)
scatter(g2_speed,g2_torque)
scatter(g3_speed,g3_torque)
scatter(g4_speed,g4_torque)
scatter(g5_speed,g5_torque)
scatter(g6_speed,g6_torque)
grid on
xlabel('Speed (mph)')
ylabel('Torque (ft-lb)')
title('Wheel Torque vs. Speed')
xlim ([0 80])
ylim ([50 1000])

G1_speed = g1_speed;
G2_speed = g2_speed;
G3_speed = g3_speed;
G4_speed = g4_speed;
G5_speed = g5_speed;
G6_speed = g6_speed;

G1_torque = g1_torque;
G2_torque = g2_torque;
G3_torque = g3_torque;
G4_torque = g4_torque;
G5_torque = g5_torque;
G6_torque = g6_torque;

for i = 1:length(G1_speed)
    if G1_speed(i,1) > 43.4
        G1_speed(i,1) = 0;
        G1_torque(i,1) = 0;
    end
end
for i = 1:length(G2_speed)
    if G2_speed(i,1) < 43.4
        G2_speed(i,1) = 0;
        G2_torque(i,1) = 0;
    end
end
for i = 1:length(G2_speed)
    if G2_speed(i,1) > 51.8
        G2_speed(i,1) = 0;
        G2_torque(i,1) = 0;
    end
end
for i = 1:length(G3_speed)
    if G3_speed(i,1) < 51.8
        G3_speed(i,1) = 0;
        G3_torque(i,1) = 0;
    end
end
for i = 1:length(G3_speed)
    if G3_speed(i,1) > 60
        G3_speed(i,1) = 0;
        G3_torque(i,1) = 0;
    end
end
for i = 1:length(G4_speed)
    if G4_speed(i,1) < 60
        G4_speed(i,1) = 0;
        G4_torque(i,1) = 0;
    end
end
for i = 1:length(G4_speed)
    if G4_speed(i,1) > 68.26
        G4_speed(i,1) = 0;
        G4_torque(i,1) = 0;
    end
end
for i = 1:length(G5_speed)
    if G5_speed(i,1) < 68.26
        G5_speed(i,1) = 0;
        G5_torque(i,1) = 0;
    end
end
for i = 1:length(G5_speed)
    if G5_speed(i,1) > 76.4
        G5_speed(i,1) = 0;
        G5_torque(i,1) = 0;
    end
end
for i = 1:length(G6_speed)
    if G6_speed(i,1) < 76.4
        G6_speed(i,1) = 0;
        G6_torque(i,1) = 0;
    end
end

figure(6969);

yline(446.550)
hold on
scatter(G1_speed,G1_torque)
scatter(G2_speed,G2_torque)
scatter(G3_speed,G3_torque)
scatter(G4_speed,G4_torque)
scatter(G5_speed,G5_torque)
scatter(G6_speed,G6_torque)
grid on
xlabel('Speed (mph)')
ylabel('Torque (ft-lb)')
title('Wheel Torque vs. Speed')
xlim ([15 120])
ylim ([50 525])
%%
%{
clc
g1_speed_rounded = [round(g1_speed,1)];
g2_speed_rounded = [round(g2_speed,1)];
g3_speed_rounded = [round(g3_speed,1)];
g4_speed_rounded = [round(g4_speed,1)];
g5_speed_rounded = [round(g5_speed,1)];
g6_speed_rounded = [round(g6_speed,1)];

figure(1000);
scatter(g1_speed_rounded,g1_torque);
hold on
scatter(g1_speed,g1_torque,10,"filled");

scatter(g2_speed_rounded,g2_torque);
scatter(g2_speed,g2_torque,10,"filled");

%%
figure(1001);


scatter(g1_speed_rounded,g1_torque)
hold on
scatter(g2_speed_rounded,g2_torque)
scatter(g3_speed_rounded,g3_torque)
scatter(g4_speed_rounded,g4_torque)
scatter(g5_speed_rounded,g5_torque)
scatter(g6_speed_rounded,g6_torque)
%}
%%
%{
clc;
G1 = [g1_speed_rounded g1_torque];
G2 = [g2_speed_rounded g2_torque];
G3 = [g3_speed_rounded g3_torque];
G4 = [g4_speed_rounded g4_torque];
G5 = [g5_speed_rounded g5_torque];
G6 = [g6_speed_rounded g6_torque];
%
G1(any(isnan(G1), 2), :) = [];
G2(any(isnan(G2), 2), :) = [];
G3(any(isnan(G3), 2), :) = [];
G4(any(isnan(G4), 2), :) = [];
G5(any(isnan(G5), 2), :) = [];
G6(any(isnan(G6), 2), :) = [];
%

for i = 1:length(G1)-5
    disp(i)
    if G1(i,1) == G1(i+1,1)
         if G1(i,1) == G1(i+1,1) && G1(i+1,1) == G1(i+2,1)
             if G1(i,1) == G1(i+1,1) && G1(i+1,1) == G1(i+2,1) && G1(i+2,1) == G1(i+3,1)
                if G1(i,1) == G1(i+1,1) && G1(i+1,1) == G1(i+2,1) && G1(i+2,1) == G1(i+3,1) && G1(i+3,1) == G1(i+4,1)
                    if G1(i,1) == G1(i+1,1) && G1(i+1,1) == G1(i+2,1) && G1(i+2,1) == G1(i+3,1) && G1(i+3,1) == G1(i+4,1) && G1(i+4,1) == G1(i+5,1)
                        G1(i+5,2) = mean(G1(i,2) + G1(i+1,2) + G1(i+2,2) + G1(i+3,2) + G1(i+4,2) + G1(i+5,2));
                        G1(i,:) = [];
                        G1(i+1,:) = [];
                        G1(i+2,:) = [];
                        G1(i+3,:) = [];
                        G1(i+4,:) = [];
                        i = 1:length(G1)-5
                    else
                        G1(i+4,2) = mean(G1(i,2) + G1(i+1,2) + G1(i+2,2) + G1(i+3,2) + G1(i+4,2));
                        G1(i,:) = [];
                        G1(i+1,:) = [];
                        G1(i+2,:) = [];
                        G1(i+3,:) = [];
                        i = 1:length(G1)-5
                    end
                else
                    G1(i+3,2) = mean(G1(i,2) + G1(i+1,2) + G1(i+2,2) + G1(i+3,2));
                    G1(i,:) = [];
                    G1(i+1,:) = [];
                    G1(i+2,:) = [];
                    i = 1:length(G1)-5
                end
             else
                G1(i+2,2) = mean(G1(i,2) + G1(i+1,2) + G1(i+2,2));
                G1(i,:) = [];
                G1(i+1,:) = [];
                i = 1:length(G1)-5
             end
         else
             G1(i+1,2) = mean(G1(i,2) + G1(i+1,2));
             G1(i,:) = [];
             i = 1:length(G1)-5
         end
     end
end
%}
%%
%{
figure(690)
scatter(RPM,Actual_HP,20,"filled")

hold on

scatter(RPM,TORQUE,20,"filled")
title ("Dyno With Drexler")
legend ('HP','Torque')
grid on
xlabel RPM
ylabel 'HP, TORQUE'
xlim([0 15000])
ylim([0 70])
%}