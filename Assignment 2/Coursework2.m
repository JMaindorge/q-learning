T = readtable('data.csv');
T = removevars(T,{'Var1'});
features=removevars(T,{'Var2'});
labels=table2array(T(:,1));
[attribute,threshold]=best_attribute(features,labels)