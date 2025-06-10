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

calib_shock_periods = zeros(1,999);
calib_shock_periods(1,1:plot_periods*10-1)=1;
calib_shock_periods = calib_shock_periods';


// Natural resource output
if nr_y_opt==1
    ntrl_rsrc = exogenous_variables(:,2);
elseif nr_y_opt==2
    ntrl_rsrc = exogenous_variables(:,3);
elseif nr_y_opt==3
    ntrl_rsrc = exogenous_variables(:,4);
else 
    ntrl_rsrc = zeros(1,1000)';
end



// Natural resource price
if nr_p_opt==1
    rsrc_prce = exogenous_variables(:,5);
elseif nr_p_opt==2
    rsrc_prce = exogenous_variables(:,6);
elseif nr_p_opt==3
    rsrc_prce = exogenous_variables(:,7);
else 
    rsrc_prce = ones(1,1000)';
end


// Public Investment
if pub_inv_opt==1
    invt_xpdt = exogenous_variables(:,8);
elseif pub_inv_opt==2
    invt_xpdt = exogenous_variables(:,9);
elseif pub_inv_opt==3
    invt_xpdt = exogenous_variables(:,10);
else 
    invt_xpdt = zeros(1,1000)';
end


// Public investment efficiency
if pub_inv_eff_opt==1
    efficiency_parameter = exogenous_variables(:,11);
elseif pub_inv_eff_opt==2
    efficiency_parameter = exogenous_variables(:,12);
elseif pub_inv_eff_opt==3
    efficiency_parameter = exogenous_variables(:,13);
else 
    efficiency_parameter = zeros(1,1000)';
end


// Public consumption
if pub_cons_opt==1
    gov_cons = exogenous_variables(:,14);
elseif pub_cons_opt==2
    gov_cons = exogenous_variables(:,15);
elseif pub_cons_opt==3
    gov_cons = exogenous_variables(:,16);
else 
    gov_cons = zeros(1,1000)';
end


// Public transfers
if pub_tran_opt==1
    ex_transfers = exogenous_variables(:,17);
elseif pub_tran_opt==2
    ex_transfers = exogenous_variables(:,18);
elseif pub_tran_opt==3
    ex_transfers = exogenous_variables(:,19);
else 
    ex_transfers = zeros(1,1000)';
end


// Consumption tax
if d_cons_tax_opt==1
    consumption_tax_imposed = exogenous_variables(2:end,20);
elseif d_cons_tax_opt==2
    consumption_tax_imposed = exogenous_variables(2:end,21);
elseif d_cons_tax_opt==3
    consumption_tax_imposed = exogenous_variables(2:end,22);
else 
    consumption_tax_imposed = zeros(1,999)';
end


// Labour tax
if d_lab_tax_opt==1
    labour_tax_imposed = exogenous_variables(2:end,23);
elseif d_lab_tax_opt==2
    labour_tax_imposed = exogenous_variables(2:end,24);
elseif d_lab_tax_opt==3
    labour_tax_imposed = exogenous_variables(2:end,25);
else 
    labour_tax_imposed = zeros(1,999)';
end


// Concessional debt
if cons_debt_opt==1
    conc_debt = exogenous_variables(:,26);
elseif cons_debt_opt==2
    conc_debt = exogenous_variables(:,27);
elseif cons_debt_opt==3
    conc_debt = exogenous_variables(:,28);
else 
    conc_debt = zeros(1,1000)';
end


// Grants
if grants_opt ==1
    frgn_grts = exogenous_variables(:,29);
elseif grants_opt ==2
    frgn_grts = exogenous_variables(:,30);
elseif grants_opt ==3
    frgn_grts = exogenous_variables(:,31);
else 
    frgn_grts = zeros(1,1000)';
end


// Risk premium
if risk_prem_opt==1
    ex_rprem = exogenous_variables(:,32);
elseif risk_prem_opt==2
    ex_rprem = exogenous_variables(:,33);
elseif risk_prem_opt==3
    ex_rprem = exogenous_variables(:,34);
else 
    ex_rprem = zeros(1,1000)';
end


// Remittances
if remit_opt==1
    ex_remit = exogenous_variables(:,35);
elseif remit_opt==2
    ex_remit = exogenous_variables(:,36);
elseif remit_opt==3
    ex_remit = exogenous_variables(:,37);
else 
    ex_remit = zeros(1,1000)';
end


// Exports
if x_opt==1
    ex_exports = exogenous_variables(:,38);
elseif x_opt==2
    ex_exports = exogenous_variables(:,39);
elseif x_opt==3
    ex_exports = exogenous_variables(:,40);
else 
    ex_exports = zeros(1,1000)';
end



// Prepare shocks
ntrl_rsrc_dev            =  ntrl_rsrc(2:1000,1)                                                       .*dummy_periods   ./100;
rsrc_prce_dev            =  (log(rsrc_prce(2:1000,1)./rsrc_prce(1,1)))                                .*dummy_periods;
invt_xpdt_dev            =  (invt_xpdt(2:1000,1) - invt_xpdt(1,1)*ones(999,1))                        .*dummy_periods   ./100;
efficiency_parameter_dev =  (efficiency_parameter(2:1000,1) - efficiency_parameter(1,1)*ones(999,1) ) .*dummy_periods   ./100;
gov_cons_dev             =  (gov_cons(2:1000,1) - gov_cons(1,1)*ones(999,1))                          .*dummy_periods   ./100;
ex_transfers_dev         =  (ex_transfers(2:1000,1) - ex_transfers(1,1)*ones(999,1))                  .*dummy_periods   ./100;
consumption_tax_imposed  =  consumption_tax_imposed                                                   .*dummy_periods   ./100;
labour_tax_imposed       =  labour_tax_imposed                                                        .*dummy_periods   ./100;
conc_debt_dev            =  (conc_debt(2:1000,1) - conc_debt(1,1)*ones(999,1))                        .*dummy_periods   ./100;
frgn_grts_dev            =  (frgn_grts(2:1000,1) - frgn_grts(1,1)*ones(999,1))                        .*dummy_periods   ./100;
ex_rprem_dev             =  (ex_rprem(2:1000,1) - ex_rprem(1,1)*ones(999,1))                          .*dummy_periods   ./100;
ex_remit_dev             =  (ex_remit(2:1000,1) - ex_remit(1,1)*ones(999,1))                          .*dummy_periods   ./100;
ex_exports_dev           =  (ex_exports(2:1000,1) - ex_exports(1,1)*ones(999,1))                      .*dummy_periods   ./100;



ntrl_rsrc_dev(isnan(ntrl_rsrc_dev))=0;
rsrc_prce_dev(isnan(rsrc_prce_dev))=0;
invt_xpdt_dev(isnan(invt_xpdt_dev))=0;
efficiency_parameter_dev(isnan(efficiency_parameter_dev))=0;
gov_cons_dev(isnan(gov_cons_dev))=0;
ex_transfers_dev(isnan(ex_transfers_dev))=0;
consumption_tax_imposed(isnan(consumption_tax_imposed))=0;
labour_tax_imposed(isnan(labour_tax_imposed))=0;
conc_debt_dev(isnan(conc_debt_dev))=0;
frgn_grts_dev(isnan(frgn_grts_dev))=0;
ex_rprem_dev(isnan(ex_rprem_dev))=0;
ex_remit_dev(isnan(ex_remit_dev))=0;
ex_exports_dev(isnan(ex_exports_dev))=0;
xxx1 = [invt_xpdt_dev(1:6); zeros(size(invt_xpdt_dev(7:end),1),1)];
xxx2 = [zeros(1,6)'; invt_xpdt_dev(7:end)];


// Labour supply 
if lab_opt==1
    load('calibrated_shocks.mat','lab_shock_opt1');
    labour_supply_shock  =  lab_shock_opt1(2:end,:) .*dummy_periods;
    labour_supply_shock(isnan(labour_supply_shock))=0;
elseif lab_opt==2
    load('calibrated_shocks.mat','lab_shock_opt2');
    labour_supply_shock  =  lab_shock_opt2(2:end,:) .*dummy_periods;
    labour_supply_shock(isnan(labour_supply_shock))=0;
elseif lab_opt==3
    load('calibrated_shocks.mat','lab_shock_opt3');
    labour_supply_shock  =  lab_shock_opt3(2:end,:) .*dummy_periods;
    labour_supply_shock(isnan(labour_supply_shock))=0;
else 
    labour_supply_shock = zeros(1,999)';
end


if tfp == 0
    tfp_shock = zeros(1,1000)';
    tfp_shock2 = zeros(1,1000)';
else 
    load('ebaseline_shocks.mat','tfp_shock','tfp_shock2');
    tfp_shock = tfp_shock(2:end,:);
    tfp_shock2 = tfp_shock2(2:end,:);
end 


%--------------------------------------------------------------------------
% VARIABLE DECLARATION 
%--------------------------------------------------------------------------
% Endogenous variables
var 

@#include "end_vars.mod"

;

% Exogenous variables
varexo ex_sick eps_inv ex_xx ex_yy eps_yo %ex_risk_inter eps_yo eps_po ex_tauc eps_conc ex_z ex_gc ex_taul ex_sick eps_grts dummy_T dummy_F timeline ex_rem ex_yy vartheta
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

@#include "model_eqs.mod"

end;


%--------------------------------------------------------------------------
% SHOCKS 
%--------------------------------------------------------------------------
shocks;

var eps_inv;
periods 1:999;
values (xxx1);

var eps_yo;
periods 1:999;
values (xxx2);

var ex_sick;
periods 1:1000;
values (tfp_shock2);

var ex_xx;
periods 1:999;
values (ex_exports_dev);

var ex_yy;
periods 1:1000;
values (tfp_shock);


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
simul(periods=1000, maxit =20, stack_solve_algo = 6);



