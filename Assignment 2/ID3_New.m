function tree = ID3_New(Features, Headers, parent_node_mode)
    tree.kids = {};
    
    
    %If all examples are the same, return the same label
    tempLabels = Features(:,end);
    if ~isempty(tempLabels) && all(tempLabels(:) == tempLabels(1))
        tree.kids = [];
        tree.op = "";
        tree.prediction = tempLabels(1);
        return
    end
    
    if size(Features,2) <= 1
        tree.kids = [];
        tree.op = "";
        tree.prediction = parent_node_mode;
        return
    end
    
    parent_node_mode = mode(Features(:,end));
    
    x = 0;
    xi = 0;
    for i = 1:size(Features, 2) - 1
        xb = InfoGain(Features, i, Features(:,end));
        if xb > x
            xi = i;
            x = xb;
        end
    end
    
    best_attri = xi;
    tree.attribute = best_attri;
    best_thres = best_threshold(Features(:, best_attri),Features(:, end));
    tree.threshold = best_thres;
   
    tree.op = Headers(best_attri);
    
    Headers(best_attri) = [];
    
    
    LeftSubSet = Features(Features(:,best_attri) < best_thres, :);
        
    if ~isempty(LeftSubSet)
        LeftSubSet(:, best_attri) = [];
        
        
        
        tree.kids{1} = ID3_New(LeftSubSet, Headers, parent_node_mode);
    end
    
    RightSubSet = Features(Features(:,best_attri) >= best_thres, :);
    
    if ~isempty(RightSubSet)
        RightSubSet(:, best_attri) = [];
                    
        if isempty(tree.kids)
            tree.kids{1} = ID3_New(RightSubSet, Headers, parent_node_mode);
        else
            tree.kids{2} = ID3_New(RightSubSet, Headers, parent_node_mode);
        end
    end
end