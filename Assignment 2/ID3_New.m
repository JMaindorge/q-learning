function tree = ID3_New(Features)
    %Examples(~ismember(Examples.('radius_mean'), value), :) = []
    
    %If all examples are the same, return the same label
    
    tempLabels = Features(:,end);
    if all(tempLabels(:) == tempLabels(1))
        tree.prediction = tempLabels(1);
        return
    end
    
    for i = 1:length(Features(:,end-1))            
        InfoGain(Features, i, Features(:,end))
    end

    %[best_attribute, best_threshold] = InfoGain(Features, Labels);
    %tree.attribute = best_attribute;
    %tree.threshold = best_threshold;
    
    best_attribute = 'radius_mean';
    best_threshold = 17.0;
    tree.op = best_attribute;
    
    LeftSubSet = Features(Features(:,2) < best_threshold, :);
       
    if ~isempty(LeftSubSet)
        LeftSubSet = Features;
        LeftSubSet(:, best_attribute) = [];
            
        tree.kids(1) = ID3_New(LeftSubSet, LeftLabels);
    end
    
    RightSubSet = Features(Features(:,2) >= best_threshold, :);
        
    if ~isempty(RightSubSet)
        RightSubSet = Features;
        RightSubSet(:, best_attribute) = [];
            
        tree.kids(2) = ID3_New(RightSubSet, RightLabels);
    end
end