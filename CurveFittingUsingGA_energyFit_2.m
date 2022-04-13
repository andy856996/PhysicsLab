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
%% Fitting process 
[x,fval,exitflag,output]=fminsearch(@fun_Casino_in_Fminsearch,init_theta,options,data);
x_energy = x;
fval_energy = fval;
eval(['estimated_y(:,:) = ' formula]);
LOGNSSE_MF_energy=sum(((log(y_w_norm_tzo)-log(estimated_y(:,:)))./log(y_w_norm_tzo)).^2)
fs=20;

%semilogy(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y(:,:));hold on;%semilogy
%%
[x,fval,exitflag,output]=fminsearch(@fun_Casino_in_Fminsearch_2,init_theta,options,data);
x_log = x;
fval_log = fval;
eval(['estimated_y1(:,:) = ' formula]);
LOGNSSE_MF_lognsse=sum(((log(y_w_norm_tzo)-log(estimated_y1(:,:)))./log(y_w_norm_tzo)).^2)
%semilogy(x_w_norm_tzo, estimated_y(:,:));
%% using GA

[x, fval] = ga(@fun_Casino_in_GA, 5, [], [], [], [], ...
    [0,0,0,0,0], [1000,1000,1000,5,5], [], [], GAoptions);
x_ga = x;
x_fval = fval;
eval(['estimated_y2(:,:) = ' formula]);
LOGNSSE_MF_lognsse2=sum(((log(y_w_norm_tzo)-log(estimated_y2(:,:)))./log(y_w_norm_tzo)).^2)
%% plot


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
E = sum(abs(log(y)-log(model_y))./log(y).^2);
end
%% lognsse2
function E = fun_Casino_in_Fminsearch_3(x, data)
global formula
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
%E = sum(log(y)-log(model_y));
E = sum(abs(log(y)-log(model_y)));
end
%% lognsse2 GA
function E = fun_Casino_in_GA(x)
global formula data
X = data(:,1);
y = data(:,2);
eval(['model_y =' formula]);
%E = sum(log(y)-log(model_y));
E = sum(abs(log(y)-log(model_y)));
end