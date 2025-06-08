% Figure 5
figure('Name','Figure 8-1')
    p = plot(timescale(1:2,:)',PFB_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p(1).Color = 'k';
    p(1).LineStyle = '-';
    p(1).LineWidth = 3.5;
    p(2).Color = 'b';
    p(2).LineStyle = '--';
    p(2).LineWidth = 3.5;
    legend('Baseline','Fiscal slippages','Location','southoutside','NumColumns',2);
    saveas(gcf,'charts/fig8/PBY.jpg')
    close;
    
figure('Name','Figure 8-2')
    p3 = plot(timescale(1:2,:)',FPD_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'r';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    legend('Baseline','Unproductive inflows','Location','southoutside','NumColumns',2);
    saveas(gcf,'charts/fig8/EPDY.jpg')
    close;
    
  figure('Name','Figure 8-3')
    p3 = plot(timescale(1:2,:)',DFD_y);
    ylabel('percentage points of GDP')
    xlabel('year')
    p3(1).Color = 'k';
    p3(1).LineStyle = '-';
    p3(1).LineWidth = 3.5;
    p3(2).Color = 'b';
    p3(2).LineStyle = '--';
    p3(2).LineWidth = 3.5;
    legend('Baseline','Fiscal slippages','Location','southoutside','NumColumns',2);
    saveas(gcf,'charts/fig8/EGDY.jpg')
    close;
    
figure('Name','Figure 8-4')
    p5 = plot(timescale(1:2,:)',S_y);
    ylabel('percent')
    xlabel('year')
    p5(1).Color = 'k';
    p5(1).LineStyle = '-';
    p5(1).LineWidth = 3.5;
    p5(2).Color = 'g';
    p5(2).LineStyle = '--';
    p5(2).LineWidth = 3.5;
    legend('Baseline','Challenging export penetration','Location','southoutside','NumColumns',2);
    saveas(gcf,'charts/fig8/RER.jpg')
    close;


% Figure 6
figure('Name','Figure 7-1')
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
legend('Baseline','Fiscal slippages','Unproductive capital inflows','Challenging export penetration','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/fig7/CADY.jpg')
close;

figure('Name','Figure 7-4')
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
legend('Baseline','Fiscal slippages','Unproductive capital inflows','Challenging export penetration','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/fig7/NIIPY.jpg')
close;

figure('Name','Figure 7-2')
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
legend('Baseline','Fiscal slippages','Unproductive capital inflows','Challenging export penetration','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/fig7/GSY.jpg')
close;

figure('Name','Figure 7-3')
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
legend('Baseline','Fiscal slippages','Unproductive capital inflows','Challenging export penetration','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/fig7/PSY.jpg')
close;
