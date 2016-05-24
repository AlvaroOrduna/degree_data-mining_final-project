function [ confusionMat, dataClasses ] = knn_classify( classifier, data, k, isTrain )
%KNN_CLASSIFY

    % Get all classes
    classes = unique(classifier(:, end));

    % Get all distances between each example from data
    distances = knn_distances(classifier, data, isTrain);

    % Order distances
    [~, distancesOrder] = sort(distances, 2);

    % Vector where we put each example class
    dataClasses = zeros(size(data, 1), 1);

    % Confusion matrix
    confusionMat = zeros(size(classes, 1));

    for e = 1:size(distances, 1)
        % Weights vector for each class
        weights = zeros(size(classes));

        % Classes of k nearest neighbors
        kClasses = classifier(distancesOrder(e, 1:k), end);

        % Weights of k nearest neighbors
        kWeights = (1 ./ distances(e, distancesOrder(e, 1:k)) .^ 2);

        % For each neighbor, acumulate the weight
        for i = 1:k
            weights(kClasses(i)) = weights(kClasses(i)) + kWeights(i);
        end

        % Get the index of the heaviest class
        [~, i] = max(weights);

        % Get the heaviest class and add
        dataClasses(e) = classes(i);

        % Modify confusion matrix
        a = find(classes == data(e, end), 1);
        b = find(classes == dataClasses(e), 1);
        confusionMat(a, b) = confusionMat(a, b) + 1;
    end
end

