clear;
clc;
close all;

%% Folder containing P-controller CSV files
dataFolder = ...
    'C:\Users\final\Closed_Loop_Temp_Controller\Thermal Response Data\P Controller';

%% Files and gains
files = {
    'Kp_05.csv'
    'Kp_10.csv'
    'Kp_20.csv'
    'Kp_40.csv'
};

Kp_values = [5 10 20 40];

setpoint = 35.0;
steadyStateWindow = 120;   % seconds

%% Storage for calculated results
Tss      = zeros(size(Kp_values));
ess      = zeros(size(Kp_values));
Duty_ss  = zeros(size(Kp_values));

%% Temperature response plot
figure;
hold on;
grid on;

for i = 1:length(files)

    filePath = fullfile(dataFolder, files{i});

    % CSV columns:
    % time, temperature, setpoint, error, duty, Kp
    data = readmatrix(filePath);

    % Remove malformed/incomplete rows
    data = data(all(isfinite(data(:,1:6)), 2), :);

    time = data(:,1);
    temperature = data(:,2);
    duty = data(:,5);

    plot(time, temperature, ...
        'LineWidth', 1.5, ...
        'DisplayName', sprintf('K_p = %g', Kp_values(i)));

    %% Steady-state analysis
    finalTime = time(end);

    ss_idx = time >= (finalTime - steadyStateWindow);

    Tss(i)     = mean(temperature(ss_idx));
    ess(i)     = setpoint - Tss(i);
    Duty_ss(i) = mean(duty(ss_idx));
end

yline(setpoint, '--', ...
    'Setpoint = 35°C', ...
    'LineWidth', 1.5);

xlabel('Time (s)');
ylabel('Temperature (°C)');
title('P-Controller Temperature Response');
legend('Location', 'best');

hold off;


%% Duty-cycle response plot
figure;
hold on;
grid on;

for i = 1:length(files)

    filePath = fullfile(dataFolder, files{i});

    data = readmatrix(filePath);
    data = data(all(isfinite(data(:,1:6)), 2), :);

    time = data(:,1);
    duty = data(:,5);

    plot(time, duty, ...
        'LineWidth', 1.5, ...
        'DisplayName', sprintf('K_p = %g', Kp_values(i)));
end

xlabel('Time (s)');
ylabel('PWM Duty Cycle (%)');
title('P-Controller Control Effort');
legend('Location', 'best');

ylim([0 105]);

hold off;


%% Steady-state results table
Results = table( ...
    Kp_values', ...
    Tss', ...
    ess', ...
    Duty_ss', ...
    'VariableNames', ...
    {'Kp', 'SteadyStateTemp_C', 'SteadyStateError_C', 'SteadyStateDuty_pct'});

disp('P-Controller Steady-State Results:')
disp(Results);