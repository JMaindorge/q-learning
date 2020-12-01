function tree = ID3_New(Features, Labels)
    %Examples(~ismember(Examples.('radius_mean'), value), :) = []
    
    %If all examples are the same, return the same label
    tempLabels = Convert(table2array(Labels(:,2)));
    if all(tempLabels(:) == tempLabels(1))
        tree.prediction = tempLabels(1);
        return
    end
    
    %a = InfoGain(Features, 31, Convert(table2array(Labels(:, 2))))

    %[best_attribute, best_threshold] = InfoGain(Features, Labels);
    %tree.attribute = best_attribute;
    %tree.threshold = best_threshold;
    
    best_attribute = 'radius_mean';
    
    tree.op = best_attribute;
    
    LeftSubSet = Features.(best_attribute) < 17.0;
    LeftSubSet = Features(LeftSubSet, :);
       
    if ~isempty(LeftSubSet)
        LeftSubSet = removevars(LeftSubSet, best_attribute);
        LeftLabelsVi = Labels(ismember(LeftSubSet.('id'), Features.('id')), :);
            
        tree.kids(1) = ID3_New(LeftSubSet, LeftLabelsVi);
    end
    
    RightSubSet = Features.(best_attribute) >= 17.0;
    RightSubSet = Features(RightSubSet, :);
        
    if ~isempty(RightSubSet)
        RightSubSet = removevars(RightSubSet, best_attribute);
        RightLabelsVi = Labels(ismember(RightSubSet.('id'), Features.('id')), :);
            
        tree.kids(2) = ID3_New(RightSubSet, RightLabelsVi);
    end
end