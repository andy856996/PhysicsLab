clear;clc;%close all;
global formula data
load('C:\Users\andy8\Desktop\HHYDAT\EUV_mask_Cr_100w_Dv500_500_200_PSF');
data=[x_w_norm_tzo,y_w_norm_tzo];
X=x_w_norm_tzo;
y = y_w_norm_tzo;

formula = '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(4)/(x(2)^2))*exp(-(X/x(2)))+(x(5)/(x(3)^2))*exp(-(X/x(3))));';
clear sum
%% Initial data
alpha_exp=1;% nm
beta_exp=54;
gamma_exp=5;% nm
eta_exp=0.553790025503776;
eta_plus_exp=0.315262132295100;

init_theta=[alpha_exp beta_exp gamma_exp eta_exp eta_plus_exp];
clear sum;
options=optimset('largescale','on','display','iter','tolx',1e-20,'tolfun',1e-20,'MaxFunEvals',20000,'MaxIter',10^10);
 GAoptions = optimoptions( ...
     'ga', ...                                    % 最佳化算法
     'PopulationSize', 10000, ...                    % 染色體數量
     'MaxGenerations', 100000, ...                   % 最大繁衍代數 
     'PlotFcn', {@gaplotbestf}, ...     % 繪圖函數%'PlotFcn', {@gaplotbestf}, ... 
     'CrossoverFraction', 0.99, ...                % 交配率
     'Display', 'iter');                          % 結果展示方式
 
%options=gaoptimset('Display','iter','TolFun',1e-20,'TolCon',1e-20);
%% energy fit
[x_energy_fmin,fval_energy_fmin,~,~]=fminsearch(@fun_Casino_in_Fminsearch_Energyfit,init_theta,options,data);
x = x_energy_fmin;
eval(['estimated_y_energy_fmin(:,:) = ' formula]);

[x_energy_ga, x_energy_fval_GA] = ga(@fun_Casino_in_GA_energyfit, 5, [], [], [], [], ...
    [0,0,0,0,0], [1000,1000,1000,5,5], [], [], GAoptions);
x = x_energy_ga;
eval(['estimated_y__energy_GA(:,:) = ' formula]);
%% Lognsse
[x_lognsse_fmin,fval_lognsse_fmin,exitflag,output]=fminsearch(@fun_Casino_in_Fminsearch_Energyfit,init_theta,options,data);
x = x_lognsse_fmin;
eval(['estimated_y_lognsse_fmin(:,:) = ' formula]);

[x_lognsse_GA, x_lognsse_fval_GA] = ga(@fun_Casino_in_GA_energyfit, 5, [], [], [], [], ...
    [0,0,0,0,0], [1000,1000,1000,5,5], [], [], GAoptions);
x = x_lognsse_GA;
eval(['estimated_y_lognsse_GA(:,:) = ' formula]);
%% Log
[x_log_fmin,fval_log_fmin,~,~]=fminsearch(@fun_Casino_in_Fminsearch_Energyfit,init_theta,options,data);
x = x_log_fmin;
eval(['estimated_y_log_fmin(:,:) = ' formula]);

[x_log_ga, x_log_fval_GA] = ga(@fun_Casino_in_GA_energyfit, 5, [], [], [], [], ...
    [0,0,0,0,0], [1000,1000,1000,5,5], [], [], GAoptions);
x = x_log_ga;
eval(['estimated_y_log_GA(:,:) = ' formula]);
%% plot
fs=20;

figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y1(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y2(:,:));

title('GEE');
xlim([1 500]);
legend('MC data','using energy','using lognsse','using lognsse2');
set(gca,'FontName','Times New Roman','FontSize',fs)
xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');
clear sum







%% Fmin energy
function E = fun_Casino_in_Fminsearch_Energyfit(x, data)
global formula
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
for i=1:size(data,1)-1
    delta_x(i)=X(i+1)-X(i);
end
E =sum(abs( (y(1:size(data,1)-1)-model_y(1:size(data,1)-1)).*X(1:size(data,1)-1).*delta_x'));
end
%% Fmin lognsse
function E = fun_Casino_in_Fminsearch_Lognsse(x, data)
global formula
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
E = sum(abs(log(y)-log(model_y))./log(y).^2);
end
%% Fmin log
function E = fun_Casino_in_Fminsearch_Log(x, data)
global formula
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
%E = sum(log(y)-log(model_y));
E = sum(abs(log(y)-log(model_y)));
end
%% GA energy
function E = fun_Casino_in_GA_energyfit(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
%E = sum(log(y)-log(model_y));
E = sum(abs(log(y)-log(model_y)));
end
%% GA lognsse
function E = fun_Casino_in_GA_Lognsse(x)
global formula
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
E = sum(abs(log(y)-log(model_y))./log(y).^2);
end
%% GA log
function E = fun_Casino_in_GA_Log(x)
global formula
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
%E = sum(log(y)-log(model_y));
E = sum(abs(log(y)-log(model_y)));
end