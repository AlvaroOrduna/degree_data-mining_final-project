%% Define main script
algorithm = 'knn_fuzzy';
initScript = strcat(algorithm, '\main.m');

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

%% Save result
csvwrite(strcat('../results/result-', algorithm, '.csv'), [(1:size(classTst, 1))' classTst]);