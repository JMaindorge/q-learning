function accuracy = DecisionTree(lower, upper)
    T = readtable('data.csv');
    
    %If the upper bounds of the test is at the height of the table, use the
    %lower half for the training
    if upper==height(T)
        Test = T(lower:upper, :);
        T = T(1:lower-1, :);
    
    %If the lower bounds is at the start, use the rest of the table after
    %the testing for the training
    elseif lower == 1
        Test = T(lower:upper, :);
        T = T(upper+1:end, :);
    
    %Else, the bounds of the testing is somewhere inbetween the table.
    %Meaning the training data will need to be disconnected and reconnected
    %afterwards.
    else
        Test = T(lower:upper, :);
        A = T(1:lower-1, :);
        B = T(upper+1:end,:);
        T = [A;B];
    end

    %Testing Set
    Test = removevars(Test,{'id'});
    tLabel = Test{:,1};
    tLabel = Convert(tLabel);
    test_variables = Test{:,2:end};
    test_variables(:,end + 1) = tLabel;
    
    %Training Set
    T = removevars(T,{'id'});
    label = T{:,1};
    label = Convert(label);
    variables = T{:,2:end};
    F = fieldnames(T(:,2:end));
    F = F(1:30, 1);
    variables(:,end + 1) = label;
    
    %Construct Tree with Training Set
    Tree = ID3_New(variables, F);
    
    %Send the testing data to the prediction function to run through
    accuracy = 0;
    for i = 1:size(test_variables, 1)
        accuracy = accuracy + predict(Tree, test_variables(i,:));
    end
    
    accuracy = accuracy / size(test_variables, 1) * 100;
    
    %Draw the decision tree using the training tree. 
    %"WCBC" for Wisconsin Breast Cancer
    %DrawDecisionTree(Tree, "WCBC");
end

% Given a sample of test data, return 1 if it got it right, 
% and 0 if it was wrong
function pred = predict(Tree, Sample)
    root = Tree;
    
    %If the node has the field attribute, then it's not a leaf
    while isfield(root,'attribute')
        %Check if value 
         if Sample(1,root.attribute) < root.threshold
             %Delete the attribute field from the sample we've been given
             Sample(:, root.attribute) = [];
             root = root.kids{1,1};
         else
             %Delete the attribute field from the sample we've been given
             Sample(:, root.attribute) = [];
             
             %Check if the node only has one child, so we don't crash
             if size(root.kids, 2) == 1
                 root = root.kids{1,1};
             else
                 root = root.kids{1,2};
             end
         end
    end
    
    %Reaching here, we can comfortably assume the node is now a leaf node
    %with a prediction
    if Sample(1, end) == root.prediction
        pred = 1;
    else
        pred = 0;
    end
end