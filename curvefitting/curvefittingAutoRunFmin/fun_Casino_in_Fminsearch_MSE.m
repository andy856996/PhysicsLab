function E = fun_Casino_in_Fminsearch_MSE(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
E = (1/2*length(y))*(sum((y - model_y).^2));
end
