function tree = ID3(features, labels, parent_mode, feature_names)
    parent_mode  = mode(labels);
    %cell to hold subtrees
    tree.kids = cell(1,2);
    
    %If all examples are the same, return the same label
    if length(unique(labels)) == 1
        tree.kids = [];
        tree.prediction = unique(labels);
    end
         
    feature_ents = zeros(1,width(features));
    
    for feature = 1:width(features)
        feature_ents(feature) = InfoGain(features, feature, labels);
    end
    
    [col, best_att_num] = max(feature_ents);
    tree.attribute = best_att_num;
    tree.op = feature_names{best_att_num};
    tree.threshold = best_threshold(features(:,best_att_num), labels);
    
    left_tree_features = features(features(:,best_att_num) < tree.threshold, :);
    left_tree_labels = labels(features(:,best_att_num) < tree.threshold);
    left_tree_features(:,best_att_num) = [];
    
    if ~isempty(left_tree_features)
        tree.kids{1} = ID3(left_tree_features, left_tree_labels, parent_mode, feature_names);
    else
        tree.prediction = parent_mode;
    end
    
    right_tree_features = features(features(:,best_att_num) >= tree.threshold, :);
    right_tree_labels = labels(features(:,best_att_num) >= tree.threshold);
    right_tree_features(:,best_att_num) = [];
    
    if ~isempty(right_tree_features)
        tree.kids{2} = ID3(right_tree_features, right_tree_labels, parent_mode, feature_names);
    else
        tree.prediction = parent_mode;
    end 
    
end