function d = DecisionTree()
    T = readtable('data.csv');
    T = removevars(T,{'id'});
    
    label = T{:,1};
    label = Convert(label);

    variables = T{:,2:end};
    F = fieldnames(T(:,2:end));
    F = F(1:30, 1);
    variables(:,end + 1) = label;
   
    DrawDecisionTree(ID3_New(variables, F), "WCBC");
    
end
