%Create Tree using predefined data and testing size.
[Fields, Training, Testing] = Split(readtable("data.csv"),100, 200);
Tree = DecisionTree(Fields, Training);
[TruePos, AllPos, RelPos, FPos, TrueNeg, AllNeg, RelNeg, FNeg, Acc] = Predict(Tree, Testing);

%Use cross validation on chunks of data.
%10 for 10 fold, 569 for the height of the dataset.
CrossValidation(10, 569);


