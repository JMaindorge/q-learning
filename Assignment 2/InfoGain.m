function [information_gain] = InfoGain(data, split_feature_num, label)

total_entropy = entropy(label);

[values, index] = unique(data(:,split_feature_num));
count = histcounts(data(:,split_feature_num), values);

for i = 1:length(values)
    
    weighted_entropy = sum((count(i)/sum(count)) * entropy(label(index)));
    
end

information_gain = total_entropy - weighted_entropy;



