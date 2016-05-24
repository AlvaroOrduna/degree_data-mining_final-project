% Define algorithm paramaters
k = 3;

% Learn and classify data
classifier = CE;

[confusionMatTr, classTr] = knn_classify(classifier, CE, k, 1);
[confusionMatTst, classTst] = knn_classify(classifier, CT, k, 0);

accTr = knn_accuracy(confusionMatTr);
accTst = knn_accuracy(confusionMatTst);

fprintf('Con k = %d: accTr = %f y accTst = %f\n', k, accTr, accTst);