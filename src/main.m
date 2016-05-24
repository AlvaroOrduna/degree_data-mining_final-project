%% Define main script
initScript = 'knn\main.m';

%% Load data
fTrain = '../data/cleveland_tra.dat';
fTest = '../data/cleveland_tst.dat';
[numAtr, nClases, infoAtr, CE, CT, ejClase] = lecturaDatos(fTrain, fTest);

%% Normalize data
minimum = infoAtr(:, 1)';
maximum = infoAtr(:, 2)';
CE(:, 1:end - 1) = bsxfun(@rdivide, bsxfun(@minus, CE(:, 1:end - 1), minimum), (maximum - minimum));
CT(:, 1:end - 1) = bsxfun(@rdivide, bsxfun(@minus, CT(:, 1:end - 1), minimum), (maximum - minimum));

%% Run main script
run(initScript);