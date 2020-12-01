function [information_gain] = InfoGain(data, split_feature_num, label)
% Calculate the entropy of the whole dataset
total_entropy = entropy(label);
% Get the unique values and indidcies of those values for given feature
% column
feature_col = data(:,split_feature_num);
values = unique(feature_col,'stable');
% Count the number of times a unique value appears.
count = histcounts(feature_col, values);
% For every value
for i = 1:length(values)
    %Find the index of where this uniue value appears in the feature_col.
    labels_for_unique = find(feature_col == values(i));
    weighted_entropy = (count(i)/sum(count)) * entropy(labels(labels_for_unique));
    %Then use the indicies to find the corresponding label values and
    %calulate the weighted entropy.
end
%Take the sum of the weighted_entropy array.
weighted_entropy = sum(weighted_entropy);
information_gain = total_entropy - weighted_entropy;



