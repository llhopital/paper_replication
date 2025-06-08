% Use this script to replicate main results of Aligishiev and Blotevogel (2025) "No Quick Fix: The Recovery and Resilience Plan and 
% External Position in Greece". These codes are based on the DIGNAR-19 toolkit (Aligishiev, Melina, Zanna, 2021).

clear all

%Preliminary definitions
T=26;
timescale = 0:1:0+T-1;
select_varrs = {'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN'; 'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT'; 'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S'; 'PTH'; 'PT'; 'PN'; 'PG'; 'CAD';'INV'};

% Calculate TFP and labour disutility shocks that approximately match
% output and employment gains from RRF in Malliaropulos et al. (2021)

calib_baseline;

% Loop to generate outputs for the Greece external sector note
for iiii = 1:14
    
    simulatescenarios;

    %Calculate gross savings
    PHS = Saving(1:T); %Household savings
    PNCS = (PN(1:T).*YN(1:T) + PTH(1:T).*YT(1:T)) - (WN(1:T).*LNN(1:T) + WT(1:T).*LT(1:T)) - (OMEGAN(1:T) + OMEGAT(1:T)); %Corporate savings
    PS = (PHS(1:T) + PNCS(1:T)); %Private savings
    GS = GSaving(1:T); %Government savings
    
    %The rest of variables
    NIIPY = (NIIP(1:T)./Y(1:T)); %NIIP to GDP
    CADY = (CAD(1:T)./Y(1:T)); % CAD to GDP
    OBY = OB(1:T)./Y(1:T);

    %% Calculate the decomposition of projections
    
    % Gross net private savings can be decomposed into: (a) nominal value of gov obligations; (b) private debt to foreigners; (c)
    % interest payments; (d) new business investment; (e) business dividents; (f)
    % depreciation of capital; and (g) portfolio adjustment costs
    
    NGO = [0; (B(2:T) - B(1:T-1))./Y(1)];
    PD = [0;(BSTAR(2:T).*S(1:T-1) - BSTAR(1:T-1).*S(1:T-1))./Y(1)]; % private foreign debt
    IP = ((RSTAR(1:T-1)-1).*S(2:T).*BSTAR(1:T-1));  
    IP = ([((RSTAR(1)-1).*BSTAR(1)); IP] - ((RSTAR(1)-1)*BSTAR(1)))./Y(1);
    DEP = (deltan*KN(1:T-1) + deltat*KT(1:T-1));
    DEP = ([(deltan*KN(1) + deltat*KT(1)); DEP] - (deltan*KN(1) + deltat*KT(1)))./Y(1);
    NBI = (INV(1:T) - INV(1))./Y(1) - DEP(1:T);
    DIV = ((OMEGAN(1:T) + OMEGAT(1:T)) - (OMEGAN(1) + OMEGAT(1)))./Y(1);
    PAC = ((eta./2).*omega.*(BOPT(1:T)-BOPT(1)).^2)./Y(1);
    DEFF1 = (100.*(PS(1:T)./Y(1:T) - PS(1)./Y(1)) - 100.*(PS(1:T) - PS(1))./Y(1))./100;

    %Gross government savings can be decomposed into: (a) government
    %investment; (b) interest payments; (c) foreign debt amortization (d) domestic debt amortization;
    GII = (PG(1:T).*GI(1:T) - PG(1).*GI(1))./Y(1);
    GD = [zeros(7,1); GII(8:T)];
    GII = [GII(1:7); zeros(T-7,1)];
    IPG = (rd(1:T-1)-1).*S(2:T).*D(1:T-1) + (RDC(1:T-1)-1).*S(2:T).*DC(1:T-1) + (R(1:T-1)-1).*B(1:T-1); 
    IPG = ([(rd(1)-1).*D(1) + (RDC(1)-1).*DC(1) + (R(1)-1).*B(1); IPG] - (rd(1)-1).*D(1) - (RDC(1)-1).*DC(1) - (R(1)-1).*B(1))./Y(1);
    DDA = ([0; diff(B(1:T))])./Y(1);
    CDA = ([0; diff(D(1:T)).*S(2:T)])./Y(1);
    %DA = ([0; diff(DC(1:T)).*S(2:T)])./Y(1) + CDA + DDA;
    DEFF2 = (100.*(GS(1:T)./Y(1:T) - GS(1)./Y(1)) - 100.*(GS(1:T) - GS(1))./Y(1))./100;
    DA = GS(1:T)./Y(1:T) -GS(1)./Y(1) - DEFF2 - GII - GD;
  
    %Change in NIIP can be decomposed into: (a) change in foreign government
    %liabilities and (b) chanage in foreign private liabilities. 
    FGL = (cumsum([0; diff(DC(1:T)).*S(2:T)]))./Y(1) + (cumsum([0; diff(D(1:T)).*S(2:T)]))./Y(1);
    FPL = (cumsum([0; diff(BSTAR(1:T)).*S(2:T)]))./Y(1);
    TT2 = (cumsum([0; Gov_sub(2:T)]))./Y(1);
    VC = (cumsum([0; (S(2:T)./S(1:T-1)-1).*NIIP(1:T-1)]))./Y(1);
    DEFF3 = (100.*(NIIP(1:T)./Y(1:T) - NIIP(1)./Y(1)) - 100.*(NIIP(1:T) - NIIP(1))./Y(1))./100;

    %CAD can be decomposed into (a) exports; (b) imports; and (c) factor
    %income.
    EXPORT = (XX(1:T).*PTH(1:T) - XX(1).*PTH(1))./Y(1);
    IMPORT = (MM_TOTAL(1:T).*S(1:T)-MM_TOTAL(1))./Y(1);
    CurrAcc = -CAD(1:T) ;
    FI = CAD(1:T) - MM_TOTAL(1:T).*S(1:T) + XX(1:T).*PTH(1:T) + GR(1:T).*S(1:T);
    FINC = (FI(1:T) - FI(1))./Y(1);
    RRFGR = (GR(1:T).*S(1:T) - GR(1))./Y(1);
    DEFF4 = (100.*(CurrAcc(1:T)./Y(1:T) - CurrAcc(1)./Y(1)) - 100.*(CurrAcc(1:T)./Y(1) - CurrAcc(1)./Y(1)))./100;
  
     
figure('Name','Scenario ' + string(iiii),'units','normalized','outerposition',[0 0 0.5 1])
    %real GDP level 
    subplot(2,2,1)
    bar(timescale,100.*[DEFF1 -PD NBI DEP],'stacked')
    hold on 
    p1 = plot(timescale,100.*(PS(1:T)./Y(1:T) - PS(1)./Y(1)));
    ylabel('percentage points of GDP')
    p1.Color = 'k';
    p1.LineStyle = '-';
    p1.LineWidth = 3.5;
    legend('GDP increase (Denominator growth)','Private foreign debt','Investment','Depreciation','Private savings','Location','southoutside','NumColumns',2);

    %Change in private sector savings Savings = Domestic bonds + foreign debt 
    subplot(2,2,2)
    bar(timescale,100.*[DEFF2 DA GII GD],'stacked')
    hold on 
    p2 = plot(timescale,100.*(GS(1:T)./Y(1:T) -GS(1)./Y(1)));
    ylabel('percentage points of GDP')
    p2.Color = 'k';
    p2.LineStyle = '-';
    p2.LineWidth = 3.5;
    legend('GDP increase (Denominator growth)','Public foreign debt','Investment','Depreciation','Public savings','Location','southoutside','NumColumns',2);

    %NIIP-to-GDP ratio
    subplot(2,2,3)
    bar(timescale,-100.*[-DEFF3 FGL FPL TT2 -VC],'stacked')
    hold on 
    p3 = plot(timescale,100.*(NIIP(1:T)./Y(1:T) -NIIP(1)./Y(1)));
    ylabel('percentage points of GDP')
    p3.Color = 'k';
    p3.LineStyle = '-';
    p3.LineWidth = 3.5;
    legend('GDP increase (Denominator growth)','Gov. liabilities','Private liabilities','RRF loan component','Valuation changes','NIIP','Location','southoutside','NumColumns',2);    
    
    %CAD
    subplot(2,2,4)
    bar(timescale,100.*[DEFF4 EXPORT -IMPORT RRFGR -FINC],'stacked')
    hold on 
    p4 = plot(timescale,100.*(CurrAcc(1:T)./Y(1:T)-CurrAcc(1)./Y(1)));
    ylabel('percentage points of GDP')
    p4.Color = 'k';
    p4.LineStyle = '-';
    p4.LineWidth = 3.5;
    legend('GDP increase (Denominator growth)','Exports','Imports','RRF grant','Factor inconme (excl. RRF)','Current account balance','Location','southoutside','NumColumns',2);    
    

   
    % Current GDP
    eval('Priv_save_y_s'+ string(iiii) + ' = 100.*(PS(1:T)./Y(1:T)- PS(1)./Y(1));');
    eval('Pub_save_y_s'+ string(iiii) + ' = 100.*(GS(1:T)./Y(1:T)-GS(1)./Y(1));');
    eval('NIIP_y_s'+ string(iiii) + ' = 100.*(NIIP(1:T)./Y(1:T)-NIIP(1)./Y(1));');
    eval('CAD_y_s'+ string(iiii) + ' = 100.*(CurrAcc(1:T)./Y(1:T)-CurrAcc(1)./Y(1));');
    eval('PFB_y_s'+ string(iiii) + ' = (TAUC(2:T).*C(2:T) + TAUL(2:T).*W(2:T).*L(2:T) + (1-varthetakappa(2:T)).*tauk(2:T).*(RKN(2:T).*KN(1:T-1)+RKT(2:T).*KT(1:T-1)) + mu(2:T).*KG(1:T-1) + S(2:T).*(ASTAR(2:T)+GR(2:T)+(rstar_net-ggamma)./(1+ggamma).*FSTAR(1:T-1)) - (PG(2:T).*GI(2:T) + PG(2:T).*GC(2:T) + Z(2:T)))./Y(2:T);'); 
    eval('PFB_y_s'+ string(iiii) + ' = [(TAUC(1).*C(1) + TAUL(1).*W(1).*L(1) + (1-varthetakappa(1)).*tauk(1).*(RKN(1).*KN(1)+RKT(1).*KT(1)) + mu(1).*KG(1) + S(1).*(ASTAR(1)+GR(1)+(rstar_net-ggamma)./(1+ggamma).*FSTAR(1)) - (PG(1).*GI(1) + PG(1).*GC(1) + Z(1)))./Y(1); PFB_y_s'+ string(iiii) + '];');
    eval('DFD_y_s'+ string(iiii) + ' = 100.*(S(1:T).*DC(1:T)./Y(1:T)-DC(1)./Y(1));');
    eval('FPD_y_s'+ string(iiii) + ' = 100.*(S(1:T).*BSTAR(1:T)./Y(1:T)-BSTAR(1)./Y(1));');
    eval('XX_y_s'+ string(iiii) + ' = 100.*(PTH(1:T).*XX(1:T)./Y(1:T) - XX(1)./Y(1));');
    eval('TOT_per_s'+ string(iiii) + ' = 100.*(S(1:T)./PTH(1:T)-1);');


    % 
    for mm = 1:size(select_varrs,1)
      eval(string(select_varrs(mm)) + '_s' + string(iiii) + ' = ' + select_varrs(mm) +'(1:T);');
    end

    eval('GI_s'+ string(iiii) + ' = PG(1:T).*(GI(1:T));');
    eval('DC_s'+ string(iiii) + ' = D(1:T)+DC(1:T);');
    eval('TOT_s'+ string(iiii) + ' = S(1:T)./PTH(1:T);');
    eval('NX_s'+ string(iiii) + ' = PTH(1:T).*XX(1:T) - S(1:T).*(MM_TOTAL(1:T));');
    
 
    %Save variables 
    eval('save(''scenario_s'+ string(iiii) + '.mat'', ''T'', ''timescale'', ''*_s'+ string(iiii) + ''');');



if iiii==1
    % Plots and saves figure 4
    print_fig4
    print_fig5
        
end



end

% Generate and save charts for main text and annex B
clear all
load('scenario_s1.mat');
load('scenario_s2.mat');
load('scenario_s3.mat');
load('scenario_s4.mat');

select_varrs2 = {'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN'; 'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT'; 'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S'; 'PTH'; 'PT'; 'PN'; 'GI'; 'DC'; 'TOT'; 'PG'; 'NX'; 'CAD'; 'Priv_save_y'; 'CAD_y'; 'Pub_save_y'; 'NIIP_y'; 'INV'};

timescale = [timescale; timescale; timescale; timescale];

for mm = 1:size(select_varrs2,1)
    eval(string(select_varrs2(mm)) + ' = [' + string(select_varrs2(mm)) + '_s1 ' + string(select_varrs2(mm)) + '_s2 ' + string(select_varrs2(mm)) + '_s3 ' + string(select_varrs2(mm)) + '_s4];');
end

% Plots and saves figure from annex B
print_fig6
print_all_scenarios_annex

PFB_y = [100.*(PFB_y_s1-PFB_y_s1(1)) 100.*(PFB_y_s2-PFB_y_s2(1))];
FPD_y = [FPD_y_s1 FPD_y_s3];
DFD_y = [DFD_y_s1 DFD_y_s2];
S_y   = [100.*(S_s1(1:T,:)./S_s1(1,:)-1) 100.*(S_s4(1:T,:)./S_s4(1,:)-1)];


% Plots and saves figure 5 and 6
print_fig78

% Generate and save charts for Annex D
clear all
load('scenario_s1.mat');
load('scenario_s5.mat');
load('scenario_s6.mat');

select_varrs2 = {'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN'; 'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT'; 'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S'; 'PTH'; 'PT'; 'PN'; 'GI'; 'DC'; 'TOT'; 'PG'; 'NX'; 'CAD'; 'Priv_save_y'; 'CAD_y'; 'Pub_save_y'; 'NIIP_y'; 'INV'};

timescale = [timescale; timescale; timescale];

for mm = 1:size(select_varrs2,1)
    eval(string(select_varrs2(mm)) + ' = [' + string(select_varrs2(mm)) + '_s1 ' + string(select_varrs2(mm)) + '_s5 ' + string(select_varrs2(mm)) + '_s6];');
end

print_figd1

% Generate and save charts for Annex D-1, D-2
clear all
load('scenario_s2.mat');
load('scenario_s7.mat');
load('scenario_s8.mat');

select_varrs2 = {'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN'; 'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT'; 'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S'; 'PTH'; 'PT'; 'PN'; 'GI'; 'DC'; 'TOT'; 'PG'; 'NX'; 'CAD'; 'Priv_save_y'; 'CAD_y'; 'Pub_save_y'; 'NIIP_y'; 'INV'};

timescale = [timescale; timescale; timescale];

for mm = 1:size(select_varrs2,1)
    eval(string(select_varrs2(mm)) + ' = [' + string(select_varrs2(mm)) + '_s2 ' + string(select_varrs2(mm)) + '_s7 ' + string(select_varrs2(mm)) + '_s8];');
end

print_figd2

% Generate and save charts for Annex D
clear all
load('scenario_s1.mat');
load('scenario_s9.mat');
load('scenario_s10.mat');
load('scenario_s11.mat');
load('scenario_s12.mat');

select_varrs2 = {'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN'; 'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT'; 'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S'; 'PTH'; 'PT'; 'PN'; 'GI'; 'DC'; 'TOT'; 'PG'; 'NX'; 'CAD'; 'Priv_save_y'; 'CAD_y'; 'Pub_save_y'; 'NIIP_y'; 'INV'};

timescale = [timescale; timescale; timescale; timescale; timescale];

for mm = 1:size(select_varrs2,1)
    eval(string(select_varrs2(mm)) + ' = [' + string(select_varrs2(mm)) + '_s1 ' + string(select_varrs2(mm)) + '_s9 ' + string(select_varrs2(mm)) + '_s10 ' + string(select_varrs2(mm)) + '_s11 ' + string(select_varrs2(mm)) + '_s12];');
end

print_figd3


% Generate and save charts for Annex D
clear all
load('scenario_s1.mat');
load('scenario_s13.mat');
load('scenario_s14.mat');

select_varrs2 = {'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN'; 'WT'; 'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT'; 'QN'; 'QT'; 'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S'; 'PTH'; 'PT'; 'PN'; 'GI'; 'DC'; 'TOT'; 'PG'; 'NX'; 'CAD'; 'Priv_save_y'; 'CAD_y'; 'Pub_save_y'; 'NIIP_y'; 'INV'};

timescale = [timescale; timescale; timescale];

for mm = 1:size(select_varrs2,1)
    eval(string(select_varrs2(mm)) + ' = [' + string(select_varrs2(mm)) + '_s1 ' + string(select_varrs2(mm)) + '_s13 ' + string(select_varrs2(mm)) + '_s14];');
end

print_figd4
