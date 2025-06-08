%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% DIGNAR-19 model
% Development Macroeconomics Division
% International Monetary Fund
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% Import exogenous variables from Excel spreadsheet (Do not touch the following lines)
exogenous_variables = xlsread('inputs.xlsx',2,'B9:AR1008');
time_line = exogenous_variables(2:1000,1);

plot_periods  = enddate-startdate+1;

dummy_periods = zeros(1,999);
dummy_periods(1,1:plot_periods-1)=1;
dummy_periods = dummy_periods';

labour_supply_shock         =exogenous_variables(2:end,40+iii);
labour_supply_shock (isnan(labour_supply_shock ))=0;
labour_supply_shock = labour_supply_shock.*dummy_periods./100;
rsrc_prce_dev               =zeros(1,999);
ntrl_rsrc_dev               =zeros(1,999);
invt_xpdt_dev               =zeros(1,999);
conc_debt_dev               =zeros(1,999);
frgn_grts_dev               =zeros(1,999);
ex_transfers_dev            =zeros(1,999);
ex_exports_dev              =zeros(1,999);
ex_remit_dev                =zeros(1,999);
ex_rprem_dev                =zeros(1,999);
invt_xpdt                   =zeros(1,999);
efficiency_parameter_dev    =zeros(1,999);
consumption_tax_imposed     =zeros(1,999);
labour_tax_imposed          =zeros(1,999);
gov_trans_dev               =zeros(1,999);
gov_cons_dev                =zeros(1,999);
tfp_shock                   =zeros(1,999);
tfp_shock2                  =zeros(1,999);


%--------------------------------------------------------------------------
% VARIABLE DECLARATION 
%--------------------------------------------------------------------------
% Endogenous variables
var 

@#include "end_vars.mod"

ex_sick

;

% Exogenous variables
varexo ex_lab_fall eps_inv ex_xx ex_yy eps_yo %timeline dummy_F eps_yo eps_po eps_inv eps_conc eps_grts dummy_T ex_z ex_lab_fall ex_xx ex_rem ex_risk_inter ex_gc ex_taul ex_tauc ex_yy vartheta
;


%--------------------------------------------------------------------------
% PARAMETER DECLARATION 
%--------------------------------------------------------------------------
% Parameter names
parameters 

@#include "params.mod"

;

% Parameter values
@#include "param_val.mod"


% Switches for DIGNAR features 
dummy_swf =1;       % 0 - swf on | 1 - swf off
dummy_dgt =0;       % 0 - constant depreciation | 1 - time-varying
dummy_abcap = 0;    % 0 - constant investment efficiency + exogenous series | 1 - original absorptive capacity constraints setup
dummy_exgc = 1;     % 0 - GC according to the rule | 1 - Exogenous GC throughout plot periods, then according to the rule
dummy_extrans =1;   % 0 - Z according to the rule | 1 - Exogenous Z throughout plot periods, then according to the rule
ind_extauc = 1;     % 0 - Rule s.t. a ceiling | 1 - Exogenous tax rate throughout plot periods, then according to the rule (no ceiling) | 2 - Rule without a ceiling
ind_extaul =1;      % 0 - Rule s.t. a ceiling | 1 - Exogenous tax rate throughout plot periods, then according to the rule (no ceiling) | 2 - Rule without a ceiling


%--------------------------------------------------------------------------
% MODEL
%--------------------------------------------------------------------------
% Model equations
model;

[name='Exogenous aggregate labour']
L/STEADY_STATE(L)-1 = ex_lab_fall;

@#include "model_eqs.mod"

end;


%--------------------------------------------------------------------------
% SHOCKS 
%--------------------------------------------------------------------------
shocks;

%var timeline;
%periods 1:999;
%values (time_line);

%var eps_yo;
%periods 1:999;
%values (ntrl_rsrc_dev);

%var eps_po;
%periods 1:999;
%values (rsrc_prce_dev);

var eps_inv;
periods 1:999;
values (invt_xpdt_dev);

%var eps_conc;
%periods 1:999;
%values (conc_debt_dev);

%var eps_grts;
%periods 1:999;
%values (frgn_grts_dev);

%var dummy_F;
%periods 1:999;
%values (dummy_periods);

%var dummy_T;
%periods 1:999;
%values (efficiency_parameter_dev);

%var ex_z;
%periods 1:999;
%values (ex_transfers_dev);

%var ex_sick;
%periods 1:999;
%values (labour_supply_shock);

var ex_xx;
periods 1:999;
values (ex_exports_dev);

%var ex_rem;
%periods 1:999;
%values (ex_remit_dev);

%var ex_risk_inter;
%periods 1:999;
%values (ex_rprem_dev);

%var ex_gc;
%periods 1 2 3 4 5;
%periods 1:999;
%values (gov_cons_dev);

%var ex_taul;
%periods 1:999;
%values (labour_tax_imposed);

%%var ex_tauc;
%periods 1:999;
%values (consumption_tax_imposed);

%var ex_yy;
%periods 1:1000;
%values (tfp_shock);
%periods 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16;
%values 0 0 0 0 0 0 0 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16;

%var vartheta;
%periods 1:1000;
%values (tfp_shock2);

var ex_lab_fall;
periods 1:999;
values (labour_supply_shock);


end;


%--------------------------------------------------------------------------
% STEADY STATE  
%--------------------------------------------------------------------------
% Steady state computed in external file
steady;


%--------------------------------------------------------------------------
% B&K CONDITIONS  
%--------------------------------------------------------------------------
check;


%--------------------------------------------------------------------------
% SIMULATION
%--------------------------------------------------------------------------
options_.verbosity = 0;
simul(periods=1000, maxit =20, stack_solve_algo = 6);



