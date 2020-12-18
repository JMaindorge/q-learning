function [C, k_param] = inner_foldr(train_data,kernel_param)
% Function to determine the best model based on inner fold testing.
% Train data to contain labels and features
% Split data in half, where one half is train and other half is validation.
% This to make sure we get as close to the data n*10 > n features ratio.
Split = floor(length(train_data)/2);

% Set values to test for hyperparameters.
sigma_param_values = 10:1:50;
q_param_values = 1:0.5:3;

%Set values to test for c depending on the type of SVM
if strcmp(kernel_param,'q')
    c_values = 0.0001:0.0001:0.0015;
else
    c_values = 1:1:30;
end

% Define the two differnt split features and labels for training.
split_left_label = train_data(1:Split,1);
split_right_label = train_data(Split+1:end,1);

% Define the two differnt split features and labels for training.
split_left_feat = train_data(1:Split,2:end);
split_right_feat = train_data(Split+1:end,2:end);


% Tune hyperparameters for RBF
if strcmp(kernel_param,'sigma')
    % Create a iterations-by-3 matrix to store the values for the resulting
    % rmse of the model and the corresponding hyper parameters.
    rmse_mat =  zeros(length(c_values) * length(sigma_param_values)*2, 3);
    counter = 0;

    for i = c_values

        for j = sigma_param_values
            counter = counter + 1;
            svmmdl = fitrsvm(split_left_feat,split_left_label,...
                'KernelFunction','gaussian','BoxConstraint',i,...
                'KernelScale',j, 'Epsilon', 2);
%           First column is rmse
            rmse_mat(counter,1) = get_rmse(svmmdl,split_right_feat,...
                split_right_label);
%           Second column is C value
            rmse_mat(counter,2) = i;
%           Third column is kernerl parameter
            rmse_mat(counter,3) = j;
            
            counter = counter + 1;
            
%           Swap training data and validation data
            svmmdl = fitrsvm(split_right_feat,split_right_label,...
                'KernelFunction','gaussian','BoxConstraint',i,...
                'KernelScale',j,'Epsilon', 2);
            rmse_mat(counter,1) = get_rmse(svmmdl,split_left_feat,...
                split_left_label);
            rmse_mat(counter,2) = i;
            rmse_mat(counter,3) = j;
            
        end
        
    end
  
end

% Tune hyperparameters for Polynomial kernel.
if strcmp(kernel_param,'q')
    rmse_mat =  zeros(length(c_values) * length(q_param_values)*2, 3);
    counter = 0;

    for i = c_values
        
        for j = q_param_values
            counter = counter + 1;
            svmmdl = fitrsvm(split_left_feat,split_left_label,...
                'KernelFunction','polynomial','BoxConstraint',i,...
                'PolynomialOrder',j, 'Epsilon', 2);
            rmse_mat(counter,1) = get_rmse(svmmdl,split_right_feat,...
                split_right_label);
            rmse_mat(counter,2) = i;
            rmse_mat(counter,3) = j;
            
            counter = counter + 1;
            
            svmmdl = fitrsvm(split_right_feat,split_right_label,...
                'KernelFunction','polynomial','BoxConstraint',i,...
                'PolynomialOrder',j,'Epsilon', 2);
            rmse_mat(counter,1) = get_rmse(svmmdl,split_left_feat,...
                split_left_label);
            rmse_mat(counter,2) = i;
            rmse_mat(counter,3) = j;
            
        end
        
    end
    
end

if strcmp(kernel_param,'linear')
    rmse_mat =  zeros(length(c_values), 2);
    counter = 0;
    
    for i = c_values
        counter = counter + 1;
        svmmdl = fitrsvm(split_left_feat,split_left_label,...
            'KernelFunction','linear','BoxConstraint',i, 'Epsilon', 2);
        rmse_mat(counter,1) = get_rmse(svmmdl,split_right_feat,...
            split_right_label);
        rmse_mat(counter,2) = i;

        counter = counter + 1;

        svmmdl = fitrsvm(split_right_feat,split_right_label,...
            'KernelFunction','linear','BoxConstraint',i, 'Epsilon', 2);
        rmse_mat(counter,1) = get_rmse(svmmdl,split_left_feat,...
            split_left_label);
        rmse_mat(counter,2) = i;
        
    end
    
end

% Get the index of the minimum rmse and return the corresponding
% hyperparameters.
[~, idx] = min(rmse_mat(:,1));
C = rmse_mat(idx,2);
k_param = 0;
% If its not linear then provide the kernel parameter.
if ~strcmp(kernel_param,'linear')
    k_param = rmse_mat(idx,3);
end

end