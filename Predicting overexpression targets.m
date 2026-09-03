clear;clc
setRavenSolver('gurobi')
checkInstallation;
model = importModel('iPichia.xml');
metsToAdd.mets         = {'bisabolene_c'};
metsToAdd.metNames     = {'bisabolene'};
metsToAdd.compartments = {'c'};
model = addMets(model,metsToAdd);
metsToAdd.mets         = {'bisabolene_e'};
metsToAdd.metNames     = {'bisabolene'};
metsToAdd.compartments = {'e'};
model = addMets(model,metsToAdd);
metsToAdd.mets         = {'bisabolene_m'};
metsToAdd.metNames     = {'bisabolene'};
metsToAdd.compartments = {'m'};
model = addMets(model,metsToAdd);
rxnsToAdd.rxns      = {'Bir'};
rxnsToAdd.equations = {'frdp_c <=> bisabolene_c + ppi_c'};
model=addRxns(model,rxnsToAdd);
rxnsToAdd.rxns      = {'iki'};
rxnsToAdd.equations = {'bisabolene_c <=> bisabolene_e'};
model=addRxns(model,rxnsToAdd);
rxnsToAdd.rxns      = {'uc'};
rxnsToAdd.equations = {'bisabolene_e => '};
model=addRxns(model,rxnsToAdd);
rxnsToAdd.rxns      = {'dort'};
rxnsToAdd.equations = {'frdp_m <=> bisabolene_m + ppi_m'};
model=addRxns(model,rxnsToAdd);
rxnsToAdd.rxns      = {'bes'};
rxnsToAdd.equations = {'bisabolene_m <=> bisabolene_c'};
model=addRxns(model,rxnsToAdd);
%model = setParam(model,'ub','Ex_glc_D',10);
model = setParam(model,'obj','uc',1);
FBAsolution = solveLP(model);
fprintf(['Maximum bisabolene production is: ' num2str(FBAsolution.f) '\n'])
printFluxes(model, FBAsolution.x, 10^-7);
biomassRxn = 'BIOMASS';
targetRxn  = 'uc';
iterations = 10;
coefficient= 0.5; % What should be the maximum biochemical yield to be
% simulated. 0.9 refers to 90%.
outputFile = 'FSEOF_bisabolene_iPichia.tab';
FSEOF(model,biomassRxn,targetRxn,iterations,coefficient,outputFile)