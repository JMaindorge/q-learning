function tree = ID3_New(Features, labels, parent_node_mode)
    tree.kids = {};
    
    %If all examples are the same, return the same label
    if ~isempty(labels) && all(labels(:) == labels(1))
        tree.kids = [];
        tree.op = "";
        tree.prediction = labels(1);
        return
    end
    
    if size(Features,2) <= 1
        tree.kids = [];
        tree.op = "";
        tree.prediction = parent_node_mode;
        return
    end
    
    parent_node_mode = mode(labels);
    
    best_attri = computeOptimalSplitRegression(num2cell(Features), num2cell(labels));
    
    tree.attribute = best_attri;
    best_thres = best_threshold(Features(:, best_attri), labels);
    tree.threshold = best_thres;
   
    tree.op = "test";
%     
%     Headers(best_attri) = [];
    
    
    LeftSubSet = Features(Features(:,best_attri) < best_thres, :);
        
    if ~isempty(LeftSubSet)
        LeftSubSet(:, best_attri) = [];
        
        tree.kids{1} = ID3_New(LeftSubSet, labels, parent_node_mode);
    end
    
    RightSubSet = Features(Features(:,best_attri) >= best_thres, :);
    
    if ~isempty(RightSubSet)
        RightSubSet(:, best_attri) = [];
                    
        if isempty(tree.kids)
            tree.kids{1} = ID3_New(RightSubSet, labels, parent_node_mode);
        else
            tree.kids{2} = ID3_New(RightSubSet, labels, parent_node_mode);
        end
    end
end