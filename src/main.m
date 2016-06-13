%% Define main script
algorithm = 'knn_genetic';
initScript = strcat(algorithm, '\main.m');

%% Load data
fTrain = '../data/cleveland_tra.dat';
fTest = '../data/cleveland_tst.dat';
[numAtr, nClases, infoAtr, CE, CT, ejClase] = lecturaDatos(fTrain, fTest);

%% Normalize data
norm = 0;
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
    fileName = sprintf('../results/result-%5.4f-%s-norm.csv', accTst, algorithm);
else
    fileName = sprintf('../results/result-%5.4f-%s.csv', accTst, algorithm);
end
csvwrite(fileName, [(1:size(classTst, 1))' classTst - 1]);