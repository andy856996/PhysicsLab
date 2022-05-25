function E = fun_Casino_in_Fminsearch_RMSE(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
E = (sqrt(sum((model_y - y).^2)/length(y)));
end
