function predictions = TTest_Run(data,kernel_param)
    test = data(455:end,:);
    training = data(1:454,:);
    
    [c, kp, ~] = inner_fold(training,kernel_param);

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
    
    predictions = predict(Mdl, test(:,2:end));
end

