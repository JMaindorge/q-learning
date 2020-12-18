function avg_acc = ten_fold_xval(data,kernel_param)
% Function that takes data with labels and a string argument to determine
% which type of SVM is trained and performs 10-fold cross-validation on
% given data.

% Shuffle rows of data provided
data = data(randperm(size(data,1)),:);

% Split data into 10 parts and store in a cell array. Since the data
% doesn't split evenly we will have 9 arrays of the same size and the 10th
% with the remaining rows.
nine_arr = floor(size(data,1)/10)*ones(9,1);
remaining_elem = size(data,1) - nine_arr(1)*9;
all_arrs = vertcat(nine_arr,remaining_elem);
split_data = mat2cell(data,all_arrs,31);

% Store model accuracy
accuracies = zeros(1,10);

for i = 0:9
    test = split_data{end-i}; % one array to be used for test.
%   Whatever remains that isn't the test set is the training set.
    if i == 0
        training = cell2mat(split_data(1:end-1)); 
    else
        training = vertcat(cell2mat(split_data(1:end-i-1)),...
            cell2mat(split_data(end-i+1:end)));
    end
%   Tune hyperparameters and evaluate model on outer loop.
    [c, kp, ~] = inner_fold(training,kernel_param);
%   Check to see what model type we are dealing with.
    if strcmp(kernel_param,'linear')
        Mdl = fitcsvm(training(:,2:end),training(:,1),'KernelFunction',...
            'linear','BoxConstraint',c);
    elseif strcmp(kernel_param,'sigma')
        Mdl = fitcsvm(training(:,2:end),training(:,1),'KernelFunction',...
            'gaussian','BoxConstraint',c,'KernelScale',kp);
    else
        Mdl = fitcsvm(training(:,2:end),training(:,1),'KernelFunction',...
            'polynomial','BoxConstraint',c,'PolynomialOrder',kp);
    end
%   Evaluate on test data for outer loop and store.
    accuracies(i+1) = get_accuracy(Mdl,test(:,2:end),test(:,1));
    
end

% Output average model accuracy for the 10-fold cross-validation.
avg_acc = mean(accuracies);

end

