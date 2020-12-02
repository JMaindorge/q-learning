function [attribute,threshold]= best_attribute(feature,labels)
    all_threshold=[];
    
    for i=1:size(feature, 2)
        all_threshold(i)=best_threshold(feature(:,i),labels);
    end
    
    [B, I]=max(all_threshold);
    attribute=I;
    [info_gain,threshold]= best_threshold(feature(:,I),labels);
end