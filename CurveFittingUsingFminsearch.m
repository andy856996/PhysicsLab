clear;clc;close all;
load('C:\Users\tating\Desktop\HYY_DAT\EUV_mask_TaTe2_100w_Dv500_500_200_PSF.mat');
data=[x_w_norm_tzo,y_w_norm_tzo];
X=x_w_norm_tzo;
%% Initial data
alpha_exp=0.946653540326315;% nm
gamma_exp=3.93617665144878;% nm
beta_exp=51.4668933705598;
eta_exp=0.297296227027904;
eta_plus_exp=0.596652562934357;

init_theta=[alpha_exp beta_exp gamma_exp eta_exp eta_plus_exp];
%% Fitting process 
options=optimset('largescale','off','display','iter','tolx',1e-20,'tolfun',1e-20,'MaxFunEvals',2000,'MaxIter',10^10);
[x,fval,exitflag,output]=fminsearch(@fun_Casino_in_Fminsearch,init_theta,options,data);

%% formula
estimated_y(:,:) = (1/(pi*(1+x(4)+x(5))))*...
    ((1/(x(1)^2))*exp(-(2.35*X/x(1)).^2)+ ...
    (x(4)/(x(2)^2))*exp(-(X/x(2)))+ ...
    (x(5)/(x(3)^2))*exp(-(X/x(3))));

%% output
disp(x);
LOGNSSE_MF=sum(((log(y_w_norm_tzo)-log(estimated_y(:,:)))./log(y_w_norm_tzo)).^2)
%% plot
fs=12;
figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y(:,:));%semilogy
title('1G2E');%xlim([1 500]);
legend('MC data','Curve fitting (fminsearch)');
set(legend,'FontName','Times New Roman','FontSize',fs)
xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');

%% curve fitting Function
function E = fun_Casino_in_Fminsearch(x, data)
X = data(:,1);
y = data(:,2);
model_y =(1/(pi*(1+x(4)+x(5))))*...
    ((1/(x(1)^2))*exp(-(2.35*X/x(1)).^2)+ ...
    (x(4)/(x(2)^2))*exp(-(X/x(2)))+ ...
    (x(5)/(x(3)^2))*exp(-(X/x(3))));
E = sum(((log(y)-log(model_y))./log(y)).^2);
end
