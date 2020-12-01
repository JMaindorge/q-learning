function tree = ID3(data, originalData, parent_node_class)
    %Create a node
    tree.op = Testing_Attribute;
    tree.kids = cell(1,2);
    tree.prediction = []; %Array holding 0 or 1 for leaf node. [] for internal.
    tree.attribute = []; %The value of the attribute being tested
    tree.threshold = []; %The threshold value determined to split.
    
    label = data(:,end); %label column from data
    features = data(:,end - 1); %features in our data
    
    %If all examples are the same, return the same label
    if length(unique(label)) == 1
        tree.prediction = unique(label);
    end
    
    %If predicting examples are empty, return the most common value from
    %the attribute
    if isempty(data)
        tree.prediction = mode(originalData(:,end));
        return
    end
    
    if isempty(features)
        tree.prediction = parent_node_class;
    end
        
    parent_node_class = mode(data(:,end));
    
    for feature = 1:length(features)
        
    end
    
    %A ← The Attribute that best classifies examples.
    %A = InfoGain() Put the function call here
    
    %Decision Tree attribute for Root = A.
    tree.op = A;
    
    a = unique(Examples(:, best_feature));
    
    %For each possible value, vi, of A,
    for v = 1 : length(a)
        value = a(v);
        
        %Let Examples(vi) be the subset of examples that have the value vi for A
        for b = 1 : Examples(best_feature)
            if value == Examples(b, best_feature)
                sub_data(end+1) = Examples(b, best_feature);
            end
        end
        
        % If Examples(vi) is empty Then below this new 
        % branch add a leaf node with label = most common target value in the examples
        if isempty(sub_data)
            
        
        %Else below this new branch add the subtree ID3 (Examples(vi), Target_Attribute, Attributes – {A})
        else
            
        end
    end
end