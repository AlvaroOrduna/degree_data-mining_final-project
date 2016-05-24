function [ classifier, membership ] = knn_fuzzy_learn( CE, kf )
%KNN_FUZZY_LEARN

    % Get all classes
    classes = unique(CE(:, end));

    % Get all distances between each example from data
    distances = knn_fuzzy_distances(CE, CE, 1);
    
    % Order distances
    [~, distancesOrder] = sort(distances, 2);

    % Initialize membership marix
    membership = zeros(size(CE, 1), size(classes, 1));
    
    for e = 1:size(CE, 1)
        % Classes of kf nearest neighbors
        kClasses = CE(distancesOrder(e, 1:kf), end);

        for i = 1:size(classes, 1)
            membership(e, i) = 0.51 * (CE(e, end) == classes(i)) + 0.49 * sum(kClasses == i) / kf;
        end
    end

    classifier = CE;
end

