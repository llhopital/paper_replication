%% Housekeeping (Do not touch the following lines)
clearvars -except T timescale select_varrs
close all
clc
path_to_toolkit = pwd;
addpath(strcat(path_to_toolkit,'\dynare\4.5.6\matlab'));



disp('########################################################################################################################')
disp('Initializing the realism tool...')
disp(' ')
disp(' ')
disp(' ')
disp('Importing inputs...')


%% Import parameter values (for baseline calibration) from Excel spreadsheet (Do not touch the following lines)
[ndata, text, alldata] = xlsread('inputs.xlsx',1,'C9:D92');
param_names  = char(text);
param_values = ndata;
[mmm,nnn] = size(ndata);
for i = 1:mmm                                  
  paramname = deblank(param_names(i,:));                   
  eval([ paramname ' = param_values(' int2str(i) ');']);
end

scenarios_options  = xlsread('inputs.xlsx',3,'B5:B37');
starting_year      = scenarios_options(1,1);
horizon            = scenarios_options(2,1);
nr_y_vector        = scenarios_options(10,1);
nr_p_vector        = scenarios_options(11,1);
pub_inv_vector     = scenarios_options(14,1);
pub_inv_eff_vector = scenarios_options(15,1);
pub_cons_vector    = scenarios_options(16,1);
pub_tran_vector    = scenarios_options(17,1);
d_cons_tax_vector  = scenarios_options(18,1);
d_lab_tax_vector   = scenarios_options(19,1);
cons_debt_vector   = scenarios_options(22,1);
grants_vector      = scenarios_options(23,1);
com_borr_vector    = scenarios_options(24,1);
exd_share_vector   = scenarios_options(25,1);
risk_prem_vector   = scenarios_options(26,1);
remit_vector       = scenarios_options(29,1);
x_vector           = scenarios_options(30,1);
cal_lab_vector     = scenarios_options(33,1);


ex_series = {'nr_y_vector'; 'nr_p_vector'; 'pub_inv_vector'; 'pub_inv_eff_vector'; 'pub_cons_vector'; ...
    'pub_tran_vector'; 'd_cons_tax_vector'; 'd_lab_tax_vector'; 'cons_debt_vector'; 'grants_vector'; 'risk_prem_vector'; ...
    'remit_vector'; 'x_vector'};

ex_names = {'A.1 Natural resource output growth'; 'A.2 Natural resource price'; 'B.1 Public Investment'; 'B.1.1 Public investment efficiency'; 'B.2 Public consumption'; ...
    'B.3 Transfers'; 'B.4 Change in Consumption Tax rate'; 'B.5 Change in Labour Tax rate'; 'C.1 Concessional debt'; 'C.2 Grants'; 'C.4 Sovereign risk premium'; ...
    'D.1 Remittances'; 'D.2 Exports'};


disp(' ')
disp('Checking INPUT spreadsheet...')


%% Check inputs.xlsx for errors

temp_chk =0;
err_preproc = 0;


cannotbeblank = scenarios_options([5 7 10 11 14 15 16 17 18 19 22 23 24 26 29 30 33]);

if com_borr_vector==1
cannotbeblank = [cannotbeblank; scenarios_options(25)];
end

cannotbeblank_vector = sum(isnan(cannotbeblank));

if cannotbeblank_vector ==0
    disp('CHECK: Required options have been selected.')
else
    fprintf(2, 'ERROR:') 
    disp([' Missing option(s) in Scenarios worksheet.'])
    err_preproc = err_preproc + 1;
    
end

if cal_lab_vector~=0
    ls_check = xlsread('inputs.xlsx',2,'AP9:AR1008');
    if cal_lab_vector==0
        
    else
        if isnan(ls_check(2,cal_lab_vector))
            fprintf(2, 'ERROR:') 
            disp([' Labour supply series are not provided.'])
            err_preproc = err_preproc + 1;
        else
            disp(['CHECK: Labour supply series have been provided.']) 
        end
    end
end


ex_check = xlsread('inputs.xlsx',2,'C9:AR1008');
catch_missed_ex = {};
for ii = 1:size(ex_series,1)
    if eval(char(ex_series(ii)))~=0
       if eval(char(ex_series(ii))) ==0
           
       else     
            if isnan(ex_check(1,(ii-1)*3+eval(char(ex_series(ii))))) || isnan(ex_check(2,(ii-1)*3+eval(char(ex_series(ii)))))
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


%%

%% Define variable labels (Do not touch the following lines)
all_strs = { 
         'pubinv'       % Pub. inv. (% of GDP) 
         'aid'          % Foreign aid change (% of GDP)
         'grants'       % Grants (% of GDP)
         'pn'           % Rel. price of nontradables (%\Delta)
         'tauc'         % Cons. tax rate (%)
         'taul'         % Lab income tax rate (%)
         'transfers'    % Transfers change (% of GDP)
         'govcons'      % Gov. cons. change (% of GDP)
         'intrate'      % Net real interest rate (%)
         'privinv'      % Priv. investment (%\Delta)
         'privcons'     % Priv. consumption (%\Delta)
         'wage'         % Real wage (%\Delta)
         'labour'       % Labour (%\Delta)
         'pubcap'       % Public capital (%\Delta)
         'privcap'      % Priv. capital (%\Delta)
         'gdpgrowth'    % GDP growth (%)
         'yt'           % Tradable output (%\Delta)
         'yn'           % Nontradable output (%\Delta)
         'yo'           % Resource output in units of domestic consumption (%\Delta)
         'd'            % Concessional debt (% of GDP)
         'dc'           % External commercial debt (% of GDP)
         'b'            % Domestic debt (% of GDP)
         'totdebt'      % Total public debt (% of GDP)
         'rer'          % Real exchange rate (%\Delta)
         'po'           % Resource price (%\Delta)
         'swf'          % Stabilization fund (% of GDP)
         'delta'        % Pub. cap. deprec. rate (%)
         'espilon'      % Pub invest. efficiency (%)
         'ynon'         % Non-resouce output (%\Delta)
         'cad'          % Current account deficit (% of GDP)
         'pubinvdev'    % Pub. inv. (%\Delta)
         'transfersyo'  % Transfers (% of Y_0)
         'govconsyo'    % Gov. cons. (% of Y_0)
         'transfersdev' % Transfers (%\Delta)
         'govconsdev'   % Gov. cons. (%\Delta)
         'yotilde'      % Resource output in units of foreign consumption (%\Delta)
         'taxo'         % Resource revenue (% of tot. rev.)
         'ynongrowth'   % Non-resource GDP growth (%)
         'inflation'    % CPI inflation (%)
         'resoutlev'    % Resource output (level)
         'respricelev'  % Resource price (level)
       };
%%           

%% Define options 

% Select variables to plot in individual figures and/or save into excel
select_strs = {'resoutlev'; 'respricelev'; 'taxo'; 'grants'; 'd'; 'pubinvdev'; 'pubinv'; 'espilon'; 'delta'; 'pubcap'; 'dc'; 'b'; 'totdebt'; 'swf'; 'tauc'; 'taul'; 'transfersdev';... 
'govconsdev'; 'yt'; 'yn'; 'ynon'; 'privcons'; 'privinv'; 'ynongrowth'; 'intrate'; 'labour'; 'wage'; 'rer'};

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
if cal_lab_vector~=0
disp('########################################################################################################################')
disp('Calibrating labour supply...')
disp(' ')

temp_lab = 0;


if isfile('calibrated_shocks.mat')
    load('calibrated_shocks.mat');
    for iii= cal_lab_vector
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
disp(' ')
disp('####################################')
disp('Simulating the model-based baseline.')
disp('####################################')

exdebt_iii = 1 - com_borr_vector;
if exdebt_iii == 1
    varkappa_iii = 0;
else
    varkappa_iii = exd_share_vector;
end


nr_y_opt            = nr_y_vector;
nr_p_opt            = nr_p_vector;
pub_inv_opt         = pub_inv_vector;
pub_inv_eff_opt     = pub_inv_eff_vector;
pub_cons_opt        = pub_cons_vector;
pub_tran_opt        = pub_tran_vector;
d_cons_tax_opt      = d_cons_tax_vector;
d_lab_tax_opt       = d_lab_tax_vector;
cons_debt_opt       = cons_debt_vector;
grants_opt          = grants_vector;
risk_prem_opt       = risk_prem_vector;
remit_opt           = remit_vector;	
x_opt               = x_vector;
lab_opt             = cal_lab_vector;
tfp                 = 0; 


rehash toolboxcache
dynare DSFNR.mod 

ad_hoc_proj  = xlsread('inputs.xlsx',5,'C7:D1008');
ad_hoc_debt1 = ad_hoc_proj(1:horizon,1);
ad_hoc_gdp1 = ad_hoc_proj(1:horizon,2);
t = 0:1:0+horizon-1;

old_debt = 100.*(L./L(1)-1);
old_growth = 100.*(Y./Y(1)-1);

    
disp(' ')
disp(' ') 

       
        disp(' ') 
        disp(['Aligning projections...']);
        dynare EBASELINE.mod
        disp(' ') 
        disp(['Desired sequence of shocks found!']);
        tfp_shock = ex_yy(1:1001,:);
        tfp_shock2 = ex_sick(1:1001,:);
        tfp_param_values = param_values;
        tfp_external_baseline = ad_hoc_proj;
        if isfile('ebaseline_shocks.mat')
            save('ebaseline_shocks.mat','tfp_shock','tfp_shock2','tfp_param_values','tfp_external_baseline','-append');
        else
            save('ebaseline_shocks.mat','tfp_shock','tfp_shock2','tfp_param_values','tfp_external_baseline');
        end
        plot_tfp = exp(tfp_shock) - ones(size(tfp_shock,1),1);
        plot_tfp2 = exp(tfp_shock2) - ones(size(tfp_shock2,1),1);
        tfp = 1;
        disp(' ') 
        disp(' ')
        disp('####################################')
        disp('Simulating the adjusted baseline.')
        disp('####################################')
        dynare DSFNR.mod
 %       new_debt = (BSHARE + S.*D./Y).*100;
%       tax_adj = plot_tfp2.*(oo_.steady_state(35).*C(1:end-1) + oo_.steady_state(34).*W(1:end-1).*L(1:end-1))./Y(1:end-1);
        

        f1 = figure(Name="Shocks to match Malliaropulos et al. (2021)");
        subplot(2,2,1)
        pdebt=plot(1:T-1,old_debt(1:T-1),1:T-1,ad_hoc_debt1(1:T-1),1:T-1,100.*(L(1:T-1)/L(1)-1));
        ylabel('%');
        xlabel('Year');
        set( gca, 'XTick', 0:0+T-1);
        title({'Employment',' '});
        axis tight
        pdebt(1).LineStyle = '-';
        pdebt(1).LineWidth = 2;
        pdebt(1).Color = 'g';
        pdebt(2).LineStyle = '-';
        pdebt(2).LineWidth = 2;
        pdebt(2).Color = 'k';
        pdebt(3).LineStyle = '--';
        pdebt(3).LineWidth = 2;
        pdebt(3).Color = 'r';
        legend('Model baseline','User-provided baseline','Adjusted baseline')
        legend('Location','southoutside')

       subplot(2,2,2)
        pdebt=plot(1:T-1,old_growth(1:T-1),1:T-1,ad_hoc_gdp1(1:T-1),1:T-1,100.*(Y(1:T-1)/Y(1)-1));
        ylabel('%');
        xlabel('Year');
        set( gca, 'XTick', 0:0+T-1);
        title({'Real GDP',' '});
        axis tight
        pdebt(1).LineStyle = '-';
        pdebt(1).LineWidth = 2;
        pdebt(1).Color = 'g';
        pdebt(2).LineStyle = '-';
        pdebt(2).LineWidth = 2;
        pdebt(2).Color = 'k';
        pdebt(3).LineStyle = '--';
        pdebt(3).LineWidth = 2;
        pdebt(3).Color = 'r';
        legend('Model baseline','User-provided baseline','Adjusted baseline')
        legend('Location','southoutside')
        
        subplot(2,2,3)
        ptfp=bar(1:T-1,-plot_tfp2(1:T-1).*100);
        ylabel('% ');
        xlabel('Year');
        set( gca, 'XTick', 0:0+T-1);
        title({'Labour supply shocks',' '});
        axis tight
        legend('Implied by the adjusted baseline')
        legend('Location','southoutside')
        
        subplot(2,2,4)
        ptfp=bar(1:T-1,plot_tfp(1:T-1).*100);
        ylabel('%');
        xlabel('Year');
        set( gca, 'XTick', 0:0+T-1);
        title({'TFP shocks',' '});
        axis tight
        legend('Implied by the adjusted baseline')
        legend('Location','southoutside')
   
        
        
        
        disp('#####################################################################################################')
        disp(' ')
        disp('Simulation completed!')
        disp(' ')
        disp('Shocks saved!')
        disp(' ')
        disp('#####################################################################################################')


        












end


