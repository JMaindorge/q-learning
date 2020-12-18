T = readtable('data.csv'); % Load data

% Using a simple 80/20 split
T = removevars(T,{'id'});

% Get label column and convert to 1 and 0
labels = T{:,1};
labels = Convert(labels);
to_keep = floor(length(labels) * 0.8);
trlabels = labels(1:to_keep,:);

% Get feature columns
trfeatures = T{1:to_keep,2:end};

% Test data
telabels = labels(to_keep+1:end,:); % return remaining lables for test
tefeatures = T{to_keep+1:end,2:end}; % remaining features

% Fit a linear SVM and evaluate performance.
Mdl = fitcsvm(trfeatures,trlabels,'KernelFunction','linear',...
    'BoxConstraint',1);
acc = get_accuracy(Mdl,tefeatures,telabels); % 93.9%

% Combined data with labels and features
trdata = horzcat(trlabels,trfeatures);

% Determine the best hyperparameters for RBF and polynomial.
[c1, q, m1] = inner_fold(trdata,'q'); % c = 0.4 and q = 1
[c2, sig, m2] = inner_fold(trdata,'sigma'); % c = 0.7 and sigma = 29

% Test the model using optimised hyperparameters.
gausvm = fitcsvm(tefeatures,telabels,'KernelFunction','gaussian',...
    'BoxConstraint',c2,'KernelScale',sig);
polysvm = fitcsvm(tefeatures,telabels,'KernelFunction','polynomial',...
    'BoxConstraint',c1,'PolynomialOrder',q);

% Get number of support vectors given by the two models and as a percentage
% of the training data available.
gausvm_SV_num = numel(gausvm.SupportVectors); % 3120 support vectors.
polysvm_SV_num = numel(polysvm.SupportVectors); % 270 support vectors
gausvm_SV_per = (gausvm_SV_num / numel(trfeatures)) * 100; % 22.9%
polysvm_SV_per = (polysvm_SV_num / numel(trfeatures)) * 100; % 1.98%

% Running ten-fold cross-validation on three different SVM's. DO NOT RUN
% UNLESS NEEDED! COULD TAKE UP TO 30 MINUTES TO RUN ALL THREE IF YOU DO.
full_data = horzcat(labels,T{:,2:end}); % Pass full dataset for training.
x_val_rbf_acc = ten_fold_xval(full_data,'sigma'); % 90.7%
x_val_poly_acc = ten_fold_xval(full_data,'q'); % 95.4%
x_val_lin_acc = ten_fold_xval(full_data,'linear'); % 96.2%

% Answering question 3 of task d. Using a subsample of 80% of the data.
x_val_subrbf = ten_fold_xval(trdata,'sigma'); % 90.6%
x_val_subpoly = ten_fold_xval(trdata,'q'); % 96.3%
x_val_sublin = ten_fold_xval(trdata,'linear'); % 95.4%

% Running again but now subsampling training data after 10-fold split.
x_val_trsubrbf = ten_fold_xval(trdata,'sigma'); % 90.4%
x_val_trsubpoly = ten_fold_xval(trdata,'q'); % 95.2%
x_val_trsublin = ten_fold_xval(trdata,'linear'); % 95.4%

% ttest comparisons.
rbf_pred = TTest_Run(full_data,'sigma');
poly_pred = TTest_Run(full_data);
linear_pred = TTest_Run(full_data,'linear');