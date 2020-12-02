function d = DecisionTree()
    T = readtable('data.csv');
    T = removevars(T,{'id'});

    label = T{:,1};
    label = Convert(label);

    variables = T{:,2:end};
    variables(:,end + 1) = label;

    DrawDecisionTree(ID3_New(variables), "WCBC");
end
