%% Cross Entropy設計的觀念是讓模型去學習預測資料的機率分佈，其中p(x) 為真實分布， q(x)為預測值
function E = fun_Casino_in_Fminsearch_CrossEntropy(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
E = -(sum(y - log(model_y)));
end
