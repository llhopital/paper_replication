%=========================================================================
% print_fig578appb.m
% Generates and saves figures 5, 7, 8 and all figures from annex B
%=========================================================================  

%% 1. Environment initialization

clear all

for i = 1:4
    load(sprintf('scenario_s%d.mat', i));
end

select_varrs2 = {
    'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN';...
    'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT';...
    'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S';...
    'PTH'; 'PT'; 'PN'; 'GI'; 'DC'; 'TOT'; 'PG'; 'NX'; 'CAD';...
    'Priv_save_y'; 'CAD_y'; 'Pub_save_y'; 'NIIP_y'; 'INV'};

timescale = [timescale; timescale; timescale; timescale];

for mm = 1:size(select_varrs2,1)
    eval(string(select_varrs2(mm)) + ' = [' + string(select_varrs2(mm))...
        + '_s1 ' + string(select_varrs2(mm)) + '_s2 '...
        + string(select_varrs2(mm)) + '_s3 ' + string(select_varrs2(mm))...
        + '_s4];');
end

PFB_y = [100.*(PFB_y_s1-PFB_y_s1(1)) 100.*(PFB_y_s2-PFB_y_s2(1))];
FPD_y = [FPD_y_s1 FPD_y_s3];
DFD_y = [DFD_y_s1 DFD_y_s2];
S_y   = [100.*(S_s1(1:T,:)./S_s1(1,:)-1) 100.*(S_s4(1:T,:)./S_s4(1,:)-1)];


% Ensure output directory exists
if ~exist(fullfile('charts', 'fig5'), 'dir')
    mkdir(fullfile('charts', 'fig5'));
end

if ~exist(fullfile('charts', 'app_b'), 'dir')
    mkdir(fullfile('charts', 'app_b'));
end

if ~exist(fullfile('charts', 'fig8'), 'dir')
    mkdir(fullfile('charts', 'fig8'));
end

if ~exist(fullfile('charts', 'fig7'), 'dir')
    mkdir(fullfile('charts', 'fig7'));
end

% 2. Plot responses of key macro variables

f7 = figure('Name','Responses of key macro variables (Figure 5)');
subplot(5,2,1)
p = plot(timescale',100.*(YDOM(1:T,:)./YDOM(1,:)-1));
    title('Output')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'r';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'g';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,2,2)
p = plot(timescale',100.*(L(1:T,:)./L(1,:)-1));
    title('Employment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'r';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'g';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,2,3)
p = plot(timescale',100.*(C(1:T,:)./C(1,:)-1));
    title('Consumption')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'r';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'g';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,2,4)
p = plot(timescale',100.*(GC(1:T,:)./GC(1,:)-1));
    title('Gov. Consumption')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'r';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'g';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,2,5)
p = plot(timescale',100.*(INV(1:T,:)./INV(1,:)-1));
    title('Investment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'r';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'g';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,2,6)
p = plot(timescale',100.*(GI(1:T,:)./GI(1,:)-1));
    title('Gov. Investment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'r';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'g';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,2,7)
p = plot(timescale',100.*(NX(1:T,:)./Y(1:T,:) - NX(1,:)./Y(1,:)));
    title('Net exports')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'r';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'g';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,2,8)
p = plot(timescale',100.*(XX(1:T,:)./(XX(1,:))-1));
    title('Exports')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'r';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'g';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,2,9)
p = plot(timescale',100.*(MM_TOTAL(1:T,:)./MM_TOTAL(1,:)-1));
    title('Imports')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'r';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'g';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')
    xlabel('year')

subplot(5,2,10)
p = plot(timescale',100.*(TAUC(1:T,:)-TAUC(1,:)));
    title('Consumption tax rate')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'r';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'g';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('p.p.')
    xlabel('year')
    hL = legend('Baseline','Fiscal slippages',...
        'Unproductive capital inflows','Challenging export penetration',...
        'Orientation', 'horizontal', 'Units', 'normalized', 'Position',...
        [0.35, 0.02, 0.3, 0.05]); 

saveas(gcf,'charts/fig5/all_vars.jpg')

%% 3. Plot appendix B

% 3.1 Part 1
f8 = figure('Name','Appendix B (Figure 1)');
subplot(5,3,1)
p = plot(timescale',100.*(YDOM(1:T,:)./YDOM(1,:)-1));
    title('Output')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,2)
p = plot(timescale',100.*(YT(1:T,:)./YT(1,:)-1));
    title('T Output')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,3)
    p = plot(timescale',100.*(YN(1:T,:)./YN(1,:)-1));
    title('NT output')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,4)
p = plot(timescale',100.*(KT(1:T,:)./KT(1,:)-1));
    title('T capital stock')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,5)
p = plot(timescale',100.*(KN(1:T,:)./KN(1,:)-1));
    title('NT capital stock')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,6)
p = plot(timescale',100.*(L(1:T,:)./L(1,:)-1));
    title('Employment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,7)
p = plot(timescale',100.*(LT(1:T,:)./LT(1,:)-1));
    title('T employment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')


subplot(5,3,8)
p = plot(timescale',100.*(LNN(1:T,:)./LNN(1,:)-1));
    title('NT employment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,9)
p = plot(timescale',100.*(W(1:T,:)./W(1,:)-1));
    title('Wage')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,10)
p = plot(timescale',100.*(WT(1:T,:)./WT(1,:)-1));
    title('T wage')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,11)
p = plot(timescale',100.*(WN(1:T,:)./WN(1,:)-1));
    title('NT wage')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,12)
p = plot(timescale',100.*(LOPT(1:T,:)./LOPT(1,:)-1));
    title('OPT employment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,13)
p = plot(timescale',100.*(LROT(1:T,:)./LROT(1,:)-1));
    title('RoT employment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,14)
p = plot(timescale',100.*(C(1:T,:)./C(1,:)-1));
    title('Consumption')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,15)
p = plot(timescale',100.*(COPT(1:T,:)./COPT(1,:)-1));
    title('OPT Consumption')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')
    hL = legend('Baseline','Fiscal slippages',...
        'Unproductive capital inflows','Challenging export penetration',...
    'Orientation', 'horizontal', 'Units', 'normalized', 'Position',...
    [0.35, 0.02, 0.3, 0.05]); 

saveas(gcf,'charts/app_b/all_vars_1.jpg')

% 3.2 Part 2
f9 = figure('Name','Appendix B (Figure 2)');
subplot(5,3,1)
p = plot(timescale',100.*(CROT(1:T,:)./CROT(1,:)-1));
    title('RoT Consumption')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,2)
p = plot(timescale',100.*(Z(1:T,:)./Z(1,:)-1));
    title('Gov. Transfers')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,3)
p = plot(timescale',100.*(GC(1:T,:)./GC(1,:)-1));
    title('Gov. Consumption')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,4)
p = plot(timescale',100.*(R(1:T,:)-R(1,:)));
    title('Interest rate')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('p.p.')

subplot(5,3,5)
p = plot(timescale',100.*(IT(1:T,:)./IT(1,:)-1));
    title('T Investment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,6)
p = plot(timescale',100.*(IN(1:T,:)./IN(1,:)-1));
    title('NT Investment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,7)
p = plot(timescale',100.*(QT(1:T,:)./QT(1,:)-1));
    title('T Tobin Q')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,8)
p = plot(timescale',100.*(QN(1:T,:)./QN(1,:)-1));
    title('NT Tobin Q')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,9)
p = plot(timescale',100.*(GI(1:T,:)./GI(1,:)-1));
    title('Gov. Investment')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,10)
p = plot(timescale',100.*(B(1:T,:)./B(1,:)-1));
    title('Domestic public debt')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,11)
p = plot(timescale',100.*(DC(1:T,:)./DC(1,:)-1));
    title('External public debt')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,12)
p = plot(timescale',100.*(BSTAR(1:T,:)./BSTAR(1,:)-1));
    title('Foreign private debt')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,13)
p = plot(timescale',100.*(NX(1:T,:)./Y(1:T,:) - NX(1,:)./Y(1,:)));
    title('Net exports')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('p.p. of output')

subplot(5,3,14)
p = plot(timescale',100.*(XX(1:T,:)./(XX(1,:))-1));
    title('Exports')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,15)
p = plot(timescale',100.*(MM_TOTAL(1:T,:)./MM_TOTAL(1,:)-1));
    title('Imports')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')
    hL = legend('Baseline','Fiscal slippages',...
        'Unproductive capital inflows','Challenging export penetration',...
        'Orientation', 'horizontal', 'Units', 'normalized', 'Position',...
        [0.35, 0.02, 0.3, 0.05]); 

saveas(gcf,'charts/app_b/all_vars_2.jpg')

% 3.3 Part 3
f10 = figure('Name','Appendix B (Figure 3)');
subplot(5,3,1)
p = plot(timescale',100.*(TAUC(1:T,:)-TAUC(1,:)));
    title('Consumption tax rate')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('p.p.')
    xlabel('year')

subplot(5,3,2)
p = plot(timescale',100.*(TOT(1:T,:)./TOT(1,:)-1));
    title('Terms of trade')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,3)
p = plot(timescale',100.*(S(1:T,:)./S(1,:)-1));
    title('Exchange rate')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,4)
p = plot(timescale',100.*(PT(1:T,:)./PT(1,:)-1));
    title('T price index')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,5)
p = plot(timescale',100.*(PTH(1:T,:)./PTH(1,:)-1));
    title('T price index (domestic)')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,6)
p = plot(timescale',100.*(PN(1:T,:)./PN(1,:)-1));
    title('NT price index')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')

subplot(5,3,7)
p = plot(timescale',100.*(PG(1:T,:)./PG(1,:)-1));
    title('Gov purchases price index')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 1.5;
    p(2).Color = 'r';
    p(2).LineStyle = '--';
    p(2).LineWidth = 1.5;
    p(3).Color = 'g';
    p(3).LineStyle = '--';
    p(3).LineWidth = 1.5;
    p(4).Color = 'b';
    p(4).LineStyle = '--';
    p(4).LineWidth = 1.5;
    ylabel('%')
     hL = legend('Baseline','Fiscal slippages', ...
         'Unproductive capital inflows','Challenging export penetration',...
        'Orientation', 'horizontal', 'Units', 'normalized',...
        'Position', [0.35, 0.35, 0.3, 0.05]); 

saveas(gcf,'charts/app_b/all_vars_3.jpg')

%% 4. Plot alternative scenarios

% 4.1 Figure 8

f11 = figure('Name','Alternative scenarios - fiscal balance (Figure 8a)');
    p = plot(timescale(1:2,:)',PFB_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 3.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 3.5;
    legend('Baseline','Fiscal slippages','Location','southoutside',...
        'NumColumns',2);
 
saveas(gcf,'charts/fig8/PBY.jpg')

    
f12 = figure('Name',['Alternative scenarios - external public debt' ...
    ' (Figure 8b)']);
    p3 = plot(timescale(1:2,:)',FPD_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'r';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    legend('Baseline','Unproductive inflows','Location','southoutside',...
        'NumColumns',2);
    
saveas(gcf,'charts/fig8/EPDY.jpg')

    
 f13 = figure('Name',['Alternative scenarios - external private debt' ...
     ' (Figure 8c)']);
    p3 = plot(timescale(1:2,:)',DFD_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    legend('Baseline','Fiscal slippages','Location','southoutside',...
        'NumColumns',2);
    
saveas(gcf,'charts/fig8/EGDY.jpg')


f14 = figure('Name','Alternative scenarios - REER (Figure 8d)');
    p5 = plot(timescale(1:2,:)',S_y);
    ylabel('percent')
    xlabel('year')
    p5(1).Color = 'k';
    p5(1).LineStyle = '-';
    p5(1).LineWidth = 3.5;
    p5(2).Color = 'g';
    p5(2).LineStyle = '--';
    p5(2).LineWidth = 3.5;
    legend('Baseline','Challenging export penetration','Location',...
        'southoutside','NumColumns',2);
    
saveas(gcf,'charts/fig8/RER.jpg')

% Figure 7
   
f15 = figure('Name','Alternative scenarios - current account (Figure 7c)');
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
    p3(4).LineStyle = '-.';
    p3(4).LineWidth = 3.5;
    legend('Baseline','Fiscal slippages','Unproductive capital inflows',...
        'Challenging export penetration','Location','southoutside',...
        'NumColumns',2);

saveas(gcf,'charts/fig7/CADY.jpg')


f16 = figure('Name','Alternative scenarios - NIIP (Figure 7d)');
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
    legend('Baseline','Fiscal slippages','Unproductive capital inflows',...
        'Challenging export penetration','Location','southoutside',...
        'NumColumns',2);

saveas(gcf,'charts/fig7/NIIPY.jpg')


f17 = figure('Name','Alternative scenarios - public savings (Figure 7b)');
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
    p3(4).LineStyle = '-.';
    p3(4).LineWidth = 3.5;
    legend('Baseline','Fiscal slippages','Unproductive capital inflows',...
        'Challenging export penetration','Location','southoutside',...
        'NumColumns',2);

saveas(gcf,'charts/fig7/GSY.jpg')


f18 = figure('Name','Alternative scenarios - private savings (Figure 7a)');
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
    p3(4).LineStyle = '-.';
    p3(4).LineWidth = 3.5;
    legend('Baseline','Fiscal slippages','Unproductive capital inflows',...
        'Challenging export penetration','Location','southoutside',...
        'NumColumns',2);

saveas(gcf,'charts/fig7/PSY.jpg')