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
Mdl4 = fitrsvm(X,Y, 'KernelFunction','linear', 'BoxConstraint',1, "Epsilon", 2);
get_rmse(Mdl4,X,Y) %rmse of model Mdl4 is 1.8452
Mdl5 = fitrsvm(X,Y, 'KernelFunction','linear', 'BoxConstraint',1, "Epsilon", 2.5);
get_rmse(Mdl5,X,Y) %rmse of model Mdl5 is 1.9160

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

% Get number of support vectors given by the two models and as a percentage
% of the training data available.
gausvm_SV_num = numel(gausvm.SupportVectors); % 1845 support vectors.
gausvm_SV_per = (gausvm_SV_num / numel(X))* 100; % 14.240506329113925
polysvm_SV_num = numel(polysvm.SupportVectors); % 2788 support vectors
polysvm_SV_per = (polysvm_SV_num / numel(X)) * 100; % 21.518987341772153

%Task C

%Perform 10-fold cross-validation for linear, Gaussian, and polynomial kernels. 
ten_fold_xvalr(T,'linear') %rmse is 1.9446
ten_fold_xvalr(T,'sigma') %rmse is 1.8926
ten_fold_xvalr(T,'q') %rmse is 1.8865

%Import predicted results of ANN regresion
Ann_pred=table2array(readtable('Ann_Pred_Reg'));
Y=T(:,1);
X=T(:,2:end)

split=0.8*length(T)
train_X=X((length(T)-split+1):end,:);
test_X=X(1:(length(T)-split),:);
train_Y=Y((length(T)-split+1):end,:);
test_Y=Y(1:(length(T)-split),:);

%find the average parameters used in cross validation
[avg_acc,avg_c,avg_kp] = ten_fold_xvalr(T,'sigma')
%Train the RBF SVM
Mdl_gau = fitrsvm(train_X,train_Y,'KernelFunction','gaussian',...,
    'BoxConstraint',avg_c,'KernelScale',avg_kp, 'Epsilon', 2);
%Obtain predicted results of trained RBF SVM
pred_gau=predict(Mdl_gau,test_X);


%find the average parameters used in cross validation
[avg_acc,avg_c,avg_kp] = ten_fold_xvalr(T,'q')
%Train the Polynomial SVM
Mdl_poly= fitrsvm(train_X,train_Y,'KernelFunction',...
            'polynomial','BoxConstraint',avg_c,'PolynomialOrder',avg_kp,...,
            'Epsilon', 2);
%Obtain predicted results of trained Polynomial SVM
pred_poly=predict(Mdl_poly,test_X);


%find the average parameters used in cross validation
[avg_acc,avg_c,~] = ten_fold_xvalr(T,'linear')
%Train the Linear SVM
Mdl_linear= fitrsvm(train_X,train_Y,'KernelFunction',...
            'linear','BoxConstraint',avg_c,'Epsilon', 2);
%Obtain predicted results of trained Linear SVM
pred_linear=predict(Mdl_linear,test_X);

%find the p values of each pair of results 
[~,p1]=ttest2(pred_gau,Ann_pred)% p value is 0.1079
[~,p2]=ttest2(pred_poly,Ann_pred)% p value is 0.1085
[~,p3]=ttest2(pred_linear,Ann_pred)%p value is 0.0610
[~,p4]=ttest2(pred_linear,pred_gau)%p value is 0.7971
[~,p5]=ttest2(pred_linear,pred_poly)%p value is 0.8038
[~,p6]=ttest2(pred_gau,pred_poly)% p value is 0.9941


