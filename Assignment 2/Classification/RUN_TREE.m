%Create Tree using predefined data and testing size.
[Fields, Training, Testing] = Split(readtable("data.csv"),100, 200);
Tree = DecisionTree(Fields, Training);
[TruePos, AllPos, RelPos, FPos, TrueNeg, AllNeg, RelNeg, FNeg, Acc] = Predict(Tree, Testing);