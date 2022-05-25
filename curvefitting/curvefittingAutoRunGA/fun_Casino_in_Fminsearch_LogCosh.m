function E = fun_Casino_in_Fminsearch_LogCosh(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
E = sum(log(cosh(model_y - y)));
end
