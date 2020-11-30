function tree = ID3(data, originalData, features, target_attribute_name, parent_node_class)
    tree.a = {'op', 'kids', 'prediction', 'attribute', 'threshold'};
    tree.op = target_attribute_name;
    
    if isempty(features) == 0
        tree = parent_node_class;
        return
    else
        for c = 1 : length(features)
            item_values(c) = InfoGain(data, feature, target_attribute_name);
        end
        best_feature_index = max(item_values, [], 'all');
        best_feature = features(best_feature_index);
        
        features(:, best_feature_index);
        
        a = unique(data(best_feature));
        
        for v = 1 : length(a)
            value = a(v);
            %subdata = data.
            
            subtree = ID3(sub_data, originalData, features, target_attribute_name, tree);
            tree.kids(0) = sub_tree;
        end
    end
end