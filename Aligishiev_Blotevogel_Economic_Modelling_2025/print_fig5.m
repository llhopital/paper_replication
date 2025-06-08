figure('Name','Figure 5-1')
    bar(timescale,100.*[DEFF4 EXPORT -IMPORT RRFGR -FINC],'stacked')
        hold on 
        p4 = plot(timescale,100.*(CurrAcc(1:T)./Y(1:T)-CurrAcc(1)./Y(1)));
        ylabel('percentage points of GDP')
        xlabel('year')
        p4.Color = 'k';
        p4.LineStyle = '-';
        p4.LineWidth = 3.5;
        legend('GDP increase (Denominator growth)','Exports','Imports','RRF grant','Factor income (excl. RRF)','Current account balance','Location','southoutside','NumColumns',2);
        saveas(gcf,'charts/fig5/decomp_CAY.jpg')
    close;
    
    
    figure('Name','Figure 5-2')
    bar(timescale,-100.*[-DEFF3 FGL FPL TT2 -VC],'stacked')
        hold on 
        p3 = plot(timescale,100.*(NIIP(1:T)./Y(1:T) -NIIP(1)./Y(1)));
        ylabel('percentage points of GDP')
        xlabel('year')
        p3.Color = 'k';
        p3.LineStyle = '-';
        p3.LineWidth = 3.5;
        legend('GDP increase (Denominator growth)','Gov. liabilities','Private liabilities','RRF loan component','Valuation changes','NIIP','Location','southoutside','NumColumns',2);
        saveas(gcf,'charts/fig5/decomp_NIIPY.jpg')
    close;
    
    figure('Name','Figure 5-3')
     bar(timescale,100.*[DEFF1 -PD NBI DEP],'stacked')
        hold on 
        p1 = plot(timescale,100.*(PS(1:T)./Y(1:T) - PS(1)./Y(1)));
        ylabel('percentage points of GDP')
        xlabel('year')
        p1.Color = 'k';
        p1.LineStyle = '-';
        p1.LineWidth = 3.5;
        legend('GDP increase (Denominator growth)','Private foreign debt','Investment','Depreciation','Private savings','Location','southoutside','NumColumns',2);
        saveas(gcf,'charts/fig5/decomp_PSY.jpg')
    close;
    
    figure('Name','Figure 5-4')
    bar(timescale,100.*[DEFF2 DA GII GD],'stacked')
        hold on 
        p2 = plot(timescale,100.*(GS(1:T)./Y(1:T) -GS(1)./Y(1)));
        ylabel('percentage points of GDP')
        xlabel('year')
        p2.Color = 'k';
        p2.LineStyle = '-';
        p2.LineWidth = 3.5;
        legend('GDP increase (Denominator growth)','Public foreign debt','Investment','Depreciation','Public savings','Location','southoutside','NumColumns',2);
       saveas(gcf,'charts/fig5/decomp_GSY.jpg')
    close;
