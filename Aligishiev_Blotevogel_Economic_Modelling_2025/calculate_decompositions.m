    PHS = Saving(1:T); 
    PNCS = (PN(1:T).*YN(1:T) + PTH(1:T).*YT(1:T)) - (WN(1:T).*LNN(1:T) + WT(1:T).*LT(1:T)) - (OMEGAN(1:T) + OMEGAT(1:T)); 
    PS = (PHS(1:T) + PNCS(1:T)); 
    GS = GSaving(1:T); 
    NIIPY = (NIIP(1:T)./Y(1:T)); 
    CADY = (CAD(1:T)./Y(1:T)); 
    OBY = OB(1:T)./Y(1:T); 

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