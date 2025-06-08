
% Figure 6
figure('Name','Figure D1-1')
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
legend('Consumption tax (Baseline)','Labour tax','Transfers','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/figd1/CADY.jpg')
close;

figure('Name','Figure D1-4')
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
legend('Consumption tax (Baseline)','Labour tax','Transfers','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/figd1/NIIPY.jpg')
close;

figure('Name','Figure D1-2')
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
legend('Consumption tax (Baseline)','Labour tax','Transfers','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/figd1/GSY.jpg')
close;

figure('Name','Figure D1-3')
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
legend('Consumption tax (Baseline)','Labour tax','Transfers','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/figd1/PSY.jpg')
close;
