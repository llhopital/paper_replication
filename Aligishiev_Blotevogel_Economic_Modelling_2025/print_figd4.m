
% Figure 6
figure('Name','Figure D4-1')
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
legend('Full package','Net of labour disutility shock','Net of TFP shock','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/figd4/CADY.jpg')
close;

figure('Name','Figure D4-4')
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
legend('Full package','Net of labour disutility shock','Net of TFP shock','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/figd4/NIIPY.jpg')
close;

figure('Name','Figure D4-2')
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
legend('Full package','Net of labour disutility shock','Net of TFP shock','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/figd4/GSY.jpg')
close;

figure('Name','Figure D4-3')
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
legend('Full package','Net of labour disutility shock','Net of TFP shock','Location','southoutside','NumColumns',2);
saveas(gcf,'charts/figd4/PSY.jpg')
close;
