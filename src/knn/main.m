% Define algorithm paramaters
if exist('k', 'var') == 0
    k = 15;
end

% Learn and classify data
classifier = CE;

[confusionMatTr, classTr] = knn_classify(classifier, CE, k, 1);
accTr = knn_accuracy(confusionMatTr);

if exist('inGenetic', 'var') == 0 || ~inGenetic
    [confusionMatTst, classTst] = knn_classify(classifier, CT, k, 0);
    accTst = knn_accuracy(confusionMatTst);
    fprintf('Con k = %d: accTr = %f y accTst = %f\n', k, accTr, accTst);
end