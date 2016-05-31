% Define dataset object
dataset.training = CE;
dataset.test = CT;
dataset.numClasses = nClases;

% Define KNN parameters
if exist('k', 'var') == 0
    k = 3;
end
voteType = 'pond';
distType = 'Euclidea';
numTrain = size(CE, 1);

% Execute KNN for train dataset
numTest = size(CE, 1);
classTr = knn_test(dataset,numTest,numTrain,distType,k,voteType, 1);
accTr = sum(classTr' == CE(:,end))/numTest;

% Execute KNN for test dataset
if exist('inGenetic', 'var') == 0 || ~inGenetic
    numTest = size(CT, 1);
    classTst = knn_test(dataset,numTest,numTrain,distType,k,voteType, 0);
    accTst = sum(classTst' == CT(:,end))/numTest;
    fprintf('Con k = %d: accTr = %f y accTst = %f\n', k, accTr, accTst);
end