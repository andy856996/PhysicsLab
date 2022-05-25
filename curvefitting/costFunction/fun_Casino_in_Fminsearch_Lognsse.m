%% Fmin lognsse
function E = fun_Casino_in_Fminsearch_Lognsse(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
%E = sum(abs(log(y)-log(model_y))./log(y).^2);
E = sum((abs(log(y)-log(model_y))./log(y)).^2);
end