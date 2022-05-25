function E = fun_Casino_in_Fminsearch_MAE(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
E = (1/length(y))*(sum(abs(y - model_y)));
end
