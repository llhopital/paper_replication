%function [Saving,PN,YN,PTH,YT,WN,LNN,WT,LT,OMEGAN,OMEGAT,GSaving,NIIP,CAD,Y,B,BSTAR,S,RSTAR,deltan,KN,deltat,KT,INV,eta,omega,BOPT,PG,GI,rd,D,RDC,DC,R,XX,MM_TOTAL,GR,W,LOPT,LROT,C,GC,MM,L]=simulatescenarios(iii)
%% Housekeeping (Do not touch the following lines) 

clearvars -except iiii T timescale select_varrs

path_to_toolkit = pwd;
addpath(strcat(path_to_toolkit,'\dynare\4.5.6\matlab'));

disp('########################################################################################################################')
disp('Initializing DIGNAR-19...')
disp(' ')
disp(' ')
disp(' ')
disp('Importing inputs...')

%% Import parameter values (for baseline calibration) from Excel spreadsheet (Do not touch the following lines)
[ndata, text, alldata] = xlsread('inputs.xlsx',1,'C8:Q103');
param_names  = char(text);
param_values = ndata(:,iiii);
[mmm,nnn] = size(ndata(:,iiii));
for i = 1:mmm                                  
  paramname = deblank(param_names(i,:));                   
  eval([ paramname ' = param_values(' int2str(i) ');']);
end

scenarios_options  = xlsread('inputs.xlsx',3,'B5:AE38');
starting_year      = scenarios_options(1,1);
horizon            = scenarios_options(2,1);
scenarios_vector   = scenarios_options(5,:);
simulate_vector    = scenarios_options(7,:);
nr_y_vector        = scenarios_options(10,:);
nr_p_vector        = scenarios_options(11,:);
pub_inv_vector     = scenarios_options(14,:);
pub_inv_eff_vector = scenarios_options(15,:);
pub_cons_vector    = scenarios_options(16,:);
pub_tran_vector    = scenarios_options(17,:);
d_cons_tax_vector  = scenarios_options(18,:);
d_lab_tax_vector   = scenarios_options(19,:);
cons_debt_vector   = scenarios_options(22,:);
grants_vector      = scenarios_options(23,:);
com_borr_vector    = scenarios_options(24,:);
exd_share_vector   = scenarios_options(25,:);
risk_prem_vector   = scenarios_options(26,:);
remit_vector       = scenarios_options(29,:);
x_vector           = scenarios_options(30,:);
cal_lab_vector     = scenarios_options(33,:);
cal_exter_vector   = scenarios_options(34,:);

selected_scenarios_list = scenarios_vector.*simulate_vector;
selected_scenarios_list(selected_scenarios_list==0) = [];

ex_series = {'nr_y_vector'; 'nr_p_vector'; 'pub_inv_vector'; 'pub_inv_eff_vector'; 'pub_cons_vector'; ...
    'pub_tran_vector'; 'd_cons_tax_vector'; 'd_lab_tax_vector'; 'cons_debt_vector'; 'grants_vector'; 'risk_prem_vector'; ...
    'remit_vector'; 'x_vector'};

ex_names = {'A.1 Natural resource output growth'; 'A.2 Natural resource price'; 'B.1 Public Investment'; 'B.1.1 Public investment efficiency'; 'B.2 Public consumption'; ...
    'B.3 Transfers'; 'B.4 Change in Consumption Tax rate'; 'B.5 Change in Labour Tax rate'; 'C.1 Concessional debt'; 'C.2 Grants'; 'C.4 Sovereign risk premium'; ...
    'D.1 Remittances'; 'D.2 Exports'};

disp(' ')
disp(['You have chosen to simulate the following scenarios: ' int2str(selected_scenarios_list) '.'])
disp(' ')
disp('Checking INPUT spreadsheet...')


%% Check inputs.xlsx for errors

temp_chk =0;
err_preproc = 0;

for llll=selected_scenarios_list
disp(' ')
disp(['Scenario ' int2str(llll) ':']) 
cannotbeblank = scenarios_options([5 7 10 11 14 15 16 17 18 19 22 23 24 26 29 30 33],llll);

if com_borr_vector(1,llll)==1
cannotbeblank = [cannotbeblank; scenarios_options([25],llll)];
end

if llll~=1
cannotbeblank = [cannotbeblank; scenarios_options([34],llll)];
end

cannotbeblank_vector(llll) = sum(isnan(cannotbeblank));

if cannotbeblank_vector(llll) ==0
    disp('CHECK: Required options have been selected.')
else
    fprintf(2, 'ERROR:') 
    disp([' Missing option(s) in Scenarios worksheet.'])
    err_preproc = err_preproc + 1;
    
end


if nansum(simulate_vector.*cal_lab_vector)>0
    ls_check = xlsread('inputs.xlsx',2,'AP9:AR1008');
    if cal_lab_vector(llll) ==0
        
    else
        if isnan(ls_check(2,cal_lab_vector(llll)))
            fprintf(2, 'ERROR:') 
            disp([' Labour supply series have not been provided.'])
            err_preproc = err_preproc + 1;
        else
            disp(['CHECK: Labour supply series have been provided.']) 
        end
    end
end



ex_check = xlsread('inputs.xlsx',2,'C9:AR1008');
catch_missed_ex = {};
for ii = 1:size(ex_series,1)
    if nansum(simulate_vector.*eval(char(ex_series(ii))))>0
       if eval([char(ex_series(ii)) '(' int2str(llll) ')']) ==0
           
       else     
            if isnan(ex_check(1,(ii-1)*3+eval([char(ex_series(ii)) '(' int2str(llll) ')']))) || isnan(ex_check(2,(ii-1)*3+eval([char(ex_series(ii)) '(' int2str(llll) ')'])))
               err_preproc = err_preproc + 1;
               catch_missed_ex{end+1} = ex_names{ii};
               
            end
       end           
    else
        
    end
end

if isempty(catch_missed_ex) 
    disp(['CHECK: Exogenous series have been provided.'])
else 
    fprintf(2, 'ERROR:') 
    disp([' Some exogenous series have not been provided. Please check: '])
    disp(char(catch_missed_ex))
end
   


if llll~=1
    if nansum(simulate_vector(2:end).*cal_exter_vector(2:end))>0
        if cal_exter_vector(llll) ==0
            
        else
            if isfile('ebaseline_shocks.mat')
                load('ebaseline_shocks.mat','tfp_param_values','tfp_external_baseline');
                new_external_baseline = xlsread('inputs.xlsx',5,'C7:D1006');
                    if isequal(tfp_param_values,param_values) && isequal(tfp_external_baseline(1:1000,:),new_external_baseline)
                        % If ok
                        disp(['CHECK: Shocks used to align with an external baseline have been provided.']);
                    else
                        % If not
                   % fprintf(2, 'ERROR:')     
                  %  disp(['Saved shocks do not correspond to the current setup. Run the realism tool (calib_baseline) again.']);
                    %err_preproc = err_preproc + 1;
                    end
            
            else
                fprintf(2, 'ERROR:') 
                disp([' ebaseline_shocks.mat is missing. Run the realism tool (calib_baseline).'])
                err_preproc = err_preproc + 1;
            end
            temp_chk = temp_chk+1;
         
            
        end
    end

end

end



if err_preproc >0
disp(' ')    
disp('Please correct your inputs and try again.')
disp(' ')
disp('########################################################################################################################')
else
disp(' ')
disp('Preprocessing completed!')
disp(' ')
disp('########################################################################################################################')


%% Define variable labels (Do not touch the following lines)
all_strs = { 
         'pubinv'       %%% Pub. inv. to GDP ratio (\Delta from SS) 
         'aid'          % Foreign aid change (% of GDP)
         'grants'       %%% Grants to GDP (\Delta from SS)
         'pn'           % Rel. price of nontradables (%\Delta)
         'tauc'         %%% Cons. tax rate (\Delta)
         'taul'         %%% Lab income tax rate (\Delta)
         'transfers'    %%% Transfers to GDP ratio (Delta from SS)
         'govcons'      %%% Gov. cons. to GDP ratio (\Delta from SS)
         'intrate'      %%% Net real interest rate (\Delta from SS, percentage points)
         'privinv'      %%% Priv. investment (%\Delta)
         'privcons'     %%% Priv. consumption (%\Delta)
         'wage'         %%% Real wage (%\Delta)
         'labour'       %%% Labour (%\Delta)
         'pubcap'       % Public capital (%\Delta)
         'privcap'      % Priv. capital (%\Delta)
         'gdpgrowth'    % GDP growth (%)
         'yt'           % Tradable output (%\Delta)
         'yn'           % Nontradable output (%\Delta)
         'd'            %%% Concessional debt to GDP(\Delta from SS)
         'dc'           %%% External commercial debt to GDP (\Delta from SS)
         'b'            %%% Domestic debt to GDP ratio (\Delta from SS)
         'totdebt'      %%% Total public debt (\Delta from SS)
         'rer'          %%% Real exchange rate (%\Delta)
         'espilon'      %%% Pub invest. efficiency (%)
         'ynon'         % Non-resouce output (%\Delta)
         'cad'          %%% Current account deficit to GDP (\Delta from SS)
         'pubinvdev'    % Pub. inv. (%\Delta)
         'transfersyo'  % Transfers (% of Y_0)
         'govconsyo'    % Gov. cons. (% of Y_0)
         'transfersdev' % Transfers (%\Delta)
         'govconsdev'   % Gov. cons. (%\Delta)
         'ynongrowth'   % Non-resource GDP growth (%)
         'inflation'    % CPI inflation (%)
         'sovriskprem'  %%% Sovereign risk premium (\Delta from SS, percentage points)
         'remit'        %%% Remittances to GDP ratio (\Delta from SS)
         'export'       %%% Exports to GDP ratio (\Delta from SS)
         'gdp'          %%% Total GDP growth (YoY)
         'totrev'       % Total government revenue to GDP (\Delta from SS, pp)
         'crot'         % Consumption of RoT to GDP (\Delta from SS, pp)
         'copt'          % Consumption of RA to GDP (\Delta from SS, pp)
       };
%%           



%% Define options 

% Select variables to plot in individual figures and/or save into excel
select_strs = {'gdp'; 'pubinv'; 'espilon'; 'govcons'; 'transfers'; 'tauc'; 'taul'; 'grants'; 'totdebt'; 'b'; 'dc'; 'd'; 'intrate'; 'sovriskprem'; 'rer'; 'remit'; 'export'; 'cad'; 'wage'; 'labour'; 'privinv'; 'privcons'};

%

% Customize subplot for individual figures
rrr = 7;         % # of rows 3
ccc = 4;         % # of columns 6
startdate = starting_year;  % Starting year (use two digits)
enddate = startdate + horizon -1;    % End year (use two digits)

% Do you want to run new simulations again?
new_simulat = 1; % 0=no ; 1=yes

% Do you want to plot individual figures for each scenario?
ind_fig = 1;     % 0=no ; 1=yes

% Do you want to save simulation results in excel output file?
sav_xls = 1;     % 0=no ;  1=yes

% Do you want to plot a combined figure for the no-borrowing case?
plot_figure_no_borrowing = 0; % 0=no ;  1=yes

% Do you want to plot a combined figure for the borrowing case?
plot_figure_borrowing = 0; % 0=no ;  1=yes

ppace = 0;

save option_matrix
%% Labour supply shocks calibration
if nansum(simulate_vector.*cal_lab_vector)>0
disp('########################################################################################################################')
disp('Calibrating labour supply...')
disp(' ')

temp_lab = 0;


if isfile('calibrated_shocks.mat')

    % If yes, check if all selected labour options are saved in a file
    load('calibrated_shocks.mat');
    non_zero_lab = cal_lab_vector(simulate_vector.*cal_lab_vector~=0);
    for iii= unique(non_zero_lab(~isnan(non_zero_lab))) 
        eval(['present = exist(''lss_file_opt' int2str(iii) ''''  ');'])
        if present==1
            lss_check = xlsread('inputs.xlsx',2,'AP9:AR1008');
            lss_new = lss_check(2:end,iii)./100;
            lss_new(horizon:end,:)=0;
            lss_new(isnan(lss_new))=0;
            if isequal(pv_file,param_values) && isequal(eval(['lss_file_opt' int2str(iii)]),lss_new)
                disp(' ')
                disp(['Labour supply shocks for opt' int2str(iii) ' already computed.']);
            else
                disp(' ')
                disp(['Setup for opt' int2str(iii) ' changed. Initialising new search...']);
                dynare LCALIB.mod
                disp(['Labour supply option ' int2str(iii) ': Desired sequence of supply shocks found!'])
                eval(['lab_shock_opt' int2str(iii) '= ex_sick(1:1000,:);']);
                eval(['lss_file_opt' int2str(iii) '= labour_supply_shock;']);
                pv_file = param_values;
                eval(['save calibrated_shocks.mat lab_shock_opt' int2str(iii) ' pv_file lss_file_opt' int2str(iii) ' -append']);
            end 
        else
            disp(' ')
            disp(['Shocks for opt' int2str(iii) ' not available. Initialising new search...']);
            dynare LCALIB.mod
            disp(['Labour supply option ' int2str(iii) ': Desired sequence of supply shocks found!'])
            eval(['lab_shock_opt' int2str(iii) '= ex_sick(1:1000,:);']);
            eval(['lss_file_opt' int2str(iii) '= labour_supply_shock;']);
            pv_file = param_values;
            eval(['save calibrated_shocks.mat lab_shock_opt' int2str(iii) ' pv_file lss_file_opt' int2str(iii) ' -append']);
        end
    end
            
else
    
    disp(' ')
    disp(['Labour supply shocks not available. Initialising new search...']);
    disp(['Searching for the desired sequence of labour supply shocks...']);
    for iii= unique(cal_lab_vector(~isnan(cal_lab_vector)))
        dynare LCALIB.mod
        disp(' ')
        disp(['Labour supply option ' int2str(iii) ': Desired sequence of supply shocks found!'])
        eval(['lab_shock_opt' int2str(iii) '= ex_sick(1:1000,:);']);
        eval(['lss_file_opt' int2str(iii) '= labour_supply_shock;']);
        
        if temp_lab==0
            pv_file = param_values;
            eval(['save calibrated_shocks.mat lab_shock_opt' int2str(iii) ' pv_file lss_file_opt' int2str(iii)]);
            temp_lab = temp_lab +1;
        else 
            eval(['save calibrated_shocks.mat lab_shock_opt' int2str(iii) ' lss_file_opt' int2str(iii) ' -append']);
        
        end 
    end
    
end

disp(' ')
disp(['Labour supply calibration completed!']);
disp(' ')
disp('########################################################################################################################')
end


%% DIGNAR-19 simulation

disp('########################################################################################################################')
disp(['Starting DIGNAR-19 simulations...'])
disp(' ') 

for kkkk = 1:30

scenario_num    =   scenarios_vector(kkkk);      % Set scenario #
scenario_label  =   ['Scenario #' scenario_num];

sel_scen = simulate_vector(kkkk);

if sel_scen == 1

disp([' '])
disp('#######################')
disp(['Simulating scenario ' int2str(scenario_num) '.'])
disp('#######################')

exdebt_iii = 1 - com_borr_vector(kkkk);
if exdebt_iii == 1
    varkappa_iii = 0;
else
    varkappa_iii = exd_share_vector(kkkk);
end


nr_y_opt            = nr_y_vector(kkkk);
nr_p_opt            = nr_p_vector(kkkk);
pub_inv_opt         = pub_inv_vector(kkkk);
pub_inv_eff_opt     = pub_inv_eff_vector(kkkk);
pub_cons_opt        = pub_cons_vector(kkkk);
pub_tran_opt        = pub_tran_vector(kkkk);
d_cons_tax_opt      = d_cons_tax_vector(kkkk);
d_lab_tax_opt       = d_lab_tax_vector(kkkk);
cons_debt_opt       = cons_debt_vector(kkkk);
grants_opt          = grants_vector(kkkk);
risk_prem_opt       = risk_prem_vector(kkkk);
remit_opt           = remit_vector(kkkk);	
x_opt               = x_vector(kkkk);
lab_opt             = cal_lab_vector(kkkk);



if scenario_num == 1
    tfp             = 0; 
else 
    tfp             = cal_exter_vector(kkkk);
end


if new_simulat ==1
rehash toolboxcache

dynare DSFNR.mod 
eval(['save scenario_' int2str(scenario_num)]);


end


end
end


  
    

for kkkk = 1:30

scenario_num    =   scenarios_vector(kkkk);      
sel_scen = simulate_vector(kkkk);

if sel_scen == 1


eval(['load scenario_' int2str(scenario_num)]);
load option_matrix


if ind_fig == 1

    %script_plot_scenario
end


if sav_xls == 1
%script_save_on_excel;
end
end
end


%%

tot_scenarios = sum(simulate_vector);
disp('#####################################################################################################')
disp(' ')
disp('Simulations completed.')
disp(' ')
disp(['List of simulated scenarios: ' int2str(selected_scenarios_list) '.'])
disp(' ')
disp('Simulated series saved in excel file output.xls (each scenario is saved in a separate worksheet).')
disp(' ')
disp('#####################################################################################################')

end

