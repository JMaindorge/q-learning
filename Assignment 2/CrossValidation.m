function result = CrossValidation()
    for i=1:10
        val = randi([1 513]);
        result(i) = DecisionTree(val, val+56);
    end
end

