figure('Name','Figure 6-1','units','normalized','outerposition',[0 0 0.5 1])
%real GDP level
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

legend('Baseline','Fiscal slippages','Unproductive capital inflows','Challenging export penetration','orientation','horizontal','location','none')
saveas(gcf,'charts/fig6/all_vars.jpg')