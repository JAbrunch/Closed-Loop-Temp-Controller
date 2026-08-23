%% Closed-Loop Temperature Controller - Thermal Response Plots
% Assumes this script is stored in:
%   Closed_Loop_Temp_Controller/MATLAB/
%
% and the workbook is stored in:
%   Closed_Loop_Temp_Controller/Thermal Response Data/

clear;
clc;
close all;

%% Load experimental data
dataFile = fullfile("..", "Thermal Response Data", ...
    "CLTC Heating_Cool Response Data.xlsx");

% Sheet1:
% Rows 1-13 contain experiment notes.
% Row 14 contains column headings.
% Rows 15-69 contain heating-response measurements.
heatingData = readmatrix(dataFile, "Sheet", "Sheet1", "Range", "A15:C69");

dutyCycle   = heatingData(:,1);
time_s      = heatingData(:,2);
temperature = heatingData(:,3);

% Sheet2:
% Rows 1-9 contain experiment notes.
% Row 10 contains column headings.
% Rows 11-50 contain the 100% -> 0% cooling response.
coolingData = readmatrix(dataFile, "Sheet", "Sheet2", "Range", "A11:B50");

coolTime_s      = coolingData(:,1);
coolTemperature = coolingData(:,2);

%% Figure 1 - Heating response at each PWM duty cycle
figure;
hold on;
grid on;

dutyLevels = unique(dutyCycle);

for k = 1:length(dutyLevels)
    duty = dutyLevels(k);
    idx = dutyCycle == duty;

    plot(time_s(idx), temperature(idx), ...
        "-o", ...
        "LineWidth", 1.5, ...
        "DisplayName", sprintf("%g%% Duty", duty));
end

xlabel("Time (s)");
ylabel("Temperature (^{\circ}C)");
title("TMP119 Heating Response at Fixed PWM Duty Cycles");
legend("Location", "northwest");
hold off;

%% Figure 2 - Heating response normalized to each run's starting temperature
figure;
hold on;
grid on;

for k = 1:length(dutyLevels)
    duty = dutyLevels(k);
    idx = dutyCycle == duty;

    t = time_s(idx);
    temp = temperature(idx);

    deltaT = temp - temp(1);

    plot(t, deltaT, ...
        "-o", ...
        "LineWidth", 1.5, ...
        "DisplayName", sprintf("%g%% Duty", duty));
end

xlabel("Time (s)");
ylabel("\DeltaT from Start (^{\circ}C)");
title("Normalized Heating Response");
legend("Location", "northwest");
hold off;

%% Figure 3 - Cooling response after 100% -> 0% duty step
figure;
plot(coolTime_s, coolTemperature, "-o", "LineWidth", 1.5);
grid on;

xlabel("Time after Heater Shutoff (s)");
ylabel("Temperature (^{\circ}C)");
title("Cooling Response: 100% Duty to 0% Duty");

%% Optional: display a few useful measured values
fprintf("Heating-response runs loaded: %d\n", length(dutyLevels));
fprintf("Duty cycles: ");
fprintf("%g%% ", dutyLevels);
fprintf("\n");

fprintf("100%% heating run: %.2f C -> %.2f C over %.0f s\n", ...
    temperature(dutyCycle == 100 & time_s == 0), ...
    temperature(dutyCycle == 100 & time_s == 300), ...
    300);

fprintf("Cooling data duration: %.0f s\n", coolTime_s(end));
