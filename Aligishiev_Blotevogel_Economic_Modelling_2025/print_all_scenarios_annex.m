figure('Name','Figure C-1','units','normalized','outerposition',[0 0 0.5 1])
%real GDP level
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

legend('Baseline','Fiscal slippages','Unproductive capital inflows','Challenging export penetration','orientation','horizontal','location','none')
saveas(gcf,'charts/figC/all_vars_1.jpg')


figure('Name','Figure C-2','units','normalized','outerposition',[0 0 0.5 1])
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


legend('Baseline','Fiscal slippages','Unproductive capital inflows','Challenging export penetration','orientation','horizontal','location','none')
saveas(gcf,'charts/figC/all_vars_2.jpg')

figure('Name','Figure C-3','units','normalized','outerposition',[0 0 0.5 1])

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

legend('Baseline','Fiscal slippages','Unproductive capital inflows','Challenging export penetration','orientation','horizontal','location','none')
saveas(gcf,'charts/figC/all_vars_3.jpg')