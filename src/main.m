%% Define main script
initScript = '';

%% Load data
fTrain = '../data/cleveland_tra.dat';
fTest = '../data/cleveland_tst.dat';
[numAtr, nClases, infoAtr, ejemplosTr, ejemplosTst, ejClase] = ...
    lecturaDatos(fTrain, fTest);

%% Run main script
run(initScript);