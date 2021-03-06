clear;clc;fs=20;
global formula data
%% ------------------- 改這裡拉 ---------------------- %%%%%%%%%%%%%%
mertial = 'Cr';%  Cr Ni3Al   NiTe2  TaBN  TaTe2   Te
title_formula = 'EGE';% 要改
load(['C:\Users\andy8\Desktop\HYY_DAT2\EUV_mask_' mertial '_100w_Dv500_500_200_PSF.mat']); %檔案路徑
title_name = mertial;% 要改材料名稱
yourName = 'Ding'; % 你的名子
formula = AutoGeneratePointSpreadFunction(title_formula);%公式
init_theta_energy= [ 1.385146275	11.05875737	49.10614713	0.716689147	2.371671082

];
init_theta_lognsse=[  2.111085027	44.44577486	58.88171093	0.322609997	1.278853918

];
init_theta_log    =[  1.039257886	16.853513	55.38784833	0.384240096	1.546815772

];
% init_theta_energy= [   0.61635628	51.49251894	671.4303662	8.69E-08	-0.002136292];
% init_theta_lognsse=[     1.076311285	3.17E+01	175.2964559	5.72E-07	0.355933493];
% init_theta_log    =[    0.732292169	56.01380325	121.5571163	6.06E-08	-0.001606576];

%%%%%%%%%%%%%% ------------------------------------------------- %%%%%%%%%%%%%%
data=[x_w_norm_tzo,y_w_norm_tzo];
X = x_w_norm_tzo;
y = y_w_norm_tzo;

%% energy fit
x = init_theta_energy;
eval(['estimated_y_energy_fmin(:,:) = ' formula]);

%% Lognsse
x = init_theta_lognsse;
eval(['estimated_y_lognsse_fmin(:,:) = ' formula]);

%% Log
x = init_theta_log;
eval(['estimated_y_log_fmin(:,:) = ' formula]);

%% plot figure
fig4 = figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y_energy_fmin(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y_lognsse_fmin(:,:));hold on;
loglog(x_w_norm_tzo, estimated_y_log_fmin(:,:));
xlim([1 500]);title([title_formula '_' title_name '_' yourName ],'Interpreter','none');
legend('MC data','energy','lognsse','log');
set(gca,'FontName','Times New Roman','FontSize',fs)
xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');
saveas(fig4,['C:\Users\andy8\Desktop\saveFig\' title_formula '_' title_name '_' yourName ])