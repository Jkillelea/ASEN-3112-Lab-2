clear;
clc;
close all;

load data % gets dumped into a variable named data

load_case = data(:, 1);        % lbf
lvdt = in2mm(data(:, 6));      % mm
f0   = lbf2newton(data(:, 2)); % newtons
f1   = lbf2newton(data(:, 3));
f2   = lbf2newton(data(:, 4));
f3   = lbf2newton(data(:, 5));

cases = unique(load_case);
loads      = zeros(1, length(cases));
deflection = zeros(1, length(cases));
sigmas     = zeros(1, length(cases));

for i = 1:length(cases)
  c = cases(i);
  idxs = load_case == c;

  loads(i)      = c;                % load value (lbs)
  deflection(i) = mean(lvdt(idxs)); % midspan deflection (mm)
  sigmas(i)     = std(lvdt(idxs));  % std deviation
end

fprintf('Max deflection %.2f mm downwards\n', max(deflection));

figure; hold on; grid on;
errorbar(loads, deflection, sigmas, 'o', 'LineWidth', 2);
title('Load case vs deflection, loads in lbs')
xlabel('Load amount (lbs)');
ylabel('Midspan deflection (downwards, mm)');
print('deflection_lbs', '-dpng')

figure; hold on; grid on;
errorbar(lbf2newton(loads), deflection, sigmas, 'o', 'LineWidth', 2);
title('Load case vs deflection, loads in N')
xlabel('Load amount (N)');
ylabel('Midspan deflection (downwards, mm)');
print('deflection_N', '-dpng')
