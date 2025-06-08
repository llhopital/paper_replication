disp('########################################################################################################################')
disp('Plotting scenarios...')
prompt = 'Have you saved your INPUT spreadsheet? (1=yes; 0=no): ';
asnwer = input(prompt);
   if asnwer == 1
   disp('OK')
   else
   prompt = 'Please save INPUT.XLS and press enter... ';
   asnwer = input(prompt);
   end

disp('Importing options...')
load option_matrix

all_names = char('Pub. inv. to GDP (\Delta from SS, pp)', 'Foreign aid change (% of GDP)', 'Grants to GDP (\Delta from SS, pp)',... 
    'Rel. price of nontradables (%\Delta from SS)', 'Cons. tax rate (\Delta from SS, pp)', 'Lab income tax rate (\Delta from SS, pp)', 'Transfers to GDP (\Delta from SS, pp)',... 
    'Gov. cons. to GDP (\Delta from SS, pp)', 'Net real interest rate (\Delta from SS, pp)', 'Priv. inv. to GDP (\Delta from SS, pp)', 'Priv. cons. to GDP (\Delta from SS, pp)',... 
    'Real wage (%\Delta from SS)', 'Labour (%\Delta from SS)', 'Public capital (%\Delta from SS)', 'Priv. capital (%\Delta from SS)', 'GDP growth (%)',... 
    'Tradable output (%\Delta from SS)', 'Nontradable output (%\Delta from SS)', 'Resource output (level)', 'Resource output growth (YoY %)', 'Concessional debt to GDP (\Delta from SS, pp)',... 
    'External commercial debt to GDP (\Delta from SS, pp)', 'Domestic debt to GDP (\Delta from SS, pp)', 'Total public debt to GDP (\Delta from SS, pp)', 'Real exchange rate (%\Delta from SS)',...
    'Resource price (level)', 'Pub invest. efficiency (%)',... 
    'Non-resouce output (%\Delta from SS)', 'Current account deficit to GDP (\Delta from SS, pp)', 'Pub. inv. (%\Delta from SS)', 'Transfers (% of Y_0)',... 
    'Gov. cons. (% of Y_0)', 'Transfers (%\Delta from SS)', 'Gov. cons. (%\Delta from SS)', 'Resource output (%\Delta from SS)', 'Resource revenue (% of tot. rev.)',... 
    'Non-resource GDP growth (%)', 'CPI inflation (%)', 'Resource output (level)', 'Resource price (level)', 'Sovereign risk premium (\Delta, pp)',...
    'Remit. to GDP (\Delta from SS, pp)', 'Exports to GDP (\Delta from SS, pp)','Total GDP growth (YoY %)', 'Total gov. revenue to GDP (\Delta from SS, pp)','CROT to GDP (\Delta from SS, pp)','COPT to GDP (\Delta from SS, pp)');


plot_periods = enddate-startdate+1;
                     
select_strs_all = {'resoutlev'; 'respricelev'; 'taxo'; 'grants'; 'd'; 'pubinv'; 'govcons'; 'espilon'; 'gdp'; 'pubcap'; 'dc'; 'b'; 'totdebt'; 'sovriskprem'; 'tauc'; 'taul'; 'transfers';... 
    'yt'; 'yn'; 'ynon'; 'privcons'; 'privinv'; 'ynongrowth'; 'intrate'; 'labour'; 'wage'; 'rer'; 'totrev'; 'cad'; 'crot'; 'copt'; 'remit'; 'export'};

[graphs_options, legendlabels, allgraphsinputs] = xlsread('inputs.xlsx',4,'G3:AC35');
graphs_vector      = graphs_options(:,1);
scenario1_vector   = graphs_options(:,2);
scenario2_vector   = graphs_options(:,3);
scenario3_vector   = graphs_options(:,4);
scenario4_vector   = graphs_options(:,5);
variable1_vector   = graphs_options(:,10);
variable2_vector   = graphs_options(:,11);
variable3_vector   = graphs_options(:,12);
variable4_vector   = graphs_options(:,13);
variable5_vector   = graphs_options(:,14);
variable6_vector   = graphs_options(:,15);
variable7_vector   = graphs_options(:,16);
variable8_vector   = graphs_options(:,17);
variable9_vector   = graphs_options(:,18);
variable10_vector  = graphs_options(:,19);
variable11_vector  = graphs_options(:,20);
variable12_vector  = graphs_options(:,21);
rows_vector        = graphs_options(:,22);  
columns_vector     = graphs_options(:,23);

disp('Producing graphs...')
for iiii =1:32

if graphs_vector(iiii)==1

   variables_list = [variable1_vector(iiii) variable2_vector(iiii) variable3_vector(iiii) variable4_vector(iiii) variable5_vector(iiii) variable6_vector(iiii)... 
                     variable7_vector(iiii) variable8_vector(iiii) variable9_vector(iiii) variable10_vector(iiii) variable11_vector(iiii) variable12_vector(iiii)]'; 
   variables_list(~any(~isnan(variables_list), 2),:)=[];
   
    if isnan(scenario1_vector(iiii))==0
       eval(['load scenario_' int2str(scenario1_vector(iiii))]);
       all_simulations_matrix =[GISHARE_CHANGE ASTARSHARE_CHANGE GRSHARE_CHANGE PN_DEV TAUC_DEV TAUL_DEV ZSHARE_CHANGE GCSHARE_CHANGE R_NET... 
                         INV_DEV C_DEV W_DEV L_DEV KG_DEV K_DEV Y_GROWTH YT_DEV YN_DEV YO YO_YOY DSHARE_DEV DCSHARE_DEV BSHARE_DEV TOTPUBDEBT_PER... 
                         S_DEV PO EPSILON_PER  YNON_DEV CADSHARE_PER GI_DEV Z_SHAREY GC_SHAREY Z_DEV... 
                         GC_DEV YOTILDE_DEV TAXO_SHARETAX YNON_GROWTH PIE_RATE [ntrl_rsrc;zeros(2,1)] [rsrc_prce;zeros(2,1)] SRP_CHANGE REMIT_CHANGE XX_CHANGE Y_GROWTH  TAXSHARE_CHANGE CROT_DEV COPT_DEV];
       
       select_strs_new = select_strs_all(variables_list);
       [mmm,nnn] = size(select_strs_new); 
             
       for iii = 1 : mmm
       ind=find(ismember(all_strs, select_strs_new(iii)));
       select_names_new(iii,:) = all_names(ind,:);
       select_simulations_matrix_new(:,iii) = all_simulations_matrix(:,ind); 
       end
       
       AAAAAA = select_simulations_matrix_new;
       
    end
     
    if isnan(scenario2_vector(iiii))==0
       eval(['load scenario_' int2str(scenario2_vector(iiii))]);
       all_simulations_matrix =[GISHARE_CHANGE ASTARSHARE_CHANGE GRSHARE_CHANGE PN_DEV TAUC_DEV TAUL_DEV ZSHARE_CHANGE GCSHARE_CHANGE R_NET... 
                         INV_DEV C_DEV W_DEV L_DEV KG_DEV K_DEV Y_GROWTH YT_DEV YN_DEV YO YO_YOY DSHARE_DEV DCSHARE_DEV BSHARE_DEV TOTPUBDEBT_PER... 
                         S_DEV PO EPSILON_PER  YNON_DEV CADSHARE_PER GI_DEV Z_SHAREY GC_SHAREY Z_DEV... 
                         GC_DEV YOTILDE_DEV TAXO_SHARETAX YNON_GROWTH PIE_RATE [ntrl_rsrc;zeros(2,1)] [rsrc_prce;zeros(2,1)] SRP_CHANGE REMIT_CHANGE XX_CHANGE Y_GROWTH  TAXSHARE_CHANGE CROT_DEV COPT_DEV];
  
       select_strs_new = select_strs_all(variables_list);
       [mmm,nnn] = size(select_strs_new); 
             
       for iii = 1 : mmm
       ind=find(ismember(all_strs, select_strs_new(iii)));
       select_names_new(iii,:) = all_names(ind,:);
       select_simulations_matrix_new(:,iii) = all_simulations_matrix(:,ind); 
       end
       
       BBBBBB = select_simulations_matrix_new;
       
    end
     
    if isnan(scenario3_vector(iiii))==0
       eval(['load scenario_' int2str(scenario3_vector(iiii))]);
     all_simulations_matrix =[GISHARE_CHANGE ASTARSHARE_CHANGE GRSHARE_CHANGE PN_DEV TAUC_DEV TAUL_DEV ZSHARE_CHANGE GCSHARE_CHANGE R_NET... 
                         INV_DEV C_DEV W_DEV L_DEV KG_DEV K_DEV Y_GROWTH YT_DEV YN_DEV YO YO_YOY DSHARE_DEV DCSHARE_DEV BSHARE_DEV TOTPUBDEBT_PER... 
                         S_DEV PO EPSILON_PER  YNON_DEV CADSHARE_PER GI_DEV Z_SHAREY GC_SHAREY Z_DEV... 
                         GC_DEV YOTILDE_DEV TAXO_SHARETAX YNON_GROWTH PIE_RATE [ntrl_rsrc;zeros(2,1)] [rsrc_prce;zeros(2,1)] SRP_CHANGE REMIT_CHANGE XX_CHANGE Y_GROWTH  TAXSHARE_CHANGE CROT_DEV COPT_DEV];
  
       select_strs_new = select_strs_all(variables_list);
       [mmm,nnn] = size(select_strs_new); 
             
       for iii = 1 : mmm
       ind=find(ismember(all_strs, select_strs_new(iii)));
       select_names_new(iii,:) = all_names(ind,:);
       select_simulations_matrix_new(:,iii) = all_simulations_matrix(:,ind); 
       end
       
       CCCCCC = select_simulations_matrix_new;
       
    end
    
       if isnan(scenario4_vector(iiii))==0
       eval(['load scenario_' int2str(scenario4_vector(iiii))]);
     all_simulations_matrix =[GISHARE_CHANGE ASTARSHARE_CHANGE GRSHARE_CHANGE PN_DEV TAUC_DEV TAUL_DEV ZSHARE_CHANGE GCSHARE_CHANGE R_NET... 
                         INV_DEV C_DEV W_DEV L_DEV KG_DEV K_DEV Y_GROWTH YT_DEV YN_DEV YO YO_YOY DSHARE_DEV DCSHARE_DEV BSHARE_DEV TOTPUBDEBT_PER... 
                         S_DEV PO EPSILON_PER  YNON_DEV CADSHARE_PER GI_DEV Z_SHAREY GC_SHAREY Z_DEV... 
                         GC_DEV YOTILDE_DEV TAXO_SHARETAX YNON_GROWTH PIE_RATE [ntrl_rsrc;zeros(2,1)] [rsrc_prce;zeros(2,1)] SRP_CHANGE REMIT_CHANGE XX_CHANGE Y_GROWTH  TAXSHARE_CHANGE CROT_DEV COPT_DEV];
   
       select_strs_new = select_strs_all(variables_list);
       [mmm,nnn] = size(select_strs_new); 
             
       for iii = 1 : mmm
       ind=find(ismember(all_strs, select_strs_new(iii)));
       select_names_new(iii,:) = all_names(ind,:);
       select_simulations_matrix_new(:,iii) = all_simulations_matrix(:,ind); 
       end
       
       DDDDDD = select_simulations_matrix_new;
       
    end
     
    h=figure('name', ['Graph ' int2str(iiii)] ,'Position', [800, 0, 1300, 900]);
    axes ('position', [0, 0, 1, 1]);

for j = 1:mmm
    subplot(rows_vector(iiii),columns_vector(iiii),j)
    if isnan(scenario1_vector(iiii))==0
    plot(startdate:startdate+plot_periods-1, AAAAAA(1:plot_periods,j),'-k', 'LineWidth',3, 'MarkerSize', 10,'MarkerEdgeColor','k', 'MarkerFaceColor','w'); hold on;
    end
    if isnan(scenario2_vector(iiii))==0
    plot(startdate:startdate+plot_periods-1, BBBBBB(1:plot_periods,j),'--bo', 'LineWidth',3, 'MarkerSize', 8,'MarkerEdgeColor','b', 'MarkerFaceColor','w'); hold on;
    end
    if isnan(scenario3_vector(iiii))==0
    plot(startdate:startdate+plot_periods-1, CCCCCC(1:plot_periods,j),'--rs', 'LineWidth',3, 'MarkerSize', 6,'MarkerEdgeColor','r', 'MarkerFaceColor','w'); hold on;
    end
    if isnan(scenario4_vector(iiii))==0
    plot(startdate:startdate+plot_periods-1, DDDDDD(1:plot_periods,j),'-.g', 'LineWidth',3, 'MarkerSize', 8,'MarkerEdgeColor','r', 'MarkerFaceColor','w'); hold on;
    end
    xlim([startdate enddate])
    title(select_names_new(j,:),'FontSize',10)
    set( gca, 'XTick', starting_year:starting_year+horizon-1);
end

if isnan(scenario2_vector(iiii))==0
alllegendlabels = [legendlabels(iiii,1),legendlabels(iiii,2)];
end

if isnan(scenario3_vector(iiii))==0
alllegendlabels = [alllegendlabels, legendlabels(iiii,3)];
end

if isnan(scenario4_vector(iiii))==0
alllegendlabels = [alllegendlabels, legendlabels(iiii,4)];
end

if isnan(scenario2_vector(iiii))==0 | isnan(scenario3_vector(iiii))==0 | isnan(scenario4_vector(iiii))==0
lh = legend(alllegendlabels, 'Location', 'Best', 'Orientation', 'horizontal');
set(lh,'position',[.45 .50 .1 .03])
end

end

end

disp('DONE.')



