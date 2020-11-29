function [ent] = entropy1(target_col)
counts=[];
ent_matrix=[];
elements = unique(target_col); %unique elements
    for i = 1:length(elements)
        counts(i)=sum(count(target_col, elements(i)));
    end
    for i = 1:length(elements)
        ent_matrix(i) = -counts(i)/sum(counts)*log2(counts(i)/sum(counts));
    end
ent=sum(ent_matrix);
end 