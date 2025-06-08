
% Figure 6
figure('Name','Figure D3-1')
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
legend('$\chi^T=1.5$','$\chi^T=1.1$','$\chi^T=2.6$','$\chi^T=2.9$','$\chi^T=3.5$','Location','southoutside','NumColumns',2,'Interpreter','latex');
saveas(gcf,'charts/figd3/CADY.jpg')
close;

figure('Name','Figure D3-4')
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
legend('$\chi^T=1.5$','$\chi^T=1.1$','$\chi^T=2.6$','$\chi^T=2.9$','$\chi^T=3.5$','Location','southoutside','NumColumns',2,'Interpreter','latex');
saveas(gcf,'charts/figd3/NIIPY.jpg')
close;

figure('Name','Figure D3-2')
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
legend('$\chi^T=1.5$','$\chi^T=1.1$','$\chi^T=2.6$','$\chi^T=2.9$','$\chi^T=3.5$','Location','southoutside','NumColumns',2,'Interpreter','latex');
saveas(gcf,'charts/figd3/GSY.jpg')
close;

figure('Name','Figure D3-3')
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
legend('$\chi^T=1.5$','$\chi^T=1.1$','$\chi^T=2.6$','$\chi^T=2.9$','$\chi^T=3.5$','Location','southoutside','NumColumns',2,'Interpreter','latex');
saveas(gcf,'charts/figd3/PSY.jpg')
close;
