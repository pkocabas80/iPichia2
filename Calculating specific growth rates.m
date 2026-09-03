% Validation with iPichia2 GEM
model = importExcelModel('iPichia2.xlsx');

% Validation with iPichia GEM
%model = importModel('iPichia.xml');
%printModelStats(model,true,true);

%model = setParam(model,'lb','Ex_glyc', -2.41); %glycerol uptake rate
model = setParam(model,'lb','Ex_meoh',-7.82);%methanol uptake rate

%model = setParam(model,'lb','Ex_glc_D', -1.02); %glucose uptake rate
model = setParam(model,'lb','Ex_o2', -8.22); %oxygen uptake rate

model = setParam(model,'obj',{'BIOMASS'},1);
setRavenSolver('gurobi'); 
sol=solveLP(model);
%printFluxes(model, sol.x, true, 10^-7);
%Get the indexes of these reactions
I=getIndexes(model,{'BIOMASS'},'rxns');
GROWTH_RATE=sol.x(I)

