T = readtable('data.csv');
T = removevars(T,{'Var1'});
D=table2array(T(:,1));
entropy1(D)

