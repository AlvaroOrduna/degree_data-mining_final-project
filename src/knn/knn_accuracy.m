function [ accuracy ] = knn_accuracy( confusionMat )
%KNN_ACCURACY
    accuracy = sum(diag(confusionMat)) / sum(sum(confusionMat));
end