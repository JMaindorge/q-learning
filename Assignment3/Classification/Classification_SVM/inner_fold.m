function [C, k_param, mat] = inner_fold(train_data,kernel_param)
% Function to determine the best model based on inner fold testing.
% Train data to contain labels and features
% Split data in half, where one half is train and other half is validation.
% This to make sure we get as close to the data n*10 > n features ratio.
Split = floor(length(train_data)/2);

% Set values to test for hyperparameters.
c_values = 0.1:0.1:2;
cp_values = 0.1:0.1:0.5; % c values for polynomial, otherwise too slow.
sigma_param_values = 1:0.5:30;
q_param_values = 1:2;

% Define the two differnt split features and labels for training.
split_left_feat = train_data(1:Split,2:end);
split_left_label = train_data(1:Split,1);
split_right_feat = train_data(Split+1:end,2:end);
split_right_label = train_data(Split+1:end,1);

% Tune hyperparameters for RBF
if strcmp(kernel_param,'sigma')
    % Create a iterations-by-3 matrix to store the values for the resulting
    % accuracy of the model and the corresponding hyper parameters.
    accuracies =  zeros(length(c_values) * length(sigma_param_values)*2, 3);
    counter = 0;

    for i = c_values

        for j = sigma_param_values
            counter = counter + 1;
            svmmdl = fitcsvm(split_left_feat,split_left_label,...
                'KernelFunction','gaussian','BoxConstraint',i,...
                'KernelScale',j);
%           First column is accuracy
            accuracies(counter,1) = get_accuracy(svmmdl,split_right_feat,...
                split_right_label);
%           Second column is C value
            accuracies(counter,2) = i;
%           Third column is kernerl parameter
            accuracies(counter,3) = j;
            
            counter = counter + 1;
            
%           Swap training data and validation data
            svmmdl = fitcsvm(split_right_feat,split_right_label,...
                'KernelFunction','gaussian','BoxConstraint',i,...
                'KernelScale',j);
            accuracies(counter,1) = get_accuracy(svmmdl,split_left_feat,...
                split_left_label);
            accuracies(counter,2) = i;
            accuracies(counter,3) = j;
            
        end
        
    end
  
end
% Tune hyperparameters for Polynomial kernel.
if strcmp(kernel_param,'q')
    accuracies =  zeros(length(cp_values) * length(q_param_values)*2, 3);
    counter = 0;

    for i = cp_values
        
        for j = q_param_values
            counter = counter + 1;
            svmmdl = fitcsvm(split_left_feat,split_left_label,...
                'KernelFunction','polynomial','BoxConstraint',i,...
                'PolynomialOrder',j);
            accuracies(counter,1) = get_accuracy(svmmdl,split_right_feat,...
                split_right_label);
            accuracies(counter,2) = i;
            accuracies(counter,3) = j;
            
            counter = counter + 1;
            
            svmmdl = fitcsvm(split_right_feat,split_right_label,...
                'KernelFunction','polynomial','BoxConstraint',i,...
                'PolynomialOrder',j);
            accuracies(counter,1) = get_accuracy(svmmdl,split_left_feat,...
                split_left_label);
            accuracies(counter,2) = i;
            accuracies(counter,3) = j;
            
        end
        
    end
    
end
% For the linear model only C needs to tuned.
if strcmp(kernel_param,'linear')
    accuracies =  zeros(length(c_values), 2);
    counter = 0;
    
    for i = c_values
        counter = counter + 1;
        svmmdl = fitcsvm(split_left_feat,split_left_label,...
            'KernelFunction','linear','BoxConstraint',i);
        accuracies(counter,1) = get_accuracy(svmmdl,split_right_feat,...
            split_right_label);
        accuracies(counter,2) = i;

        counter = counter + 1;

        svmmdl = fitcsvm(split_right_feat,split_right_label,...
            'KernelFunction','linear','BoxConstraint',i);
        accuracies(counter,1) = get_accuracy(svmmdl,split_left_feat,...
            split_left_label);
        accuracies(counter,2) = i;
        
    end
    
end

% Get the index of the maximum accuracy and return the corresponding
% hyperparameters. Also output the accuracies matrix for debug.
mat = accuracies;
[~, idx] = max(accuracies(:,1));
C = accuracies(idx,2);
k_param = 0;
% If its not linear then provide the kernel parameter.
if ~strcmp(kernel_param,'linear')
    k_param = accuracies(idx,3);
end

end