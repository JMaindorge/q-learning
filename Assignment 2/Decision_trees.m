T = readtable('data.csv');
T = removevars(T,{'Var1'});

first_col = T{:,1};
first_col = Convert(first_col);

variables = T{:,2:end};
variables = normalize(variables);

