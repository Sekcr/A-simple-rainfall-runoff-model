%% A simple rainfall-runoff model 
close all; clear all; clc;
PET = readmatrix('pet.txt'); % Potential Evaporation, mm
PRE = readmatrix('precip.txt'); % Precipitation, mm
F_0 = 12; % Soil moisture at the beginning of the first month, mm
Z_max = 125; % Maximum soil moisture, mm
O = 384; % Area, km2
% AET : Actual Evapotranspiration, mm
% Z : Monthly soil moisture, mm
% R : Runoff, mm
% Author: 
%   Furkan Sencer Kacar
%   furkan.kacar@tau.edu.tr
%%
for i=1:length(PET)
    if PET(i) > PRE(i)
        AET(i) = PRE(i)+F_0(i);
        Z(i) = 0;
        R(i) = 0;
        if AET(i) > PET(i)
            AET(i) = PET(i);
            Z(i) = PRE(i)+F_0(i)-AET(i);
            R(i) = 0;
            if Z(i) >= Z_max
                R(i) = Z(i)-Z_max;
                Z(i) = Z_max;
            end
            F_0(i+1) = Z(i);
        end
    else
        AET(i) = PET(i);
        Z(i) = F_0(i)+PRE(i)-AET(i);
        if Z(i) > 125
            R(i) = Z(i) - Z_max;
            Z(i) = Z_max;
        end
    end
    F_0(i+1) = Z(i);
end
F_0(13) = [];
clear i;
A_v = R*1e-3*O*1e6; % Monthly runoff, m^3