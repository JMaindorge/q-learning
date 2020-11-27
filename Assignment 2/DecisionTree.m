function d = DecisionTree()
    %Read data from the file
    D = readtable("data.csv");
    
    %Convert the dianosis column to numerical
    L = Convert(table2array(D(:,1)));
    
    %Remove the diagnosis column
    D = removevars(D, "diagnosis");
    
    %Normalize the variables
    D = normalize(D);
end
