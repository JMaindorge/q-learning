function tree = DecisionTree(fields, data)
    %Construct Tree with Training Set
    tree = ID3_New(data, fields);
    
    %Draw the decision tree using the training tree. 
    %"WCBC" for Wisconsin Breast Cancer
    DrawDecisionTree(tree, "WCBC");
end

