function [save_min,save_error] = fminsearchEnergyLognsseLog(path,figsavePATH,formula_arr,formula_GE)
global formula data
%% -------------------改這裡拉----------------------%%%%%%%%%%%%%%
load(path); %檔案路徑
formula = formula_arr;
martial = erase(erase(path,'C:\Users\andy8\Desktop\HYY_DAT2\EUV_mask_'),'_100w_Dv500_500_200_PSF.mat');

title_name = martial;% 要改材料名稱
title_formula = formula_GE;% 要改
yourName = 'Ding'; % 你的名子


if length(title_formula) == 2
    init_theta_energy=[1 100 1];
    init_theta_lognsse=[5 100 1];
    init_theta_log=[5 100 1];
else
    init_theta_energy= [5 50 200 1 1];
    init_theta_lognsse=[5 50 200 1 1];
    init_theta_log=    [5 50 200 1 1];
end



%%%%%%%%%%%%%% -------------------------------------------------%%%%%%%%%%%%%%
data=[x_w_norm_tzo,y_w_norm_tzo];
X = x_w_norm_tzo;
y = y_w_norm_tzo;
clear sum
%% Initial data
options=optimset('largescale','on','display','off','tolx',1e-20,'tolfun',1e-20,'MaxFunEvals',20000,'MaxIter',10^10);
clear sum;
% %% energy fit
% [x_energy_fmin,fval_energy_fmin,~,~]=fminsearch(@fun_Casino_in_Fminsearch_Energyfit,init_theta_energy,options);
% x = x_energy_fmin;
% eval(['estimated_y_energy_fmin(:,:) = ' formula]);
% %% Lognsse
% [x_lognsse_fmin,fval_lognsse_fmin,exitflag,output]=fminsearch(@fun_Casino_in_Fminsearch_Lognsse,init_theta_lognsse,options);
% x = x_lognsse_fmin;
% eval(['estimated_y_lognsse_fmin(:,:) = ' formula]);
% %% Log
% [x_log_fmin,fval_log_fmin,~,~]=fminsearch(@fun_Casino_in_Fminsearch_Log,init_theta_log,options);
% x = x_log_fmin;
% eval(['estimated_y_log_fmin(:,:) = ' formula]);
%% CrossEntropy
[x_CrossEntropy_fmin,fval_CrossEntropy_fmin,~,~]=...
    fminsearch(@fun_Casino_in_Fminsearch_CrossEntropy,init_theta_log,options);
x = x_CrossEntropy_fmin;
eval(['estimated_y_CrossEntropy_fmin(:,:) = ' formula]);
%% BinaryCrossEntropyCostFunction
[x_BinaryCrossEntropyCostFunction_fmin,fval_BinaryCrossEntropyCostFunction_fmin,~,~]=...
    fminsearch(@fun_Casino_in_Fminsearch_BinaryCrossEntropyCostFunction,init_theta_log,options);
x = x_BinaryCrossEntropyCostFunction_fmin;
eval(['estimated_y_BinaryCrossEntropyCostFunction_fmin(:,:) = ' formula]);
%% LogCosh
[x_LogCosh_fmin,fval_LogCosh_fmin,~,~]=...
    fminsearch(@fun_Casino_in_Fminsearch_LogCosh,init_theta_log,options);
x = x_LogCosh_fmin;
eval(['estimated_y_LogCosh_fmin(:,:) = ' formula]);
%% MAE
[x_MAE_fmin,fval_MAE_fmin,~,~]=...
    fminsearch(@fun_Casino_in_Fminsearch_MAE,init_theta_log,options);
x = x_MAE_fmin;
eval(['estimated_y_MAE_fmin(:,:) = ' formula]);
%% MSE
[x_MSE_fmin,fval_MSE_fmin,~,~]=...
    fminsearch(@fun_Casino_in_Fminsearch_MSE,init_theta_log,options);
x = x_MSE_fmin;
eval(['estimated_y_MSE_fmin(:,:) = ' formula]);
%% RMSE
[x_RMSE_fmin,fval_RMSE_fmin,~,~]=...
    fminsearch(@fun_Casino_in_Fminsearch_RMSE,init_theta_log,options);
x = x_RMSE_fmin;
eval(['estimated_y_RMSE_fmin(:,:) = ' formula]);
%% minSq
[x_minSq_fmin,fval_minSq_fmin,~,~]=...
    fminsearch(@fun_Casino_in_Fminsearch_minSq,init_theta_log,options);
x = x_minSq_fmin;
eval(['estimated_y_minSq_fmin(:,:) = ' formula]);

save_min = [x_CrossEntropy_fmin;x_BinaryCrossEntropyCostFunction_fmin...
    ;x_LogCosh_fmin;x_MAE_fmin;x_MSE_fmin;x_RMSE_fmin;x_minSq_fmin];
save_error = [fval_CrossEntropy_fmin;fval_BinaryCrossEntropyCostFunction_fmin;...
    fval_LogCosh_fmin;fval_MAE_fmin;fval_MSE_fmin;fval_RMSE_fmin;fval_minSq_fmin];


%% plot figure
fs=20;
% fig4 = figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y_energy_fmin(:,:));hold on;
% loglog(x_w_norm_tzo, estimated_y_lognsse_fmin(:,:));hold on;
% loglog(x_w_norm_tzo, estimated_y_log_fmin(:,:));
% xlim([1 500]);title([title_formula '_' title_name '_' yourName ],'Interpreter','none');
% legend('MC data','energy','lognsse','log');
% set(gca,'FontName','Times New Roman','FontSize',fs)
% xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
% ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');

fig4 = figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-');hold on;
loglog(x_w_norm_tzo, estimated_y_CrossEntropy_fmin(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y_BinaryCrossEntropyCostFunction_fmin(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y_LogCosh_fmin(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y_MAE_fmin(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y_MSE_fmin(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y_RMSE_fmin(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y_minSq_fmin(:,:));hold on;
xlim([1 500]);title([title_formula '_' title_name '_' yourName ],'Interpreter','none');
legend('MC data','CrossEntropy','BinaryCrossEntropyCostFunction','LogCosh','MAE','MSE','RMSE','minSq');
set(gca,'FontName','Times New Roman','FontSize',fs)
xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');
%% 這裡也要改 圖片存檔路徑
saveas(fig4,[figsavePATH title_formula '_' title_name '_' yourName ]);
end