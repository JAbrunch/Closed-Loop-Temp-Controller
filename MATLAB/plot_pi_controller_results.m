% plot_pi_controller_results.m
% Compares PI controller responses for Ki = 0.05, 0.10, 0.20
% Kp is fixed at 40 and setpoint is 35 C.

clear;
clc;
close all;

%% Paths / test setup
data_dir = 'C:\Users\final\Closed_Loop_Temp_Controller\Thermal Response Data\PI Controller';

files = {
    'Ki_005.csv'
    'Ki_010.csv'
    'Ki_020.csv'
};

Ki_values = [0.05, 0.10, 0.20];

setpoint = 35.0;
steady_state_window_s = 120;

%% Storage
num_tests = numel(files);

time_data = cell(num_tests,1);
temp_data = cell(num_tests,1);
duty_data = cell(num_tests,1);
pterm_data = cell(num_tests,1);
iterm_data = cell(num_tests,1);

Tss = zeros(num_tests,1);
ess = zeros(num_tests,1);
Duty_ss = zeros(num_tests,1);
MaxTemp = zeros(num_tests,1);
Overshoot = zeros(num_tests,1);

%% Load and process data
for i = 1:num_tests

    file_path = fullfile(data_dir, files{i});
    data = readmatrix(file_path);

    % Expected columns:
    % 1 time_s
    % 2 temperature_C
    % 3 setpoint_C
    % 4 error_C
    % 5 duty_pct
    % 6 Kp
    % 7 Ki
    % 8 P_term
    % 9 I_term

    % Keep only valid numeric controller rows
    valid = size(data,2) >= 9 & all(isfinite(data(:,1:9)),2);
    data = data(valid,:);

    t = data(:,1);
    temp = data(:,2);
    duty = data(:,5);
    pterm = data(:,8);
    iterm = data(:,9);

    time_data{i} = t;
    temp_data{i} = temp;
    duty_data{i} = duty;
    pterm_data{i} = pterm;
    iterm_data{i} = iterm;

    % Steady-state window: final 120 seconds
    ss_idx = t >= (t(end) - steady_state_window_s);

    Tss(i) = mean(temp(ss_idx));
    ess(i) = setpoint - Tss(i);
    Duty_ss(i) = mean(duty(ss_idx));

    MaxTemp(i) = max(temp);
    Overshoot(i) = max(0, MaxTemp(i) - setpoint);
end

%% Figure 1: Temperature response
figure;
hold on;

for i = 1:num_tests
    plot(time_data{i}, temp_data{i}, ...
        'LineWidth', 1.4, ...
        'DisplayName', sprintf('K_i = %.2f', Ki_values(i)));
end

yline(setpoint, '--', ...
    'Setpoint = 35°C', ...
    'LineWidth', 1.5, ...
    'DisplayName', 'Setpoint');

xlabel('Time (s)');
ylabel('Temperature (°C)');
title('PI Controller Temperature Response');
legend('Location','best');
grid on;
hold off;

%% Figure 2: Duty-cycle response
figure;
hold on;

for i = 1:num_tests
    plot(time_data{i}, duty_data{i}, ...
        'LineWidth', 1.4, ...
        'DisplayName', sprintf('K_i = %.2f', Ki_values(i)));
end

xlabel('Time (s)');
ylabel('Duty Cycle (%)');
title('PI Controller Control Effort');
ylim([0 105]);
legend('Location','best');
grid on;
hold off;

%% Figure 3: P and I terms for each Ki
figure;
hold on;

for i = 1:num_tests
    plot(time_data{i}, pterm_data{i}, ...
        'LineWidth', 1.2, ...
        'DisplayName', sprintf('P term, K_i = %.2f', Ki_values(i)));

    plot(time_data{i}, iterm_data{i}, '--', ...
        'LineWidth', 1.2, ...
        'DisplayName', sprintf('I term, K_i = %.2f', Ki_values(i)));
end

xlabel('Time (s)');
ylabel('Controller Contribution (%)');
title('PI Controller P and I Contributions');
legend('Location','best');
grid on;
hold off;

%% Results table
results = table( ...
    Ki_values(:), ...
    Tss, ...
    ess, ...
    MaxTemp, ...
    Overshoot, ...
    Duty_ss, ...
    'VariableNames', { ...
        'Ki', ...
        'SteadyStateTemp_C', ...
        'SteadyStateError_C', ...
        'MaxTemp_C', ...
        'Overshoot_C', ...
        'SteadyStateDuty_pct' ...
    } ...
);

disp(results);
