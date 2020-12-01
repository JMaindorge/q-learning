function tree = ID3(data, originalData, feature_num, parent_node_mode)
    %Create a node
    tree.op = Testing_Attribute;
    tree.kids = cell(1,2);
    tree.prediction = []; %Array holding 0 or 1 for leaf node. [] for internal.
    tree.attribute = []; %The value of the attribute being tested
    tree.threshold = []; %The threshold value determined to split.
    
    label = data(:,end); %label column from data
%     features = data(:,end - 1); %features in our data
    
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
        tree.prediction = parent_node_mode;
    end
        
    parent_node_mode = mode(data(:,end));
    
    
    
end