%Function returns the rmse of a model
function[RMSE]= get_rmse(model, x, y)
%find the model predictions
pred=predict(model,x);
%calculate mean square error
mse=immse(pred,y);
%calculate root mean square error
RMSE=sqrt(mse);
end