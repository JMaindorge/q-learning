function [ent] = entropy(target_col)
%{
Calculate the entropy of a dataset. The only parameter of this function is 
the target_col parameter which specifies the target column.
%}

elements = unique(target_col); %unique elements
counts = histcounts(target_col, elements); %number of unique elements

for i = 1:counts
    ent = sum(counts(i)/sum(counts))

end

