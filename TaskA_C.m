%Task A

%load in the data
T = readtable('Student_Data.csv');
T=table2array(T);
%Identify the features and labels 
Y=T(:,1);
X=T(:,2:end);

%Train several linear SVMs that each have a different epsilon value
% Also calculate the rmse of each model created
Mdl = fitrsvm(X,Y, 'KernelFunction','linear', 'BoxConstraint',1, "Epsilon", 0.5);
get_rmse(Mdl,X,Y)%rmse of model Mdl is 1.9400
Mdl2 = fitrsvm(X,Y, 'KernelFunction','linear', 'BoxConstraint',1, "Epsilon", 1);
get_rmse(Mdl2,X,Y) %rmse of model Mdl2 is 1.8927
Mdl3 = fitrsvm(X,Y, 'KernelFunction','linear', 'BoxConstraint',1, "Epsilon", 1.5);
get_rmse(Mdl3,X,Y) %rmse of model Mdl3 is 1.8429
Mdl4 = fitrsvm(X,Y, 'KernelFunction','linear', 'BoxConstraint',1, "Epsilon", 1.8);
get_rmse(Mdl4,X,Y) %rmse of model Mdl4 is 1.8452
Mdl5 = fitrsvm(X,Y, 'KernelFunction','linear', 'BoxConstraint',1, "Epsilon", 2);
get_rmse(Mdl5,X,Y) %rmse of model Mdl5 is 1.8452
Mdl6 = fitrsvm(X,Y, 'KernelFunction','linear', 'BoxConstraint',1, "Epsilon", 2.5);
get_rmse(Mdl6,X,Y) %rmse of model Mdl6 is 1.9160

%Task B

%split the data 80/20
split=0.8*length(T);
train_data=T(1:split,:);
Y=train_data(:,1);
X=train_data(:,2:end);

% Determine the best hyperparameters for RBF and polynomial.
[c1, sig] = inner_foldr(train_data,'sigma'); %c1=29 , sig=43
[c2, q]=inner_foldr(train_data,'q');%c2= 2.0000e-04, q=2

% Test the model using optimised hyperparameters.
gausvm = fitrsvm(X,Y,'KernelFunction','gaussian',...
    'BoxConstraint',c1,'KernelScale',sig, 'Epsilon', 2);
polysvm = fitrsvm(X,Y,'KernelFunction','polynomial',...
    'BoxConstraint',c2,'PolynomialOrder',q, 'Epsilon', 2);
get_rmse(gausvm, X, Y)
get_rmse(polysvm, X, Y)

% Get number of support vectors given by the two models and as a percentage
% of the training data available.
gausvm_SV_num = numel(gausvm.SupportVectors); % 1845 support vectors.
gausvm_SV_per = (gausvm_SV_num / numel(X))* 100; % 14.240506329113925
polysvm_SV_num = numel(polysvm.SupportVectors); % 2788 support vectors
polysvm_SV_per = (polysvm_SV_num / numel(X)) * 100; % 21.518987341772153

%Task C

%Perform 10-fold cross-validation for linear, Gaussian, and polynomial kernels. 
ten_fold_xvalr(T,'linear') %rmse is 2.2973
ten_fold_xvalr(T,'sigma') %rmse is 1.8926
ten_fold_xvalr(T,'q') %rmse is 1.8865