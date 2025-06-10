%=========================================================================
% print_fig46.m
% Generates and saves figures 4 and 6
%=========================================================================  

%% 1. Environment initialization

% Ensure output directory exists
if ~exist(fullfile('charts', 'fig4'), 'dir')
    mkdir(fullfile('charts', 'fig4'));
end

if ~exist(fullfile('charts', 'fig6'), 'dir')
    mkdir(fullfile('charts', 'fig6'));
end

%% 2. Figure 4
f2 = figure('Name','Exogenous shocks (Figure 4)');
    subplot(4,1,1)
    bar(timescale(1:25),100.*[(GR(1:25)-GR(1))./Y(1)])
        axis([0 25 -0.5 2.5])
        ylabel('%')
        xlabel('year')
        title('Official grants')
        subplot(4,1,2)
        bar(timescale(1:25),100.*[(Gov_sub(1:25))./Y(1)])
        axis([0 25 -0.5 2.5])
        ylabel('%')
        xlabel('year')
        title('Official loans')
        subplot(4,1,3)
        bar(timescale(1:25),100.*[(GI(1:25)-GI(1))./Y(1)])
        axis([0 25 -0.5 2.5])
        ylabel('%')
        xlabel('year')
        title('Public investment')
        subplot(4,1,4)
        bar(timescale(1:25),100.*[(GC(1:25)-GC(1))./Y(1)])
        axis([0 25 -0.5 2.5])
        ylabel('%')
        xlabel('year')
        title('Public consumption')

saveas(gcf,'charts/fig4/shocks.jpg')

%% 3. Figure 6

f3 = figure('Name',['Baseline current account response decomposition ' ...
    '(Figure 6c)']);
    bar(timescale,100.*[DEFF4 EXPORT -IMPORT RRFGR -FINC],'stacked')
        hold on 
        p4 = plot(timescale,100.*(CurrAcc(1:T)./Y(1:T)-CurrAcc(1)./Y(1)));
        ylabel('percentage points of GDP')
        xlabel('year')
        p4.Color = 'k';
        p4.LineStyle = '-';
        p4.LineWidth = 3.5;
        legend('GDP increase (Denominator growth)','Exports','Imports',...
            'RRF grant','Factor income (excl. RRF)',...
            'Current account balance','Location','southoutside',...
            'NumColumns',2);
 
saveas(gcf,'charts/fig6/decomp_CAY.jpg')
    
f4 = figure('Name','Baseline NIIP response decomposition (Figure 6d)');
    bar(timescale,-100.*[-DEFF3 FGL FPL TT2 -VC],'stacked')
        hold on 
        p3 = plot(timescale,100.*(NIIP(1:T)./Y(1:T) -NIIP(1)./Y(1)));
        ylabel('percentage points of GDP')
        xlabel('year')
        p3.Color = 'k';
        p3.LineStyle = '-';
        p3.LineWidth = 3.5;
        legend('GDP increase (Denominator growth)','Gov. liabilities',...
            'Private liabilities','RRF loan component',...
            'Valuation changes','NIIP','Location','southoutside',...
            'NumColumns',2);
        
saveas(gcf,'charts/fig6/decomp_NIIPY.jpg')
    
f5 = figure('Name',['Baseline private savings response decomposition' ...
    ' (Figure 6a)']);
     bar(timescale,100.*[DEFF1 -PD NBI DEP],'stacked')
        hold on 
        p1 = plot(timescale,100.*(PS(1:T)./Y(1:T) - PS(1)./Y(1)));
        ylabel('percentage points of GDP')
        xlabel('year')
        p1.Color = 'k';
        p1.LineStyle = '-';
        p1.LineWidth = 3.5;
        legend('GDP increase (Denominator growth)','Private foreign debt',...
            'Investment','Depreciation','Private savings','Location',...
            'southoutside','NumColumns',2);
        
saveas(gcf,'charts/fig6/decomp_PSY.jpg')
    
f6 = figure('Name',['Baseline public savings response decomposition' ...
    ' (Figure 6b)']);
    bar(timescale,100.*[DEFF2 DA GII GD],'stacked')
        hold on 
        p2 = plot(timescale,100.*(GS(1:T)./Y(1:T) -GS(1)./Y(1)));
        ylabel('percentage points of GDP')
        xlabel('year')
        p2.Color = 'k';
        p2.LineStyle = '-';
        p2.LineWidth = 3.5;
        legend('GDP increase (Denominator growth)','Public foreign debt',...
            'Investment','Depreciation','Public savings','Location',...
            'southoutside','NumColumns',2);
       
saveas(gcf,'charts/fig6/decomp_GSY.jpg')

