function [ distances ] = knn_fuzzy_distances( classifier, data, isTrain )
%KNN_FUZZY_DISTANCES

    nc = size(classifier, 1);
    [ne, n] = size(data);

    distances = zeros(ne, nc);
    for e = 1:ne
        aux = bsxfun(@minus, classifier(:, 1:(n - 1)), data(e, 1:(n - 1)));
        distances(e, :) = sqrt(sum(aux.^2, 2))';
    end

    if isTrain
        distances = distances + diag(diag(ones(ne, nc) * Inf));
    end
end
