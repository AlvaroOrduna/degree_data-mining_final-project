%% Define main script
algorithm = 'genetic_2';
initScript = strcat(algorithm, '\main.m');

%% Load data
fTrain = '../data/cleveland_tra.dat';
fTest = '../data/cleveland_tst.dat';
[numAtr, nClases, infoAtr, CE, CT, ejClase] = lecturaDatos(fTrain, fTest);

%% Normalize data
norm = 1;
if norm
    minimum = infoAtr(:, 1)';
    maximum = infoAtr(:, 2)';
    CE(:, 1:end - 1) = bsxfun(@rdivide, bsxfun(@minus, CE(:, 1:end - 1), minimum), (maximum - minimum));
    CT(:, 1:end - 1) = bsxfun(@rdivide, bsxfun(@minus, CT(:, 1:end - 1), minimum), (maximum - minimum));
end

%% Run main script
run(initScript);

%% Save result
if norm
    csvwrite(strcat('../results/result-', algorithm, '-norm-', num2str(accTst), '.csv'), [(1:size(classTst, 1))' classTst - 1]);
else
    csvwrite(strcat('../results/result-', algorithm, '-', num2str(accTst), '.csv'), [(1:size(classTst, 1))' classTst - 1]);
end