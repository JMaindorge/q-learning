function result = CrossValidation(chunks, size)
    sampleSize = floor(size / chunks);
    for i=1:chunks
        %val = randi([1 513]);
        %result(i) = DecisionTree(val, val+56);
        result = zeros(1,chunks);
        if i==1
            result(i) = DecisionTree(1,sampleSize);
        else
            result(i) = DecisionTree(sampleSize*(i-1),sampleSize*i);
        end
    end
    
end

