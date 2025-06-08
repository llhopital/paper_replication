%% RECOVER IMPLICIT PARAMETERS FROM STEADY-STATE ROUTINE
rd              = STEADY_STATE(rd); 
rf              = STEADY_STATE(rf);
u               = STEADY_STATE(u);
upsilondc       = STEADY_STATE(upsilondc);
mu              = STEADY_STATE(mu);
varrho          = STEADY_STATE(varrho);
zn              = STEADY_STATE(zn);
tauk/STEADY_STATE(tauk) = exp(-0.5*(KG(-1)-STEADY_STATE(KG)));
%tauk = STEADY_STATE(tauk);
varphi          = STEADY_STATE(varphi);
nu              = STEADY_STATE(nu);
betaa           = STEADY_STATE(betaa);
delta           = STEADY_STATE(delta);
taukoff         = STEADY_STATE(taukoff);
kappaopt        = STEADY_STATE(kappaopt); 
kapparot        = STEADY_STATE(kapparot);
%chiM            = STEADY_STATE(chiM);
MM_K   = STEADY_STATE(MM_K)/STEADY_STATE(Y)*Y;
temp1           = STEADY_STATE(temp1);
%add omega


%% MODEL EQUATIONS

% Gov subsidy
Gov_sub = STEADY_STATE(Y)*ex_xx;

loan_sum = Gov_sub+loan_sum(-1);

%Remittances
rem = STEADY_STATE(rem); %%%%
varthetakappa   = STEADY_STATE(varthetakappa);

% Relative prices
1 = ( varphi * PN^(1-chi) + (1-varphi) * PT^(1-chi) )^( 1/(1-chi) );
PT = ( varphiT * (PTH)^(1-chiT) + (1-varphiT) * S^(1-chiT) )^( 1/(1-chiT) ); 
PTH_S = 1;

% Total labor L
L = (( delta^(-1/rho) * LNN^((rho+1)/rho) + (1-delta)^(-1/rho) * LT^((rho+1)/rho))^(rho/(rho+1)));

% Supply of labor to non-traded sector
LNN = delta * (WN/W)^(rho) * L;

% Supply of labor to traded sector
LT = (1-delta) * (WT/W)^(rho) * L;

% FOC for COPT
LAMBDA * (1+TAUC) = (COPT)^(-ssigma);

[name='check']
% FOC for LOPT 
exp(rhoMM*ex_sick)*kappaopt * LOPT^(psiopt) = (1-TAUL) * W * LAMBDA;

% Euler equation 
LAMBDA = betaa*LAMBDA(+1)*R/(1+ggamma);

% Uncovered interest rate parity
R/RSTAR =  S(+1)/(S-eta*(BOPT-STEADY_STATE(BOPT)));


% Interest rate paid on foreign debt by private agents
RSTAR = RDC + u;

% FOC for CROT 
LAMBDAROT * (1+TAUC) = (CROT)^(-ssigma);

% FOC for LROT 
exp(ex_sick)*kapparot * LROT^(psirot) = (1-TAUL) * W * LAMBDAROT;

% Consumption rule of the rule-of-thumb 
(1+TAUC)*CROT = (1-TAUL)*W*LROT + S*rem +Z -mu*(KG(-1));

% Aggregate consumption 
C = omega*COPT + (1-omega)*CROT;
[name='check']
% Aggregate labor 
L = omega*LOPT + (1-omega) * LROT;

% Foreign indebtedness of private agents 
BSTAR = omega * BOPT;
    
% Production function for nontradables 
YN = exp(EPSILONG*ex_yy)*zn * KN(-1)^(1-alphan) * LNN^alphan * KG(-1)^alphag;
    
% Law of motion for KN
(1+ggamma) * KN = (1-deltan) * KN(-1) + (1-(1+ggamma)^2 * kappan/2 * (IN/IN(-1)-1)^2) * IN; 

% Demand for LN 
LNN = (MCN * PN * alphan  * zn * KN(-1)^(1-alphan) * KG(-1)^alphag/ WN)^(1/(1-alphan));
    
% FOC for KN
(1+ggamma) * QN = betaa * LAMBDA(+1) / LAMBDA * ( (1-deltan) * QN(+1) + ( (1-tauk) * MCN(+1) * (1-alphan) * PN(+1) *YN(+1) / KN ) );
    
% FOC for IN
1/QN = 1 - kappan/2 * (1+ggamma)^2 * (IN/IN(-1)-1)^2 - kappan * (1+ggamma)^2 * IN/IN(-1) * (IN/IN(-1)-1) 
     + betaa * kappan * (1+ggamma)^2 * QN(+1)/QN * LAMBDA(+1)/LAMBDA * (IN(+1)/IN)^2 * (IN(+1)/IN-1); 

% Phillips curve for nontradables
1 - xin * (PIEN - STEADY_STATE(PIEN))*PIEN + (1+ggamma) * xin * betaa * LAMBDA(+1) / LAMBDA * (PIEN(+1) - STEADY_STATE(PIEN))*PIEN(+1) * PN(+1)/PN * YN(+1)/YN = (1-MCN) * zzeta;

% Return of capital for nontradables
RKN = MCN*(1-alphan)*PN*YN/KN(-1);
           
% Production function for tradables
YT = exp(EPSILONG*ex_yy)*ZT * KT(-1)^(1-alphat) * KG(-1)^alphag * LT^alphat;

% Productivity for the traded sector
ZT = STEADY_STATE(ZT);

% Law of motion for KT
(1+ggamma)*KT = (1-deltat) * KT(-1) + ( 1 - (1+ggamma)^2 *kappat/2 * ( IT/IT(-1) - 1 )^2 ) * IT;
    
% Demand for LT 
LT = (MCT * PTH * alphat * ZT * KT(-1)^(1-alphat) * KG(-1)^alphag/ WT)^(1/(1-alphat));
    
% FOC for KT
(1+ggamma) * QT = betaa * ( LAMBDA(+1)/LAMBDA * ( (1-deltat) * QT(+1) + MCT(+1) * (1-alphat) * (1-tauk) *PTH(+1) * YT(+1) / KT ) );
    
% FOC for IT
1/QT = 1 - kappat/2 * (1+ggamma)^2 * ( IT/IT(-1) - 1 )^2 - kappat * (1+ggamma)^2 * IT/IT(-1) * ( IT/IT(-1) - 1 ) 
      + betaa *kappat * (1+ggamma)^2 * QT(+1)/QT * LAMBDA(+1)/LAMBDA * (IT(+1)/IT)^2 * (IT(+1)/IT-1);

% Phillips curve for tradable home goods
1 - xit * (PIETH - STEADY_STATE(PIETH))*PIETH + (1+ggamma) * xit * betaa * LAMBDA(+1) / LAMBDA * (PIETH(+1) - STEADY_STATE(PIETH))*PIETH(+1) * PTH(+1)/PTH * YT(+1)/YT = (1-MCT) *zzeta;

% Return of capital for nontradables
RKT = MCT*(1-alphat)*PTH*YT/KT(-1);
   
      
% Relative price of PG to CPI
PG = ( NUT * PN^(1-chi) + (1-NUT) * PTG^(1-chi) )^( 1/(1-chi) );
PTG = ( nutt * PTH^(1-chiT) + (1-nutt) * S^(1-chiT) )^( 1/(1-chiT) ); %#2

% Degree of home bias on additional government purchases
NUT = (STEADY_STATE(PG)*STEADY_STATE(G)*nu + (PG*G-STEADY_STATE(PG)*STEADY_STATE(G))*nug)/(PG*G);

% Investment expenditure growth  
GI_GROWTH = ggamma+(GI/GI(-1)-1);

[name='check2']
% Effective government investment
GITILDE = EPSILON*GI; 

% Degree of bottleneck 
EPSILON = STEADY_STATE(EPSILON);

% Law of motion for public capital 
(1+ggamma)*KG = (1-DELTAGT)*KG(-1) + GITILDE;

% Depreciation rate of public capital
DELTAGT = STEADY_STATE(DELTAGT);

% Sovereign wealth fund 
FSTAR = STEADY_STATE(FSTAR);

TOTREV = STEADY_STATE(TAUC)*C + STEADY_STATE(TAUL)*W*L + (1-varthetakappa)*STEADY_STATE(tauk)*(RKN*KN(-1)+RKT*KT(-1))
       + mu*(KG(-1)) + S*(ASTAR+GR+(rstar_net-ggamma)/(1+ggamma)*FSTAR(-1)+D);
TOTEXP = PG*(GI) + PG*STEADY_STATE(GC) + STEADY_STATE(Z) + S*rd*D(-1)/(1+ggamma) + (RDC(-1)-1-ggamma)/(1+ggamma)*S*DC(-1) + (R(-1)-1-ggamma)/(1+ggamma)*B(-1); 

% Government investment rule

GI= STEADY_STATE(GI) + STEADY_STATE(Y)*0.67*(eps_inv+eps_yo)/STEADY_STATE(PG);


% Fiscal gap 
GAP = PG*(GI) + rd*S*D(-1)/(1+ggamma) - S*D + (RDC(-1)-1-ggamma)/(1+ggamma)*S*DC(-1) + (R(-1)-1-ggamma)/(1+ggamma)*B(-1)+PG*STEADY_STATE(GC)
    + STEADY_STATE(Z) - STEADY_STATE(TAUC)*C - STEADY_STATE(TAUL)*W*L - mu*(KG(-1))
    - (1-varthetakappa)*STEADY_STATE(tauk)*(RKN*KN(-1)+RKT*KT(-1)) - S*(ASTAR-FSTAR+GR+(1+rstar_net)/(1+ggamma)*FSTAR(-1) );

% Reaction to close the gap    
GAP =  B-B(-1) + S*( DC-DC(-1) ) + ( TAUC-STEADY_STATE(TAUC) )*C + ( TAUL-STEADY_STATE(TAUL) )*W*L 
                        - PG*( GC - STEADY_STATE(GC) ) - ( Z - STEADY_STATE(Z) ) ;

% Total government purchases
G = GI + GC;

% Interest rate paid by the government on foreign commercial debt 
RDC = rf + upsilondc * exp((etadc)*(S*(D+DC)/Y - (STEADY_STATE(D)+STEADY_STATE(DC))/STEADY_STATE(Y)));

% Split between domestic debt and foreign commercial debt
%varkappa*(B/S-B(-1)/S(-1)) = (1-varkappa)*S*(DC-DC(-1));
varkappa*(B-B(-1)) = (1-varkappa)*S*(DC-DC(-1));


% Target consumption tax rate
TAUCTAR = STEADY_STATE(TAUC) + lambda1 * GAP/C;

% Target labour income tax rate
TAULTAR = STEADY_STATE(TAUL) + lambda2 * GAP/(W*L);

% Target government consumption
GCTAR   = STEADY_STATE(GC)   - lambda3 * GAP/PG;

% Target government transfers
ZTAR    = STEADY_STATE(Z)    - lambda4 * GAP;

% Effective consumption tax rate
TAUC =   TAUCRULE;

% Effective labour income tax rate
TAUL =   TAULRULE;

% Effective government consumption
%GC   = GCRULE;
GC   = STEADY_STATE(GC) + STEADY_STATE(Y)*(1-0.67)*eps_inv;
%0.625*

% Effective government transfers
Z  = ZRULE ;

% Consumption tax rate rule
TAUCRULE = TAUC(-1) + zzeta1 * (TAUCTAR - TAUC(-1)) + zzeta2 * (BSHARE(-1) - STEADY_STATE(BSHARE)); 



[name='Labour income tax rate rule']
TAULRULE = TAUL(-1) + zzeta3 * (TAULTAR - TAUL(-1)) + zzeta4 * (BSHARE(-1) - STEADY_STATE(BSHARE));

% Government consumption rule
GCRULE/STEADY_STATE(GC)   = GC(-1)/STEADY_STATE(GC)   + zzeta5 * (GCTAR   - GC(-1))/STEADY_STATE(GC)   - zzeta6 * (BSHARE(-1) - STEADY_STATE(BSHARE));

% Government transfers rule
ZRULE/STEADY_STATE(Z)    = Z(-1)/STEADY_STATE(Z)    + zzeta7 * (ZTAR    - Z(-1))/STEADY_STATE(Z)    - zzeta8 * (BSHARE(-1) - STEADY_STATE(BSHARE));

% Debt to GDP ratio
BSHARE = (B+S*DC)/Y; %81

% Monetary policy
PIEN = PIE * PN/PN(-1);
PIET = PIE * PT/PT(-1);
PIETH = PIE * PTH/PTH(-1); 
R = RN / PIE(+1);
log(RN/STEADY_STATE(RN)) = varrhor*log(RN(-1)/STEADY_STATE(RN)) + (1-varrhor)*(varrhopie*log(PIE/STEADY_STATE(PIE))+varrhoy*log(Y/STEADY_STATE(Y)));  

% Demand for nontradables 
DN = varphi*(C + IN + IT+ eta/2*(BOPT-STEADY_STATE(BOPT))^2 + xit/2 * (PIETH - STEADY_STATE(PIETH))^2 + xin/2 * (PIEN - STEADY_STATE(PIEN))^2) + NUT*PG^chi*G; %86
    
% Nontradable goods identity 
YN = PN^(-chi) * DN;

% Total GDP
Y = PN*(YN) + PTH*(YT); 

% Total investment 
INV = IN + IT;

% Market clearing for traded home goods
YT = varphiT *(PTH/PT)^(-chiT) * (1-varphi) * PT^(-chi) *(C + IN + IT)
   + nutt*(PTH/PTG)^(-chiT) *(1-NUT)*(PTG/PG)^(-chi)*G + (1+temp1)*XX; %#4  

   
% Exogenous exports
%XX/Y = STEADY_STATE(XX)/STEADY_STATE(Y); 
XX/STEADY_STATE(XX) = (S/PTH)^chiX; 
%XX/STEADY_STATE(XX) = (S/PT)^(chiT); 

% Imports

[name='check']
%S*(MM_TOTAL + 0.99*(MM_FF/MM_FF(-1)-1)^2 + 0.05*(MM_FF - STEADY_STATE(MM_FF))  ) = PTH*XX + C + INV + PG * G + xit/2 * (PIET - STEADY_STATE(PIET))^2 + xin/2 * (PIEN - STEADY_STATE(PIEN))^2 + eta/2*(BOPT-STEADY_STATE(BOPT))^2 
    % - PN * YN  -PTH * YT;
 
%EPSILONM*S*(MM_TOTAL) = PTH*XX + C + INV + PG * G + xit/2 * (PIET - STEADY_STATE(PIET))^2 + xin/2 * (PIEN - STEADY_STATE(PIEN))^2 + eta/2*(BOPT-STEADY_STATE(BOPT))^2 
   %  - PN * YN  -PTH * YT;

S*(MM_TOTAL) = PTH*XX + C + INV + PG * G + xit/2 * (PIET - STEADY_STATE(PIET))^2 + xin/2 * (PIEN - STEADY_STATE(PIEN))^2 + eta/2*(BOPT-STEADY_STATE(BOPT))^2 
     - PN * YN  -PTH * YT;

EPSILONM = 1;

%EPSILONM = (MM_TOTAL/STEADY_STATE(MM_TOTAL)-1<=mmthreshold) * (STEADY_STATE(EPSILONM)) + 
         %(MM_TOTAL/STEADY_STATE(MM_TOTAL)-1>mmthreshold)  * (exp(2.5*(MM_TOTAL/STEADY_STATE(MM_TOTAL)-1-mmthreshold))*STEADY_STATE(EPSILONM));

%MM_TOTAL = MM + MM_FF + MM_K + 0.25*STEADY_STATE(Y)*(eps_inv + eps_yo) - 0.3*(MM_FF-STEADY_STATE(MM_FF));
%MM_TOTAL = ((1-0.25-0.0092)^(-1/rhoMM)*MM^((1+rhoMM)/rhoMM) + 0.25^(-1/rhoMM)*MM_FF^((1+rhoMM)/rhoMM) + 0.0092^(-1/rhoMM)*(MM_K + 0.25*STEADY_STATE(Y)*(eps_inv + eps_yo))^((1+rhoMM)/rhoMM) )^(rhoMM/(1+rhoMM));


% Current account deficits
CAD = S*(MM_TOTAL - rem - ASTAR - GR) - PTH*XX + S*( -(rstar_net-ggamma)/(1+ggamma)*FSTAR(-1) + (rd-1-ggamma)/(1+ggamma)*D(-1) + (RDC(-1)-1-ggamma)/(1+ggamma)*DC(-1) + (RSTAR(-1)-1-ggamma)/(1+ggamma)*BSTAR(-1));

% Balance of payment condition 
CAD = S*(FSTAR(-1)/(1+ggamma) - FSTAR + D - D(-1)/(1+ggamma) + DC - DC(-1)/(1+ggamma)+ BSTAR - BSTAR(-1)/(1+ggamma) - (T2-T2(-1))) + Gov_sub;

%T2 = MM + MM_FF + MM_K + 0.25*STEADY_STATE(Y)*eps_inv - rem - ASTAR - GR -(rstar_net-ggamma)/(1+ggamma)*FSTAR(-1) 
%+ (rd-1-ggamma)/(1+ggamma)*D(-1) + (RDC(-1)-1-ggamma)/(1+ggamma)*DC(-1) + (RSTAR(-1)-1-ggamma)/(1+ggamma)*BSTAR(-1) + FSTAR(-1)/(1+ggamma) 
%- FSTAR + D - D(-1)/(1+ggamma) + DC - DC(-1)/(1+ggamma)+ BSTAR - BSTAR(-1)/(1+ggamma) - (STEADY_STATE(MM) + STEADY_STATE(MM_FF) + STEADY_STATE(MM_K)
% - STEADY_STATE(rem) - STEADY_STATE(ASTAR) - STEADY_STATE(GR) -(rstar_net-ggamma)/(1+ggamma)*STEADY_STATE(FSTAR) 
%+ (rd-1-ggamma)/(1+ggamma)*STEADY_STATE(D) + (STEADY_STATE(RDC)-1-ggamma)/(1+ggamma)*STEADY_STATE(DC) + (STEADY_STATE(RSTAR)-1-ggamma)/(1+ggamma)*STEADY_STATE(BSTAR))/S*(PTH*XX)/(STEADY_STATE(PTH)*STEADY_STATE(XX));


%-T2 = 0.13*(R-rf);

T2 = 0;
     
% Concessional debt
D = STEADY_STATE(D);

% Grants
[name='Grants']
GR-STEADY_STATE(GR) = (STEADY_STATE(Y)*0.67*eps_inv/STEADY_STATE(PG) + STEADY_STATE(Y)*(1-0.67)*eps_inv)/S ; 

% Foreign aid
ASTAR = STEADY_STATE(ASTAR);
    
% Profits of non-traded sector
OMEGAN = PN*YN - WN*LNN - IN;
    
% Profits of traded sector
OMEGAT = PTH*YT - WT*LT - IT;
    
% Total government receipts
TAX = TAUL*W*L + TAUC*C + (1-varthetakappa)*STEADY_STATE(tauk)*( RKN*KN(-1)+RKT*KT(-1) );
    
% Non-resource GDP
YNON = Y;     
    
% Government purchases to GDP ratio
GSHARE = PG* G / Y;  
    
% Government consumption to GDP ratio
GCSHARE =  PG*GC / Y;  
    
% Government investment to GDP ratio
GISHARE =  PG*GI / Y;  
    
% Transfers to GDP ratio
ZSHARE = Z / Y;  
    
% Trade surplus
TSUR = Y - C - INV - PG*G;
    
% Trade surplus share to GDP
TSURSHARE = TSUR/Y;
    
% Private non-resource capital
K = KN + KT;
    
% GDPNO/GDP ratio
YNONSHARE = YNON/Y; 
    
% Tax/GDP
TAXSHARE = TAX/Y;
    
% Non-resource tax receipts
TAXNON = TAX;
    
% Current account deficits/GDP
CADSHARE = CAD/Y;
    
% Sovereign wealth fund/GDP 
FSTARSHARE = FSTAR*S/Y;

    
% Net return on public capital
RKG = alphag*YNON/KG(-1) - DELTAGT;

Saving = (B - B(-1)) - S*(BSTAR - BSTAR(-1)) + S*(RSTAR(-1)-1)*BSTAR(-1) + (eta/2)*omega*(BOPT-STEADY_STATE(BOPT))^2;

%GSaving = TAUC*C + TAUL*W*L + mu*KG(-1) + (1-varthetakappa)*STEADY_STATE(tauk)*(RKN*KN(-1)+RKT*KT(-1)) + (ASTAR-FSTAR+GR+(1+rstar_net)/(1+ggamma)*FSTAR(-1)) 
% - PG*GC - Z;
 
%GSaving =  PG*(GI+GIG) + rd*S*D(-1)/(1+ggamma) - S*D + (RDC(-1)-1-ggamma)/(1+ggamma)*S*DC(-1) + (R(-1)-1-ggamma)/(1+ggamma)*B(-1) - (B-B(-1))
% - S*( DC-DC(-1) );

GSaving =  PG*(GI) + S*(D(-1)/(1+ggamma) - D) - (B-B(-1))  - S*( DC-DC(-1) );
OB = GSaving - PG*(GI);


S_CHANGE = 100*(Saving/STEADY_STATE(Saving)-1);

NIIP = S/S(-1)*NIIP(-1) - CAD;

YDOM = YT + YN;

%% CONSTRUCT VARIABLES TO PLOT
[name='check']
GISHARE_CHANGE      = 100*(GISHARE-STEADY_STATE(GISHARE));
ASTARSHARE_CHANGE   = 100*(ASTAR/Y-STEADY_STATE(ASTAR)/STEADY_STATE(Y));
GRSHARE_CHANGE      = 100*(GR/Y - STEADY_STATE(GR)/STEADY_STATE(Y));
PN_DEV              = 100*(PN/STEADY_STATE(PN)-1);
TAUC_DEV            = 100*(TAUC-STEADY_STATE(TAUC));
TAUL_DEV            = 100*(TAUL-STEADY_STATE(TAUL));
ZSHARE_CHANGE       = 100*(ZSHARE - STEADY_STATE(ZSHARE)); 
CROT_DEV            = 100*(CROT/Y - STEADY_STATE(CROT)/STEADY_STATE(Y)); %%%
COPT_DEV            = 100*(COPT/Y - STEADY_STATE(COPT)/STEADY_STATE(Y)); %%%
GCSHARE_CHANGE      = 100*(GCSHARE - STEADY_STATE(GCSHARE));
R_NET               = 100*(R-STEADY_STATE(R));
INV_DEV             = 100*(INV/Y - STEADY_STATE(INV)/STEADY_STATE(Y));
C_DEV               = 100*(C/Y - STEADY_STATE(C)/STEADY_STATE(Y));
W_DEV               = 100*(W/STEADY_STATE(W)-1);
L_DEV               = 100*(L/STEADY_STATE(L)-1);
KG_DEV              = 100*(KG/STEADY_STATE(KG)-1); 
TAXSHARE_CHANGE     = 100*(TAX/Y-STEADY_STATE(TAX)/STEADY_STATE(Y)); %%%
K_DEV               = 100*(K/STEADY_STATE(K)-1);
Y_GROWTH            = 100*(Y/Y(-1)-1)+100*ggamma_add;
YT_DEV              = 100*(YT/STEADY_STATE(YT)-1);
YN_DEV              = 100*(YN/STEADY_STATE(YN)-1);
D_DEV               = 100*(D-STEADY_STATE(D))/STEADY_STATE(D);  %%
DSHARE_DEV          = 100*(S*D/Y - STEADY_STATE(D)/STEADY_STATE(Y));  
DCSHARE_DEV         = 100*(S*DC/Y- STEADY_STATE(DC)/STEADY_STATE(Y)); 
DC_DEV              = 100*(DC-STEADY_STATE(DC))/STEADY_STATE(DC); %%
BSHARE_DEV          = 100*(B/Y - STEADY_STATE(B)/STEADY_STATE(Y));  
B_DEV               = 100*(B-STEADY_STATE(B))/STEADY_STATE(B); %% 
TOTPUBDEBT_PER      = DSHARE_DEV+BSHARE_DEV+DCSHARE_DEV;
S_DEV               = 100*(S/STEADY_STATE(S)-1);
FSTAR_PER           = 100*(FSTARSHARE);  
CADSHARE_PER        = 100*(CADSHARE-STEADY_STATE(CADSHARE)); 
DELTAGT_PER         = 100*(DELTAGT*KG(-1)/Y); 
TAXNON_DEV          = 100*(TAXNON-STEADY_STATE(TAXNON)); %%%
EPSILON_PER         = 100*(EPSILON);
Y_DEV               = 100*((YN+YT)/(STEADY_STATE(YN)+STEADY_STATE(YT))-1); %%%
YNON_DEV            = 100*((YN+YT)/(STEADY_STATE(YN)+STEADY_STATE(YT))-1);
GI_DEV              = 100*(GI/STEADY_STATE(GI)-1);
Z_SHAREY            = 100*(Z/Y);
GC_SHAREY           = 100*(GC/Y);
Z_DEV               = 100*(Z/STEADY_STATE(Z)-1); 
GC_DEV              = 100*(GC/STEADY_STATE(GC)-1); 
YNON_GROWTH         = 100*(YNON/YNON(-1)-1)+100*ggamma_add;
PIE_RATE            = 100*(PIE/STEADY_STATE(PIE)-1)+100*STEADY_STATE(PIE);
XX_CHANGE           = 100*(XX/Y - STEADY_STATE(XX)/STEADY_STATE(Y));
Y_YOY               = 100*(Y/Y(-1) - 1);
SRP_CHANGE          = 100*(upsilondc - STEADY_STATE(upsilondc));
REMIT_CHANGE        = 100*(S*rem/Y - STEADY_STATE(S)*STEADY_STATE(rem)/STEADY_STATE(Y));