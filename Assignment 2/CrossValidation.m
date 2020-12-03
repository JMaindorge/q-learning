function result = CrossValidation(chunks, size)
    sampleSize = floor(size / chunks);
    %result = null(1,chunks);
    for i=1:chunks
        %val = randi([1 513]);
        %result(i) = DecisionTree(val, val+56);
        %
        if i==1
            [fields, training, testing] = Split(readtable("data.csv"), 1, sampleSize);
        else
            [fields, training, testing] = Split(readtable("data.csv"), sampleSize*(i-1), sampleSize*i);
        end
        
        tree = DecisionTree(fields,training);
        [TruePos,AllPos,RelPos,FP,TrueNeg,AllNeg,RevNeg,FN,Acc] = Predict(tree, testing);
        
        i
        TruePos
        AllPos
        RelPos
        FP
        TrueNeg
        AllNeg
        RevNeg
        FN
        Acc
    end
end

