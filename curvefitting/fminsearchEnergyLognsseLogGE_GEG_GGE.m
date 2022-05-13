clear;clc;close all;fs=20;
global formula data
%% using GA
 options = optimoptions( ...
     'ga', ...                                    % 最佳化算法
     'PopulationSize', 1000, ...                    % 染色體數量
     'MaxGenerations', 100000, ...                   % 最大繁衍代數 
     'PlotFcn', {@gaplotbestf}, ...     % 繪圖函數%'PlotFcn', {@gaplotbestf}, ... 
     'CrossoverFraction', 0.99, ...                % 交配率
     'Display', 'iter');                          % 結果展示方式
%% -------------------改這裡拉----------------------%%%%%%%%%%%%%%
load('C:\Users\andy8\Desktop\HYY_DAT2\EUV_mask_Ni3Al_100w_Dv500_500_200_PSF.mat'); %檔案路徑
formula = ...
    '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(4)/2*(x(2)^2))*exp(-(X/x(2)))+(x(5)/(x(3)^2))*exp(-(X/x(3)).^2));';%公式

title_name = 'Ni3Al';% 要改材料名稱
title_formula = 'GEG';% 要改
yourName = 'Ding'; % 你的名子

init_theta_energy= [2 60 200 10 10];
init_theta_lognsse=[3 30 300 1 0.1];
init_theta_log    =[5 10 700 1 0.1];
%%%%%%%%%%%%%% -------------------------------------------------%%%%%%%%%%%%%%
data=[x_w_norm_tzo,y_w_norm_tzo];
X = x_w_norm_tzo;
y = y_w_norm_tzo;

[x_energy_fmin, fval] = ga(@fun_Casino_in_Fminsearch_Energyfit, 5, [], [], [], [], ...
    [0,10,50,-1,-1], [10,100,1000,5,5], [], [], options);
x = x_energy_fmin;
eval(['estimated_y_energy_fmin(:,:) = ' formula]);
figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y_energy_fmin(:,:));hold on;
xlim([1 500]);title(title_name);
legend('MC data','energy','lognsse','log');
set(gca,'FontName','Times New Roman','FontSize',fs)
xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');
clear sum
%% Initial data
options=optimset('largescale','on','display','off','tolx',1e-20,'tolfun',1e-20,'MaxFunEvals',20000,'MaxIter',10^10);
clear sum;
%% energy fit
[x_energy_fmin,fval_energy_fmin,~,~]=fminsearch(@fun_Casino_in_Fminsearch_Energyfit,init_theta_energy,options);
x = x_energy_fmin;
eval(['estimated_y_energy_fmin(:,:) = ' formula]);

%% Lognsse
[x_lognsse_fmin,fval_lognsse_fmin,exitflag,output]=fminsearch(@fun_Casino_in_Fminsearch_Lognsse,init_theta_lognsse,options);
x = x_lognsse_fmin;
eval(['estimated_y_lognsse_fmin(:,:) = ' formula]);

%% Log
[x_log_fmin,fval_log_fmin,~,~]=fminsearch(@fun_Casino_in_Fminsearch_Log,init_theta_log,options);
x = x_log_fmin;
eval(['estimated_y_log_fmin(:,:) = ' formula]);

save_min = [x_energy_fmin;x_lognsse_fmin;x_log_fmin]
save_error = [fval_energy_fmin;fval_lognsse_fmin;fval_log_fmin]

%% plot figure


% 
    fig4 = figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y_energy_fmin(:,:));hold on;
    loglog(x_w_norm_tzo, estimated_y_lognsse_fmin(:,:));hold on;
    loglog(x_w_norm_tzo, estimated_y_log_fmin(:,:));
    xlim([1 500]);title(title_name);
    legend('MC data','energy','lognsse','log');
    set(gca,'FontName','Times New Roman','FontSize',fs)
    xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
    ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');
%% 這裡也要改 圖片存檔路徑
%saveas(fig4,['C:\Users\andy8\Desktop\PhysicsLab\curvefitting\' title_formula '_' title_name '_' yourName ])

%% Fmin energy
function E = fun_Casino_in_Fminsearch_Energyfit(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
for i=1:size(data,1)-1
    delta_x(i)=X(i+1)-X(i);
end
E =sum(abs( (y(1:size(data,1)-1)-model_y(1:size(data,1)-1)).*X(1:size(data,1)-1).*delta_x'));
end
%% Fmin lognsse
function E = fun_Casino_in_Fminsearch_Lognsse(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
%E = sum(abs(log(y)-log(model_y))./log(y).^2);
E = sum((abs(log(y)-log(model_y))./log(y)).^2);
end
%% Fmin log
function E = fun_Casino_in_Fminsearch_Log(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
%E = sum(log(y)-log(model_y));
E = sum(abs(log(y)-log(model_y)));
end