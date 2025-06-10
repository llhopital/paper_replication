%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. Recover implicit parameters from the steady-state routine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rd              = STEADY_STATE(rd); 
rf              = STEADY_STATE(rf);
u               = STEADY_STATE(u);
upsilondc       = STEADY_STATE(upsilondc);
mu              = STEADY_STATE(mu);
varrho          = STEADY_STATE(varrho);
varphi          = STEADY_STATE(varphi);
nu              = STEADY_STATE(nu);
betaa           = STEADY_STATE(betaa);
delta           = STEADY_STATE(delta);
taukoff         = STEADY_STATE(taukoff);
kappaopt        = STEADY_STATE(kappaopt); 
kapparot        = STEADY_STATE(kapparot);
temp1           = STEADY_STATE(temp1);

varthetakappa   = STEADY_STATE(varthetakappa);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. Model equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2.1 Households %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[name=' Relative price - final consumption basket']
1 = ( varphi * PN^(1-chi) + (1-varphi) * PT^(1-chi) )^(1/(1-chi) );

[name='Relative price - traded goods consumption basket']
PT = ( varphiT * (PTH)^(1-chiT) + (1-varphiT) * S^(1-chiT) )^( 1/(1-chiT) ); 

[name='NT: Relative labour supply']
LNN = delta * (WN/W)^(rho) * L;

[name='T: Relative labour supply']
LT = (1-delta) * (WT/W)^(rho) * L;

[name='Aggregate labour supply']
L = (( delta^(-1/rho) * LNN^((rho+1)/rho) + (1-delta)^(-1/rho) 
* LT^((rho+1)/rho))^(rho/(rho+1)));

[name='OPT: Marginal utility of consumption']
LAMBDA * (1+TAUC) = (COPT)^(-ssigma);

[name='OPT: Marginal disutility of labour']
exp(rhoMM*ex_sick)*kappaopt * LOPT^(psiopt) = (1-TAUL) * W * LAMBDA;

[name='OPT: Euler equation'] 
LAMBDA = betaa*LAMBDA(+1)*R/(1+ggamma);

[name='OPT: Interest rate parity'] 
R/RSTAR =  S(+1)/(S-eta*(BOPT-STEADY_STATE(BOPT)));

[name='OPT: Risk premium on private external debt'] 
RSTAR = RDC + u;

[name='ROT: Household budget constraint'] 
(1+TAUC)*CROT = (1-TAUL)*W*LROT + S*rem +Z -mu*(KG(-1));

[name='ROT: Marginal disutility of labour'] 
exp(ex_sick)*kapparot * LROT^(psirot) = (1-TAUL) * W * LAMBDAROT;

[name='ROT: Marginal sutility of consumption'] 
LAMBDAROT * (1+TAUC) = (CROT)^(-ssigma);

% 2.2 Firms %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2.2.1 Non-traded sector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[name='NT: Production function']    
YN = exp(EPSILONG*ex_yy)*zn * KN(-1)^(1-alphan) * LNN^alphan * KG(-1)^alphag;

[name='NT: TFP']   
zn = STEADY_STATE(zn);

[name='NT: Capital LoM']  
(1+ggamma) * KN = (1-deltan) * KN(-1) + (1-(1+ggamma)^2 * kappan/2 
* (IN/IN(-1)-1)^2) * IN; 

[name='NT: Labour demand']  
LNN = (MCN * PN * alphan  * zn * KN(-1)^(1-alphan) 
* KG(-1)^alphag/ WN)^(1/(1-alphan));

[name='NT: Tobins Q'] 
(1+ggamma) * QN = betaa * LAMBDA(+1) / LAMBDA * ( (1-deltan) * QN(+1) 
+ ( (1-tauk) * MCN(+1) * (1-alphan) * PN(+1) *YN(+1) / KN ) );

[name='NT: Investment'] 
1/QN = 1 - kappan/2 * (1+ggamma)^2 * (IN/IN(-1)-1)^2 - kappan 
* (1+ggamma)^2 * IN/IN(-1) * (IN/IN(-1)-1) + betaa * kappan * (1+ggamma)^2 
* QN(+1)/QN * LAMBDA(+1)/LAMBDA * (IN(+1)/IN)^2 * (IN(+1)/IN-1); 

[name='NT: Phillips curve'] 
1 - xin * (PIEN - STEADY_STATE(PIEN))*PIEN + (1+ggamma) * xin * betaa 
* LAMBDA(+1) / LAMBDA * (PIEN(+1) - STEADY_STATE(PIEN))*PIEN(+1) 
* PN(+1)/PN * YN(+1)/YN = (1-MCN) * zzeta;

[name='NT: Return on capital']
RKN = MCN*(1-alphan)*PN*YN/KN(-1);

[name='NT: Firm profits']
OMEGAN = PN*YN - WN*LNN - IN;

[name='Capital market distortion']
tauk/STEADY_STATE(tauk) = exp(-0.5*(KG(-1)-STEADY_STATE(KG)));

% 2.2.2 Traded sector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
[name='T: Production function']   
YT = exp(EPSILONG*ex_yy)*ZT * KT(-1)^(1-alphat) * KG(-1)^alphag * LT^alphat;

[name='T: TFP']   
ZT = STEADY_STATE(ZT);

[name='T: Capital LoM']  
(1+ggamma)*KT = (1-deltat) * KT(-1) + ( 1 - (1+ggamma)^2 *kappat/2 
* ( IT/IT(-1) - 1 )^2 ) * IT;
    
[name='T: Labour demand']  
LT = (MCT * PTH * alphat * ZT * KT(-1)^(1-alphat) 
* KG(-1)^alphag/ WT)^(1/(1-alphat));
    
[name='T: Tobins Q'] 
(1+ggamma) * QT = betaa * ( LAMBDA(+1)/LAMBDA * ( (1-deltat) * QT(+1) 
+ MCT(+1) * (1-alphat) * (1-tauk) *PTH(+1) * YT(+1) / KT ) );
    
[name='T: Investment'] 
1/QT = 1 - kappat/2 * (1+ggamma)^2 * ( IT/IT(-1) - 1 )^2 - kappat 
* (1+ggamma)^2 * IT/IT(-1) * ( IT/IT(-1) - 1 ) + betaa *kappat * (1+ggamma)^2 
* QT(+1)/QT * LAMBDA(+1)/LAMBDA * (IT(+1)/IT)^2 * (IT(+1)/IT-1);

[name='T: Phillips curve'] 
1 - xit * (PIETH - STEADY_STATE(PIETH))*PIETH + (1+ggamma) * xit * betaa 
* LAMBDA(+1) / LAMBDA * (PIETH(+1) - STEADY_STATE(PIETH))*PIETH(+1)
 * PTH(+1)/PTH * YT(+1)/YT = (1-MCT) *zzeta;

[name='T: Return on capital']
RKT = MCT*(1-alphat)*PTH*YT/KT(-1);

[name='T: Firm profits']
OMEGAT = PTH*YT - WT*LT - IT;

% 2.3 Government %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2.3.1 Above the line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[name='Fiscal gap 1'] 
GAP = PG*(GI) + rd*S*D(-1)/(1+ggamma) - S*D + (RDC(-1)-1-ggamma)/(1+ggamma)
*S*DC(-1) + (R(-1)-1-ggamma)/(1+ggamma)*B(-1)+PG*STEADY_STATE(GC)
+ STEADY_STATE(Z) - STEADY_STATE(TAUC)*C - STEADY_STATE(TAUL)*W*L 
- mu*(KG(-1)) - (1-varthetakappa)*STEADY_STATE(tauk)*(RKN*KN(-1)+RKT*KT(-1))
- S*(ASTAR-FSTAR+GR+(1+rstar_net)/(1+ggamma)*FSTAR(-1) );

[name='Fiscal gap 2']   
GAP =  B-B(-1) + S*( DC-DC(-1) ) + ( TAUC-STEADY_STATE(TAUC) )*C 
+ ( TAUL-STEADY_STATE(TAUL) )*W*L - PG*( GC - STEADY_STATE(GC) )
- ( Z - STEADY_STATE(Z) ) ;

[name='Fiscal revenues'] 
TOTREV = STEADY_STATE(TAUC)*C + STEADY_STATE(TAUL)*W*L 
+ (1-varthetakappa)*STEADY_STATE(tauk)*(RKN*KN(-1)+RKT*KT(-1))
+ mu*(KG(-1)) + S*(ASTAR+GR+(rstar_net-ggamma)/(1+ggamma)*FSTAR(-1)+D);

[name='Fiscal expenditures'] 
TOTEXP = PG*(GI) + PG*STEADY_STATE(GC) + STEADY_STATE(Z) + S*rd*D(-1)
/(1+ggamma) + (RDC(-1)-1-ggamma)/(1+ggamma)*S*DC(-1) + (R(-1)-1-ggamma)
/(1+ggamma)*B(-1); 

[name='Total government tax receipts'] 
TAX = TAUL*W*L + TAUC*C + (1-varthetakappa)*STEADY_STATE(tauk)
*( RKN*KN(-1)+RKT*KT(-1) );

[name='Consumption tax rate'] 
TAUC =   TAUCRULE;

[name='Labour tax rate'] 
TAUL =   TAULRULE;

[name='Transfers']
Z  = ZRULE ;

[name='Fiscal buffers']
FSTAR = STEADY_STATE(FSTAR);

[name='Overall balance']
OB = GSaving - PG*(GI);

% 2.3.2 Below the line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[name='Financing the fiscal gap'] 
varkappa*(B-B(-1)) = (1-varkappa)*S*(DC-DC(-1));

[name='Debt-elastic sovereign risk premium'] 
RDC = rf + upsilondc * exp((etadc)*(S*(D+DC)/Y - (STEADY_STATE(D)
+STEADY_STATE(DC))/STEADY_STATE(Y)));

[name='Concessional debt']
D = STEADY_STATE(D);

% 2.3.3 Government capital %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[name='Public capital LoM'] 
(1+ggamma)*KG = (1-DELTAGT)*KG(-1) + GITILDE;

[name='Effective public investment'] 
GITILDE = EPSILON*GI; 

[name='Time-varying public investment efficiency'] 
EPSILON = STEADY_STATE(EPSILON);

[name='Time-varying depreciation rate of public capital'] 
DELTAGT = STEADY_STATE(DELTAGT);

[name='Net return on public capital']
RKG = alphag*Y/KG(-1) - DELTAGT;

% 2.3.4 Public procurment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
[name='Relative price index of government purchases'] 
PG = ( NUT * PN^(1-chi) + (1-NUT) * PTG^(1-chi) )^( 1/(1-chi) );

[name='Relative price index of government purchases of traded goods'] 
PTG = ( nutt * PTH^(1-chiT) + (1-nutt) * S^(1-chiT) )^( 1/(1-chiT) ); %#2

[name='Home bias on additional government purchases']
NUT = (STEADY_STATE(PG)*STEADY_STATE(G)*nu + (PG*G-STEADY_STATE(PG)
*STEADY_STATE(G))*nug)/(PG*G);

[name='Public consumption']
GC = STEADY_STATE(GC) + STEADY_STATE(Y)*(1-0.67)*eps_inv;

[name='Public investment']
GI = STEADY_STATE(GI) + STEADY_STATE(Y)*0.67*(eps_inv+eps_yo)
/STEADY_STATE(PG);

[name='Total government purchases']
G = GI + GC;

% 2.3.5 Fiscal rules %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[name='Fiscal target: Consumption tax rate'] 
TAUCTAR = STEADY_STATE(TAUC) + lambda1 * GAP/C;

[name='Fiscal target: Labour tax rate'] 
TAULTAR = STEADY_STATE(TAUL) + lambda2 * GAP/(W*L);

[name='Fiscal target: Public consumption'] 
GCTAR   = STEADY_STATE(GC)   - lambda3 * GAP/PG;

[name='Fiscal target: Public transfers'] 
ZTAR    = STEADY_STATE(Z)    - lambda4 * GAP;

[name='Fiscal rule: Consumption tax rate'] 
TAUCRULE = TAUC(-1) + zzeta1 * (TAUCTAR - TAUC(-1)) + zzeta2 * (BSHARE(-1)
 - STEADY_STATE(BSHARE)); 

[name='Fiscal rule: Labour tax rate'] 
TAULRULE = TAUL(-1) + zzeta3 * (TAULTAR - TAUL(-1)) + zzeta4 * (BSHARE(-1)
 - STEADY_STATE(BSHARE));

[name='Fiscal rule: Public consumption'] 
GCRULE/STEADY_STATE(GC)   = GC(-1)/STEADY_STATE(GC)   + zzeta5 * (GCTAR 
- GC(-1))/STEADY_STATE(GC)   - zzeta6 * (BSHARE(-1) - STEADY_STATE(BSHARE));

[name='Fiscal rule: transfers'] 
ZRULE/STEADY_STATE(Z)    = Z(-1)/STEADY_STATE(Z)    + zzeta7 * (ZTAR    
- Z(-1))/STEADY_STATE(Z)    - zzeta8 * (BSHARE(-1) - STEADY_STATE(BSHARE));

% 2.3.6 Monetary policy %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[name='NT inflation'] 
PIEN = PIE * PN/PN(-1);

[name='T inflation'] 
PIET = PIE * PT/PT(-1);

[name='Domestic T inflation'] 
PIETH = PIE * PTH/PTH(-1); 

[name='Nominal interest rate'] 
R = RN / PIE(+1);

[name='Taylor rule'] 
log(RN/STEADY_STATE(RN)) = varrhor*log(RN(-1)/STEADY_STATE(RN)) 
+ (1-varrhor)*(varrhopie*log(PIE/STEADY_STATE(PIE))
+varrhoy*log(Y/STEADY_STATE(Y)));  

% 2.4 External sector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[name='Exports'] 
XX/STEADY_STATE(XX) = (S/PTH)^chiX; 

[name='Imports'] 
S*(MM_TOTAL) = PTH*XX + C + INV + PG * G + xit/2 * (PIET 
- STEADY_STATE(PIET))^2 + xin/2 * (PIEN - STEADY_STATE(PIEN))^2 
+ eta/2*(BOPT-STEADY_STATE(BOPT))^2 - PN * YN  -PTH * YT;

[name='Current account deficit'] 
CAD = S*(MM_TOTAL - rem - ASTAR - GR) - PTH*XX + S*( -(rstar_net-ggamma)
/(1+ggamma)*FSTAR(-1) + (rd-1-ggamma)/(1+ggamma)*D(-1) + (RDC(-1)-1
-ggamma)/(1+ggamma)*DC(-1) + (RSTAR(-1)-1-ggamma)/(1+ggamma)*BSTAR(-1));

[name='Balance of Payments'] 
CAD = S*(FSTAR(-1)/(1+ggamma) - FSTAR + D - D(-1)/(1+ggamma) + DC 
- DC(-1)/(1+ggamma)+ BSTAR - BSTAR(-1)/(1+ggamma)) + Gov_sub;

[name='Grants'] 
GR-STEADY_STATE(GR) = (STEADY_STATE(Y)*0.67*eps_inv/STEADY_STATE(PG) 
+ STEADY_STATE(Y)*(1-0.67)*eps_inv)/S ; 

[name='Foreign aid']
ASTAR = STEADY_STATE(ASTAR);

[name='Net International Investment Position']
NIIP = S/S(-1)*NIIP(-1) - CAD;

[name='RRF loans']
Gov_sub = STEADY_STATE(Y)*ex_xx;

[name='Remittances']
rem = STEADY_STATE(rem); 

% 2.5 Aggregation and market clearing conditions %%%%%%%%%%%%%%%%%%%%%%%%%

[name='Aggregate consumption'] 
C = omega*COPT + (1-omega)*CROT;

[name='Aggregate labour'] 
L = omega*LOPT + (1-omega) * LROT;

[name='Aggregate foreign bonds'] 
BSTAR = omega * BOPT;

[name='Aggregate output'] 
Y = PN*(YN) + PTH*(YT); 

[name='Aggregate investment'] 
INV = IN + IT;

[name='Aggregate private capital']
K = KN + KT;

[name='NT demand'] 
DN = varphi*(C + IN + IT+ eta/2*(BOPT-STEADY_STATE(BOPT))^2 + xit/2 
* (PIETH - STEADY_STATE(PIETH))^2 + xin/2 * (PIEN - STEADY_STATE(PIEN))^2) 
+ NUT*PG^chi*G; 
    
[name='NT clearing condition'] 
YN = PN^(-chi) * DN;

[name='T clearing condition'] 
YT = varphiT *(PTH/PT)^(-chiT) * (1-varphi) * PT^(-chi) *(C + IN + IT)
+ nutt*(PTH/PTG)^(-chiT) *(1-NUT)*(PTG/PG)^(-chi)*G + (1+temp1)*XX; 

[name='Public savings']
GSaving =  PG*(GI) + S*(D(-1)/(1+ggamma) - D) - (B-B(-1)) - S*( DC-DC(-1));

[name='Private savings']
Saving = (B - B(-1)) - S*(BSTAR - BSTAR(-1)) + S*(RSTAR(-1)-1)*BSTAR(-1) 
+ (eta/2)*omega*(BOPT-STEADY_STATE(BOPT))^2;


%S_CHANGE = 100*(Saving/STEADY_STATE(Saving)-1);
% Trade surplus
%TSUR = Y - C - INV - PG*G;  
% Trade surplus share to GDP
%TSURSHARE = TSUR/Y;
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. Macro ratios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[name='Debt to GDP ratio']
BSHARE = (B+S*DC)/Y; 
    
[name='Government purchases to GDP ratio']
GSHARE = PG* G / Y;  
    
[name='Government consumption to GDP ratio']
GCSHARE =  PG*GC / Y;  
    
[name='Government investment to GDP ratio']
GISHARE =  PG*GI / Y;  
    
[name='Transfers to GDP ratio']
ZSHARE = Z / Y;  
    
[name='Tax/GDP']
TAXSHARE = TAX/Y;
    
[name='Current account deficits/GDP']
CADSHARE = CAD/Y;
    
[name='Fiscal buffers/GDP'] 
FSTARSHARE = FSTAR*S/Y;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. Variables for plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
EPSILON_PER         = 100*(EPSILON);
Y_DEV               = 100*((YN+YT)/(STEADY_STATE(YN)+STEADY_STATE(YT))-1);
GI_DEV              = 100*(GI/STEADY_STATE(GI)-1);
Z_SHAREY            = 100*(Z/Y);
GC_SHAREY           = 100*(GC/Y);
Z_DEV               = 100*(Z/STEADY_STATE(Z)-1); 
GC_DEV              = 100*(GC/STEADY_STATE(GC)-1); 
PIE_RATE            = 100*(PIE/STEADY_STATE(PIE)-1)+100*STEADY_STATE(PIE);
XX_CHANGE           = 100*(XX/Y - STEADY_STATE(XX)/STEADY_STATE(Y));
Y_YOY               = 100*(Y/Y(-1) - 1);
SRP_CHANGE          = 100*(upsilondc - STEADY_STATE(upsilondc));
REMIT_CHANGE        = 100*(S*rem/Y - STEADY_STATE(S)*STEADY_STATE(rem)/STEADY_STATE(Y));
YDOM                =  YT + YN;    