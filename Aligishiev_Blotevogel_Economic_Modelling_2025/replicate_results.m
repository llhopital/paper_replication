%==========================================================================
% Replication Script for:
% "No Quick Fix: The Recovery and Resilience Plan and External Position in
% Greece" by Aligishiev and Blotevogel (2025)
% Based on the DIGNAR-19 toolkit (Aligishiev, Melina & Zanna, 2021)
%==========================================================================

%% 1. Environment initialization
clear variables; close all; clc;

% Ensure output directory exists
chartsDir = fullfile(pwd, 'charts');
if ~isfolder(chartsDir)
    mkdir(chartsDir);
end

%% 2. Simulation configuration
T            = 26;                 % Number of periods
timescale    = 0:(T-1);            % Time index
select_varrs = {                   % Variables to extract
'Y'; 'YDOM'; 'YT'; 'YN'; 'KT'; 'KN'; 'L'; 'LNN'; 'LT'; 'W'; 'WN'; 'WT';...
'LOPT'; 'LROT'; 'C'; 'COPT'; 'CROT'; 'Z'; 'R'; 'IN'; 'IT'; 'QN'; 'QT';...
'GC'; 'TAUC'; 'B'; 'BSTAR'; 'XX'; 'MM_TOTAL'; 'S'; 'PTH'; 'PT'; 'PN';...
'PG'; 'CAD';'INV'
};

%% 3. Calibrate reform shocks
% Calculate TFP and labour disutility shocks that approximately match
% output and employment gains from RRF in Malliaropulos et al. (2021)
calib_baseline;

%% 4. Scenario simulations
numScenarios = 14;
for iiii = 1:numScenarios
    
    % 4.1 Run scenario‐specific perfect-foresight simulations
    simulatescenarios;

    % 4.2 Compute responses of main vars and decompose these responses
    % [Needs tidying up]
    calculate_decompositions;
  
    %% 4.3 Save scenario results
    % Store all variables along with T and timeVector
    prepare_vars;
    saveFileName = sprintf('scenario_s%d.mat', iiii);
    save(saveFileName, 'T', 'timescale', sprintf('*_s%d', iiii));

    %% 4.4 Produce figures 4 and 6
    if iiii==1
        print_fig46;
    end
end

%% 5. Produce remaining figures
% Figures 5, 7, 8, and all remaining figures from the paper's appendices
print_fig578appb;
print_other_app;





 
