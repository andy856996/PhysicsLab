clear;clc;close all;
global formula data
load('C:\Users\andy8\Desktop\HYY_DAT2\EUV_mask_Te_100w_Dv500_500_200_PSF.mat');
formula = '(1/(pi*(1+x(3))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(3)/(x(2)^2))*exp(-(X/x(2)).^2));';

title_name = 'Te';
title_formula = 'GG';
yourName = 'Ding';
data=[x_w_norm_tzo,y_w_norm_tzo];
X = x_w_norm_tzo;
y = y_w_norm_tzo;


clear sum
%% Initial data

init_theta_energy=[6.3525 50 200 1 1.9265];
init_theta_lognsse=[5 50 200.8821 0.9342 1];
init_theta_log=[5.8410  50.4596 200 1  0.7793];

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
fs=20;
% % energy
% fig1 = figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y_energy_fmin(:,:));hold on;
% xlim([1 500]);title('energy');
% legend('MC data','fminsearch energy');
% set(gca,'FontName','Times New Roman','FontSize',fs)
% xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
% ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');
% % lognsse
% fig2 = figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y_lognsse_fmin(:,:));hold on;
% xlim([1 500]);title('Lognsse');
% legend('MC data','fminsearch lognsse');
% set(gca,'FontName','Times New Roman','FontSize',fs)
% xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
% ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');
% % log
% fig3 = figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y_log_fmin(:,:));hold on;
% xlim([1 500]);title('Log');
% legend('MC data','fminsearch log');
% set(gca,'FontName','Times New Roman','FontSize',fs)
% xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
% ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');

% 
fig4 = figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y_energy_fmin(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y_lognsse_fmin(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y_log_fmin(:,:));
xlim([1 500]);title(title_name);
legend('MC data','energy','lognsse','log');
set(gca,'FontName','Times New Roman','FontSize',fs)
xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');

saveas(fig4,['C:\Users\andy8\Desktop\PhysicsLab\curvefitting\' title_formula '_' title_name '_' yourName ])

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
E = sum(abs(log(y)-log(model_y))./log(y).^2);
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