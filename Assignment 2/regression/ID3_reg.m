function tree = ID3_reg(Features, labels, Header, parent_node_mode)
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
    
    if best_attri == 0
        tree.kids = [];
        tree.op = '';
        tree.prediction = parent_node_mode;
        return
    end
    
    tree.attribute = best_attri;
    best_thres = 0.5;
    tree.threshold = best_thres;
   
    tree.op = Header{best_attri};
    
    Header(best_attri) = [];
    
    LeftSubSet = Features(Features(:,best_attri) < best_thres, :);
    LeftSubSet_labels = labels(Features(:,best_attri) < tree.threshold); 
    
    if ~isempty(LeftSubSet)
        LeftSubSet(:, best_attri) = [];
        
        tree.kids{1} = ID3_reg(LeftSubSet, LeftSubSet_labels, Header, parent_node_mode);
    end
    
    RightSubSet = Features(Features(:,best_attri) >= best_thres, :);
    RightSubSet_labels = labels(Features(:,best_attri) >= tree.threshold);
    
    if ~isempty(RightSubSet)
        RightSubSet(:, best_attri) = [];
                    
        if isempty(tree.kids)
            tree.kids{1} = ID3_reg(RightSubSet, RightSubSet_labels, Header, parent_node_mode);
        else
            tree.kids{2} = ID3_reg(RightSubSet, RightSubSet_labels, Header, parent_node_mode);
        end
    end
end