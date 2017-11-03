clear;
clc;
close all;

load data % gets dumped into a variable named data

load_case = data(:, 1);             % lbf
f0        = lbf2newton(data(:, 2)); % newtons
f1        = lbf2newton(data(:, 3));
f2        = lbf2newton(data(:, 4));
f3        = lbf2newton(data(:, 5));
lvdt      = in2mm(data(:, 6));      % mm

figure; hold on; grid on;
cases = unique(load_case);
for i = 1:length(cases)
  c = cases(i);
  idxs = load_case == c;
  plot(load_case(idxs), lvdt(idxs), 'LineWidth', 2);
end
