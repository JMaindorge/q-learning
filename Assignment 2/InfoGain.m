function [information_gain] = InfoGain(data, split_feature_num, label)
% Calculate the entropy of the whole dataset
total_entropy = entropy(label);
% Get the unique values and indidcies of those values for given feature
% column
feature_col = data(:,split_feature_num);
values = unique(feature_col);
% Count the number of times a unique value appears.
counts = zeros(1,length(feature_col));
for j = 1:length(values)
    counts(j) = length(find(feature_col == values(j)));
end

weighted_entropy = zeros(1,length(feature_col));
for i = 1:length(values)
    %Find the corresponding label values for each unique value from the
    %feature_col.
    weighted_entropy(i) = (counts(i)/sum(counts)) * entropy(label(feature_col == values(i)));
    
end
%Take the sum of the weighted_entropy array.
weighted_entropy = sum(weighted_entropy);
information_gain = total_entropy - weighted_entropy;
end



