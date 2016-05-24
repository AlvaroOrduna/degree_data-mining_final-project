function [ accuracy ] = knn_fuzzy_accuracy( confusionMat )
%KNN_FUZZY_ACCURACY
    accuracy = sum(diag(confusionMat)) / sum(sum(confusionMat));
end