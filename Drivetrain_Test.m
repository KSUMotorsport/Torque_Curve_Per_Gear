clear all;
max_RPM = 14500;
TireDia = 18; %inches
TireCircum = pi * TireDia;
Primary = 2.078;
Final = 2.7273;

g1 = 2.583;
g2 = 2;
g3 = 1.67;
g4 = 1.444;
g5 = 1.286;
g6 = 1.15;

test = g4*Primary*Final;

MaxTireRPM_G1 = max_RPM * g1 *Final;
MaxTireRPM_G2 = max_RPM * g2 * Primary*Final;
MaxTireRPM_G3 = max_RPM * g3 * Primary*Final;
MaxTireRPM_G4 = max_RPM/test;
MaxTireRPM_G5 = max_RPM * g5 * Primary*Final;
MaxTireRPM_G6 = max_RPM * g6 * Primary*Final;

MasXpeed_G1 = MaxTireRPM_G4 * TireDia * 1/63360 * 60 * pi;