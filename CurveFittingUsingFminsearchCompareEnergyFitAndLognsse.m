clear;clc;%close all;
load('C:\Users\andy8\Desktop\HHYDAT\EUV_mask_TaTe2_100w_Dv500_500_200_PSF');
data=[x_w_norm_tzo,y_w_norm_tzo];
X=x_w_norm_tzo;
y = y_w_norm_tzo;
global formula
formula = '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(4)/(x(2)^2))*exp(-(X/x(2)).^2)+(x(5)/(x(3)^2))*exp(-(X/x(3)).^2));';
%% Initial data
alpha_exp=1;% nm
gamma_exp=5;% nm
beta_exp=100;
eta_exp=1;
eta_plus_exp=1;

%init_theta=[alpha_exp beta_exp eta_exp];
init_theta=[alpha_exp beta_exp gamma_exp eta_exp eta_plus_exp];
%% Fitting process 
options=optimset('largescale','on','display','iter','tolx',1e-20,'tolfun',1e-20,'MaxFunEvals',20000,'MaxIter',10^10);
[x,fval,exitflag,output]=fminsearch(@fun_Casino_in_Fminsearch,init_theta,options,data);
x_energy = x;
fval_energy = fval;
eval(['estimated_y(:,:) = ' formula]);
fs=20;
figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y(:,:));hold on;%semilogy

[x,fval,exitflag,output]=fminsearch(@fun_Casino_in_Fminsearch_2,init_theta,options,data);
x_log = x;
fval_log = fval;
eval(['estimated_y(:,:) = ' formula]);
loglog(x_w_norm_tzo, estimated_y(:,:));

%% plot
title('3G');%xlim([1 500]);
legend('MC data','using energy','using lognsse');
set(gca,'FontName','Times New Roman','FontSize',fs)
xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');

%% energy
function E = fun_Casino_in_Fminsearch(x, data)
global formula
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
for i=1:size(data,1)-1
    delta_x(i)=X(i+1)-X(i);
end
E =sum(abs( (y(1:size(data,1)-1)-model_y(1:size(data,1)-1)).*X(1:size(data,1)-1).*delta_x'));
end
%% lognsse
function E = fun_Casino_in_Fminsearch_2(x, data)
global formula
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
E = sum(((log(y)-log(model_y))./log(y)).^2);
end
