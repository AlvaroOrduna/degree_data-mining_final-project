function [ confusionMat, dataClasses ] = knn_fuzzy_classify( classifier, membership, data, k, isTrain )
%KNN_FUZZY_CLASSIFY

    % Get all classes
    classes = unique(classifier(:, end));

    % Get all distances between each example from data
    distances = knn_fuzzy_distances(classifier, data, isTrain);

    % Order distances
    [~, distancesOrder] = sort(distances, 2);

    % Vector where we put each example class
    dataClasses = zeros(size(data, 1), 1);

    % Confusion matrix
    confusionMat = zeros(size(classes, 1));

    for e = 1:size(distances, 1)

        % Pertenencias de los k más cercanos al ejemplo e
        kMembership = membership(distancesOrder(e, 1:k), :);

        % Para cada elemento cercano, añadir al peso acumulado de su
        % clase
        weights = (1 ./ distances(e, distancesOrder(e, 1:k)) .^ 2) * kMembership;

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

