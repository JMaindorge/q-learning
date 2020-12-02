function count = DecisionTree()
    T = readtable('data.csv');
    
    %Testing Set
    Test = T(1:80, :);
    Test = removevars(Test,{'id'});
    tLabel = Test{:,1};
    tLabel = Convert(tLabel);
    test_variables = Test{:,2:end};
    test_variables(:,end + 1) = tLabel;
    
    %Training Set
    T = T(81:end, :);
    T = removevars(T,{'id'});
    label = T{:,1};
    label = Convert(label);
    variables = T{:,2:end};
    F = fieldnames(T(:,2:end));
    F = F(1:30, 1);
    variables(:,end + 1) = label;
   
    %Construct Tree with Training Set
    Tree = ID3_New(variables, F);
    
    count = 0;
    for i = 1:size(test_variables, 1)
        count = count + predict(Tree, test_variables(i,:));
    end
    
    count
    
    %DrawDecisionTree(Tree, "WCBC");
    
end

function pred = predict(Tree, Sample)
    root = Tree;
    while isfield(root,'attribute')
         if Sample(1,root.attribute) < root.threshold
             Sample(:, root.attribute) = [];
             root = root.kids{1,1};
         else
             Sample(:, root.attribute) = [];
             if size(root.kids, 2) == 1
                 root = root.kids{1,1};
             else
                 root = root.kids{1,2};
             end
         end
         
    end
    if Sample(1, end) == root.prediction
        pred = 1;
    else
        pred = 0;
    end
end
