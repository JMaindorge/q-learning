function [ent] = entropy(target_col)

values = unique(target_col);
% Count the number of times a unique value appears.
counts = zeros(1,2);
for j = 1:length(values)
    counts(j) = length(find(target_col == values(j)));
end

ent = zeros(1,2);
for i = 1:length(values)
    
    ent(i) = -counts(i)/sum(counts) * log2(counts(i)/sum(counts));
    
end
ent = sum(ent);
end