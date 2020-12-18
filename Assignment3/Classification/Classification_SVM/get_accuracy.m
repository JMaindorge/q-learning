function accuracy = get_accuracy(Mdl,test_feat,test_label)
% Function to get the accuracy given a model and test features.

% predict labels
[predicted, ~] = predict(Mdl,test_feat);

% Create confusion matrix
confu_mat = confusionmat(test_label,predicted);

% Calculate accuracy from confusion matrix
accuracy = trace(confu_mat) / sum(confu_mat,'all');
end

