% Define algorithm paramaters
if exist('k', 'var') == 0 || exist('kf', 'var') == 0
    k = 3;
    kf = 3;
end

% Learn and classify data
[classifier, membership] = knn_fuzzy_learn(CE, kf);

[confusionMatTr, classTr] = knn_fuzzy_classify(classifier, membership, CE, k, 1);
accTr = knn_fuzzy_accuracy(confusionMatTr);
if exist('inGenetic', 'var') == 0 || ~inGenetic
    [confusionMatTst, classTst] = knn_fuzzy_classify(classifier, membership, CT, k, 0);
    accTst = knn_fuzzy_accuracy(confusionMatTst);
	fprintf('Con k = %d y kf = %d: accTr = %f y accTst = %f\n', k, kf, accTr, accTst);
end
