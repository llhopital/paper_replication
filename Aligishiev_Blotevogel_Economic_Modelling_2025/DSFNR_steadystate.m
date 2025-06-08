function[ys,check]=DSFNR_steadystate(ys,exe)

%% THIS BLOCK IS MODEL SPECIFIC
%% Set initial values

CROT_oo   =   0.50;
YT_oo     =   0.50;
LNN_oo    =   0.50;
LT_oo     =   0.50;
WN_oo     =   0.50;
WT_oo     =   0.50;
W_oo      =   0.50;


x0=[CROT_oo, YT_oo, LNN_oo, LT_oo, WN_oo, WT_oo, W_oo];
%%

%% DO NOT CHANGE THIS PART
%% Fsolve uses fun_DSFNR to find steady state 

[x,fval]  =   fsolve(@fun_DSFNR,x0,optimset('Display','off','MaxIter',1000,'TolFun',1e-10,'MaxFunEvals',1000));
x0        =   real(x);
[x,fval]  =   fsolve(@fun_DSFNR,x0,optimset('Display','off','MaxIter',1000,'TolFun',1e-10,'MaxFunEvals',1000));

%%

%% THIS BLOCK IS MODEL SPECIFIC
%% Evaluate steady state and stack values in Dynare vector 'ys'

CROT      =   x(1);
YT        =   x(2);
LNN       =   x(3);
LT        =   x(4);
WN        =   x(5);
WT        =   x(6);
W         =   x(7);


%% Do not change the following lines  

check = 0;
[y, ys] = feval('fun_DSFNR', x);

global M_

NumberOfEndogenousVariables = M_.endo_nbr;
for i = 1:NumberOfEndogenousVariables                   
  varname = deblank(M_.endo_names(i,:));                                           
  eval([ varname '=' 'ys(' int2str(i) ');']);
end                                                          



%%

