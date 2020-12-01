function [information_gain] = InfoGain(data, split_feature_num, label)

total_entropy = entropy(label);

values = unique(data(:,split_feature_num));
count = histcounts(data(:,split_feature_num), values);

for i = 1:length(values)
    
    weighted_entropy = sum((count(i)/sum(count)) * entropy(data(:,split_feature_num)))

end

