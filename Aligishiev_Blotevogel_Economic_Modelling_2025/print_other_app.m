%=========================================================================
% print_other_app.m
% Generates and saves all remaining figures from the annexes
%=========================================================================  

%% 1. Baseline RRP/RRF impact under alternative fiscal rules (instruments)

% 1.1 Environment initialization
clear all

load('scenario_s1.mat');
load('scenario_s5.mat');
load('scenario_s6.mat');

select_varrs2 = {
    'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN';...
    'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT';...
    'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S';...
    'PTH'; 'PT'; 'PN'; 'GI'; 'DC'; 'TOT'; 'PG'; 'NX'; 'CAD';...
    'Priv_save_y'; 'CAD_y'; 'Pub_save_y'; 'NIIP_y'; 'INV'
    };

timescale = [timescale; timescale; timescale];

for mm = 1:size(select_varrs2,1)
    eval(string(select_varrs2(mm)) + ' = [' + string(select_varrs2(mm))...
        + '_s1 ' + string(select_varrs2(mm)) + '_s5 '...
        + string(select_varrs2(mm)) + '_s6];');
end

% Ensure output directory exists
if ~exist(fullfile('charts','app_d','figd3'), 'dir')
    mkdir(fullfile('charts','app_d','figd3'));
end


% 1.2 Plot figures
f19 = figure('Name',['Alternative fiscal rules - baseline current' ...
    '     account (Figure D-3.c)']);
p3 = plot(timescale', CAD_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = '--';
    p3(3).LineWidth = 3.5;
    legend('Consumption tax (Baseline)','Labour tax','Transfers', ...
        'Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd3/CADY.jpg')

f20 = figure('Name',['Alternative fiscal rules - baseline NIIP' ...
    '         (Figure D-3.d)']);
p3 = plot(timescale',NIIP_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = '--';
    p3(3).LineWidth = 3.5;
    legend('Consumption tax (Baseline)','Labour tax','Transfers', ...
        'Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd3/NIIPY.jpg')

f21 = figure('Name',['Alternative fiscal rules - baseline public' ...
    '     savings (Figure D-3.b)']);
p3 = plot(timescale',Pub_save_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = ':';
    p3(3).LineWidth = 3.5;
    legend('Consumption tax (Baseline)','Labour tax','Transfers', ...
        'Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd3/GSY.jpg')


f22 = figure('Name',['Alternative fiscal rules - baseline private' ...
    '     savings (Figure D-3.a)']);
p3 = plot(timescale', Priv_save_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = ':';
    p3(3).LineWidth = 3.5;
    legend('Consumption tax (Baseline)','Labour tax','Transfers', ...
        'Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd3/PSY.jpg')

%% 2. Fiscal slippage scenario RRP/RRF impact under alternative fiscal 
% rules (instruments)

% 2.1 Environment initialization
clear all

load('scenario_s2.mat');
load('scenario_s7.mat');
load('scenario_s8.mat');

select_varrs2 = {
    'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN';...
    'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT';...
    'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S';...
    'PTH'; 'PT'; 'PN'; 'GI'; 'DC'; 'TOT'; 'PG'; 'NX'; 'CAD';...
    'Priv_save_y'; 'CAD_y'; 'Pub_save_y'; 'NIIP_y'; 'INV'
    };

timescale = [timescale; timescale; timescale];

for mm = 1:size(select_varrs2,1)
    eval(string(select_varrs2(mm)) + ' = [' + string(select_varrs2(mm))...
        + '_s2 ' + string(select_varrs2(mm)) + '_s7 '...
        + string(select_varrs2(mm)) + '_s8];');
end

% Ensure output directory exists
if ~exist(fullfile('charts','app_d','figd4'), 'dir')
    mkdir(fullfile('charts','app_d','figd4'));
end

% 2.2 Plot figures
f23 = figure('Name',['Alternative fiscal rules - slippage current' ...
    '     account (Figure D-4.c)']);
p3 = plot(timescale', CAD_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = '--';
    p3(3).LineWidth = 3.5;
    legend('Consumption tax (Baseline)','Labour tax','Transfers', ...
        'Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd4/CADY.jpg')

f24 = figure('Name',['Alternative fiscal rules - slippage NIIP' ...
    '         (Figure D-4.d)']);
p3 = plot(timescale',NIIP_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = '--';
    p3(3).LineWidth = 3.5;
    legend('Consumption tax (Baseline)','Labour tax','Transfers', ...
        'Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd4/NIIPY.jpg')

f25 = figure('Name',['Alternative fiscal rules - slippage public' ...
    '     savings (Figure D-4.b)']);
p3 = plot(timescale',Pub_save_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = ':';
    p3(3).LineWidth = 3.5;
    legend('Consumption tax (Baseline)','Labour tax','Transfers', ...
        'Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd4/GSY.jpg')

f26 = figure('Name',['Alternative fiscal rules - slippage private' ...
    '     savings (Figure D-4.a)']);
p3 = plot(timescale', Priv_save_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = ':';
    p3(3).LineWidth = 3.5;
    legend('Consumption tax (Baseline)','Labour tax','Transfers', ...
        'Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd4/PSY.jpg')

%% 3. Alternative intratemporal elasticity of substitution between 
% domestic and imported traded goods. 

% 3.1 Environment initialization
clear all

load('scenario_s1.mat');
load('scenario_s9.mat');
load('scenario_s10.mat');
load('scenario_s11.mat');
load('scenario_s12.mat');

select_varrs2 = {
    'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN';...
    'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT';...
    'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S';...
    'PTH'; 'PT'; 'PN'; 'GI'; 'DC'; 'TOT'; 'PG'; 'NX'; 'CAD';...
    'Priv_save_y'; 'CAD_y'; 'Pub_save_y'; 'NIIP_y'; 'INV'
    };

timescale = [timescale; timescale; timescale; timescale; timescale];

for mm = 1:size(select_varrs2,1)
    eval(string(select_varrs2(mm)) + ' = [' + string(select_varrs2(mm))...
        + '_s1 ' + string(select_varrs2(mm)) + '_s9 '...
        + string(select_varrs2(mm)) + '_s10 '...
        + string(select_varrs2(mm)) + '_s11 '...
        + string(select_varrs2(mm)) + '_s12];');
end

% Ensure output directory exists
if ~exist(fullfile('charts','app_d','figd2'), 'dir')
    mkdir(fullfile('charts','app_d','figd2'));
end

% 3.2 Plot figures
f27 = figure('Name','Alternative IES - current account (Figure D-2.c)');
p3 = plot(timescale', CAD_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = '--';
    p3(3).LineWidth = 3.5;
    p3(4).Color = 'g';
    p3(4).LineStyle = '--';
    p3(4).LineWidth = 3.5;
    p3(5).Color = 'm';
    p3(5).LineStyle = '--';
    p3(5).LineWidth = 3.5;
    legend('$\chi^T=1.5$','$\chi^T=1.1$','$\chi^T=2.6$','$\chi^T=2.9$',...
        '$\chi^T=3.5$','Location','southoutside','NumColumns',2,...
        'Interpreter','latex');
saveas(gcf,'charts/app_d/figd2/CADY.jpg')

f28 = figure('Name','Alternative IES - NIIP (Figure D-2.d)');
p3 = plot(timescale',NIIP_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = '--';
    p3(3).LineWidth = 3.5;
    p3(4).Color = 'g';
    p3(4).LineStyle = '--';
    p3(4).LineWidth = 3.5;
    p3(5).Color = 'm';
    p3(5).LineStyle = '--';
    p3(5).LineWidth = 3.5;
    legend('$\chi^T=1.5$','$\chi^T=1.1$','$\chi^T=2.6$','$\chi^T=2.9$',...
        '$\chi^T=3.5$','Location','southoutside','NumColumns',2,...
        'Interpreter','latex');
saveas(gcf,'charts/app_d/figd2/NIIPY.jpg')

f29 = figure('Name','Alternative IES - public savings (Figure D-2.b)');
p3 = plot(timescale',Pub_save_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = ':';
    p3(3).LineWidth = 3.5;
    p3(4).Color = 'g';
    p3(4).LineStyle = '--';
    p3(4).LineWidth = 3.5;
    p3(5).Color = 'm';
    p3(5).LineStyle = '--';
    p3(5).LineWidth = 3.5;
    legend('$\chi^T=1.5$','$\chi^T=1.1$','$\chi^T=2.6$','$\chi^T=2.9$',...
        '$\chi^T=3.5$','Location','southoutside','NumColumns',2,...
        'Interpreter','latex');
saveas(gcf,'charts/app_d/figd2/GSY.jpg')

f30 = figure('Name','Alternative IES - private savings (Figure D-2.a)');
p3 = plot(timescale', Priv_save_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = ':';
    p3(3).LineWidth = 3.5;
    p3(4).Color = 'g';
    p3(4).LineStyle = '--';
    p3(4).LineWidth = 3.5;
    p3(5).Color = 'm';
    p3(5).LineStyle = '--';
    p3(5).LineWidth = 3.5;
    legend('$\chi^T=1.5$','$\chi^T=1.1$','$\chi^T=2.6$','$\chi^T=2.9$',...
        '$\chi^T=3.5$','Location','southoutside','NumColumns',2,...
        'Interpreter','latex');
saveas(gcf,'charts/app_d/figd2/PSY.jpg')

%% 4. Dividends absent reform shocks   

% 4.1 Environment initialization
clear all

load('scenario_s1.mat');
load('scenario_s13.mat');
load('scenario_s14.mat');

select_varrs2 = {
    'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN';...
    'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT';...
    'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S';...
    'PTH'; 'PT'; 'PN'; 'GI'; 'DC'; 'TOT'; 'PG'; 'NX'; 'CAD';...
    'Priv_save_y'; 'CAD_y'; 'Pub_save_y'; 'NIIP_y'; 'INV'
    };

timescale = [timescale; timescale; timescale];

for mm = 1:size(select_varrs2,1)
    eval(string(select_varrs2(mm)) + ' = [' + string(select_varrs2(mm))...
        + '_s1 ' + string(select_varrs2(mm)) + '_s13 '...
        + string(select_varrs2(mm)) + '_s14];');
end

% Ensure output directory exists
if ~exist(fullfile('charts','app_d','figd1'), 'dir')
    mkdir(fullfile('charts','app_d','figd1'));
end

% 4.2 Plot figures
f31 = figure('Name','No reforms - current account (Figure D-1.c)');
p3 = plot(timescale', CAD_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = '--';
    p3(3).LineWidth = 3.5;
    legend('Full package','Net of labour disutility shock',...
        'Net of TFP shock','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd1/CADY.jpg')

f32 = figure('Name','No reforms - NIIP (Figure D-1.d)');
p3 = plot(timescale',NIIP_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = '--';
    p3(3).LineWidth = 3.5;
    legend('Full package','Net of labour disutility shock',...
        'Net of TFP shock','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd1/NIIPY.jpg')

f33 = figure('Name','No reforms - public savings (Figure D-1.b)');
p3 = plot(timescale',Pub_save_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = ':';
    p3(3).LineWidth = 3.5;
    legend('Full package','Net of labour disutility shock',...
        'Net of TFP shock','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd1/GSY.jpg')

f34 = figure('Name','No reforms - private savings (Figure D-1.a)');
p3 = plot(timescale', Priv_save_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    p3(3).Color = 'r';
    p3(3).LineStyle = ':';
    p3(3).LineWidth = 3.5;
    legend('Full package','Net of labour disutility shock',...
        'Net of TFP shock','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/app_d/figd1/PSY.jpg')

