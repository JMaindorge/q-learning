%Just run to get tree.
[x,y,h] = regImport();

tree = ID3_reg(x,y,h);

DrawDecisionTree(tree, 'Student Performance (maths)');