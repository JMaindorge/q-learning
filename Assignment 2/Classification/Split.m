function [Fields, Training, Testing] = Split(T, lower, upper)
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
    
    Fields = F;
    Training = variables;
    Testing = test_variables;
end
