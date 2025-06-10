function [y,ys]=fun_EBASELINE(x)

global M_
 
%% DO NOT CHANGE THIS PART.
%%
%% Here we load the values of the deep parameters in a loop.
%%
NumberOfParameters = M_.param_nbr;                            % Number of deep parameters.
for i = 1:NumberOfParameters                                  % Loop...
  paramname = deblank(M_.param_names(i,:));                   % Get the name of parameter i. 
  eval([ paramname ' = M_.params(' int2str(i) ');']);         % Get the value of parameter i.
end                                                           % End of the loop.  
check = 0;

%% THIS BLOCK IS MODEL SPECIFIC
%% Define unknown variables
CROT        =   x(1);
YT          =   x(2);
LNN         =   x(3);
LT          =   x(4);
WN          =   x(5);
WT          =   x(6);
W           =   x(7);

%% Compute great ratios
%% Compute great ratios
share_tb    =   share_exp - share_imp;
share_gi    =   share_g-share_gc;
share_gt    =   share_g*trad_g;                 
share_gn    =   share_g-share_gt;                 
share_c     =   100-share_i-share_tb-share_g;    
share_ct    =   share_c*trad_c;
share_cn    =   share_c-share_ct;             
share_it    =   share_ct/share_c*share_i;   
share_in    =   share_i-share_it;                 
share_yn    =   share_cn+share_in+share_gn;   
share_yt    =   100 - share_yn; 

%% Normalizations
PN          =   1;
PG          =   1;
S           =   1;                        
PO          =   1;                        
ZT          =   1;
PT          =   1;
PTH         =   1;
PTH_S       =   1;
PTG         =   1;
L           =   1;
LOPT        =   L;    
LROT        =   L;   

% Calibration
ex_yy     =   0;
ex_sick   = 0;

%% Endogenous variables
MCN         =  (zzeta-1)/zzeta;
MCT         =  (zzeta-1)/zzeta;
Y           =  (YT)/(share_yt/100);
XX         =  (share_exp-share_gdpo)/100*Y;
YN          =  (share_yn/100*Y);             
GI          =  share_gi/100*Y;  
GITILDE     =  epsilontilde*GI;   
KG          =  (1/(deltag+ggamma))*GITILDE;
G           =  share_g/100*Y;                
GC          =  G-GI;                      
GSHARRE     =  G/Y;
GCSHARE     =  GC/Y;
GISHARE     =  GI/Y;
D           =  dovery*Y/S;
DC          =  dcovery*Y/S;
BSTAR       =  bstarovery*Y/S;
BOPT        =  BSTAR/omega;

%%
vartheta = 0;

%% Implicit parameters
betaa         = (1+ggamma)^(1-ssigma)/(1+r_net);
varrho        = betaa^(-1)/(1+ggamma)^(ssigma-1)-1;
nu            =   share_gn/share_g;
delta         =   alphan*YN/(alphan*YN+alphat*YT);  
temp          =   share_i/100*(((ggamma+deltat)*(1-alphat)*share_yt/100)/((1+ggamma)/betaa-1+deltat)+((ggamma+deltan)*(1-alphan)*share_yn/100)/((1+ggamma)/betaa-1+deltan))^(-1);
tauk          =   1-temp;
mu            =   f*PG*deltag;

%%

%% More endogenous variables  
KN          =  MCN*betaa*(1-alphan)*(1-tauk)*YN/((1+ggamma)-betaa*(1-deltan));
KT          =  MCT*betaa*(1-alphat)*(1-tauk)*YT/((1+ggamma)-betaa*(1-deltat)); 
TAXSHARE    =  ty; %
TAX         =  TAXSHARE*Y;
taxK        =  TAX - taxC*TAX - taxL*TAX; 
FSTAR       =  share_fstar/100*Y/S;      
C           =  share_c/100*Y;
ASTAR       =  share_astar/100*Y/S;          
B           =  share_b/100*Y;
GR          =  grovery*Y/S;
share_crot  =  CROT/Y*100;
share_copt  =  (100*C/Y-(1-omega)*share_crot)/omega;
COPT        =  share_copt/100*Y;    
TAUC        =  taxC*TAX/((1-vartheta)*C);
TAUL        =  taxL*TAX/((1-vartheta)*L*W);
LAMBDA      =  1/(1+TAUC)*COPT^(-ssigma);       
LAMBDAROT   =  1/(1+TAUC)*CROT^(-ssigma); 
IN          =  KN*(ggamma+deltan);  
IT          =  KT*(ggamma+deltat);  
INV         =  IN + IT;     
OMEGAN      =  PN*YN - WN*LNN -IN; 
OMEGAT      =  YT- WT*LT - IT;  
CAD         =  S*(ggamma/(1+ggamma)*(D+DC+BSTAR-FSTAR));
varphi      =  (YN - nu * G) /(C+IN+IT); 
DN          =  varphi*(C + IN + IT) + nu*G;      
zn        =  YN/(KN^(1-alphan)*KG^alphag*LNN^alphan);
RKN         =  MCN*(1-alphan)*YN/KN;
RKT         =  MCT*(1-alphat)*YT/KT;
varthetakappa = 1 - taxK/(tauk*(RKN*KN+RKT*KT));  
taukoff     = (1-varthetakappa)*tauk;     
R           =  (1+ggamma)^(1-ssigma)/betaa;                 
K           =  KN+KT;       
RKG         =  alphag*Y/KG-deltag;
QN          =  1;  
QT          =  1;  
FSTARSHARE  =  FSTAR*S/Y;
CADSHARE    =  CAD/Y;
GSHARE      =  PG*G/Y;
EPSILON     =  epsilontilde;
DELTAGT     =  deltag;
NUT         =  nu;
RSTAR       =  R;
RDC         =  1+rdc_net;
BSHARE      =  (B+DC)/Y;
rd          =  1+rd_net;
Z           =  TAX + mu*(KG)+ (rstar_net-ggamma)/(1+ggamma)*FSTAR - PG*G - (R-1-ggamma)/(1+ggamma)*B - (rd-1-ggamma)/(1+ggamma)*D - (RDC-1-ggamma)/(1+ggamma)*DC  + S*ASTAR + S*GR;  
ZSHARE      =  Z/Y;
temp1          = (YT -(varphiT*(1-varphi)*(C + IN + IT) + nutt*(1-nu)*G))/XX-1;
MM_TOTAL       = (C + INV + PG * G - PN * YN - PTH*YT + PTH*XX)/S;
rem         = -CAD + MM_TOTAL - ASTAR - GR  - PTH*XX + S * ( -(rstar_net-ggamma)/(1+ggamma)*FSTAR + (rd-1-ggamma)/(1+ggamma)*D + (RDC-1-ggamma)/(1+ggamma)*DC + (RSTAR-1-ggamma)/(1+ggamma)*BSTAR); 
GAP         =  0;
TAUCTAR     =  TAUC; 
TAULTAR     =  TAUL;
GCTAR       =  GC;
ZTAR        =  Z;
TAUCRULE    =  TAUC; 
TAULRULE    =  TAUL;
GCRULE      =  GC;
ZRULE       =  Z;
PIE         = piess;
PIEN        = PIE;
PIET        = PIE;
PIETH       = PIE;
RN          = PIE*R;
TOTREV = (1-vartheta)*TAUC*C + (1-vartheta)*TAUL*W*L + (1-varthetakappa)*tauk*(RKN*KN+RKT*KT) + mu*(KG) + S*(ASTAR+GR+(rstar_net-ggamma)/(1+ggamma)*FSTAR+D);
TOTEXP = PG*(GI) + PG*GC + Z + S*rd*D/(1+ggamma) + (RDC-1-ggamma)/(1+ggamma)*S*DC + (R-1-ggamma)/(1+ggamma)*B;
Saving =  (RSTAR-1)*BSTAR;
S_CHANGE = 0;
NIIP = -1.41*Y;
GSaving = PG*(GI);
OB = 0;
%% More implicit parameters
kappaopt    =  W*(1-TAUL)*LAMBDA/(LOPT^psiopt); 
kapparot    =  W*(1-TAUL)*LAMBDAROT/(LROT^psirot);
rf          =  1+rf_net;
u           =  RSTAR-RDC;
upsilondc   =  RDC-rf;
Gov_sub = 0;

%% Variables to plot
GISHARE_CHANGE = 0;
ASTARSHARE_CHANGE = 0;
GRSHARE_CHANGE = 0;
PN_DEV = 0;
TAUC_DEV = 0;
TAUL_DEV = 0;
ZSHARE_CHANGE = 0;
GCSHARE_CHANGE = 0;
R_NET = 0;
INV_DEV = 0;
C_DEV = 0;
W_DEV = 0;
L_DEV = 0;
KG_DEV = 0;
K_DEV = 0;
Y_GROWTH = 100*ggamma_add;
YT_DEV = 0;
YN_DEV = 0;
DSHARE_DEV = 0;
DCSHARE_DEV = 0;
BSHARE_DEV = 0;
TOTPUBDEBT_PER = 0;
S_DEV = 0;
FSTAR_PER = 100*FSTARSHARE;
DELTAGT_PER = 100*(DELTAGT*KG/Y);
EPSILON_PER = 100*(EPSILON);
CADSHARE_PER = 0;
GI_DEV = 0;
Z_SHAREY  = 100*(Z/Y);
GC_SHAREY = 100*(GC/Y);
Z_DEV = 0;
GC_DEV = 0;
GI_GROWTH = ggamma;
PIE_RATE = 100*PIE;
XX_CHANGE = 0;
CROT_DEV = 0;
COPT_DEV = 0;
TAXSHARE_CHANGE = 0;
D_DEV = 0;
DC_DEV = 0;
B_DEV = 0;
Y_DEV = 0;
SRP_CHANGE =0;
REMIT_CHANGE=0;
Y_YOY=0;
YDOM = YT+YN;

%% DO NOT CHANGE THIS PART
%%
%% Here we save steady state values in a vector.
NumberOfEndogenousVariables = M_.endo_nbr;                    % Number of endogenous variables.
ys = zeros(NumberOfEndogenousVariables,1);                    % Initialization of ys (steady state).
for i = 1:NumberOfEndogenousVariables                         % Loop...
  varname = deblank(M_.endo_names(i,:));                      % Get the name of endogenous variable i.                     
  eval(['ys(' int2str(i) ') = ' varname ';']);                % Get the steady state vZNue of this variable.
end 

%% THIS BLOCK IS MODEL SPECIFIC
%% Equations for which fsolve will find the solution
y(1)    = -YT+ZT*KT^(1-alphat)*KG^alphag*LT^alphat;
y(2)    = -(1+TAUC)*CROT+(1-TAUL)*W*LROT+S*rem +Z-mu*(KG);
y(3)    = -LNN+delta*(WN/W)^rho*L;
y(4)    = -LT+(1-delta)*(WT/W)^rho*L;
y(5)    = -WT+MCT*ZT*KT^(1-alphat)*KG^alphag*alphat*LT^(alphat-1);
y(6)    = -WN+MCN*alphan*YN/LNN;
y(7)    = -W+(delta*WN^(1+rho)+(1-delta)*WT^(1+rho))^(1/(1+rho));
%%



