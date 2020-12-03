function RMSE = error(predicted, observed)
    %This function must take as input two arrays to compute the RMSE
    
    sum_step = 0;
    for j = 1:length(predicted)
        step = (predicted(j)-observed(j))^2
        sum_step = step + sum_step
    end
    
    RMSE = sqrt(sum_step/length(predicted))
    
end  
