% Define algorithm paramaters
k = 3;
kf = 3;

% Learn and classify data
[classifier, membership] = knn_fuzzy_learn(CE, kf);

[confusionMatTr, classTr] = knn_fuzzy_classify(classifier, membership, CE, k, 1);
[confusionMatTst, classTst] = knn_fuzzy_classify(classifier, membership, CT, k, 0);

accTr = knn_fuzzy_accuracy(confusionMatTr);
accTst = knn_fuzzy_accuracy(confusionMatTst);

fprintf('Con k = %d y kf = %d: accTr = %f y accTst = %f\n', k, kf, accTr, accTst);