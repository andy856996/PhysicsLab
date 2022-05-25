function E = fun_Casino_in_Fminsearch_minSq(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
E = sum((y - model_y).^2);
end
