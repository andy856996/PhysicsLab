clc;clear all;close all;
%% Average casino row data input path
CasinoRowDataPath = './casinoRowData/';
%% caculate newer data using interp
folderPath_list = dir(strcat(CasinoRowDataPath,'*.mat'));
load([CasinoRowDataPath folderPath_list(1).name]);
newer_x_w_norm_tzo = x_w_norm_tzo(2):0.1:max(x_w_norm_tzo); 
[x_w_norm_tzo_C, ia, ~] = unique(x_w_norm_tzo);
y_w_norm_tzo_interp = interp1(x_w_norm_tzo_C, y_w_norm_tzo(ia(:)), newer_x_w_norm_tzo, 'nearest');  
y_w_norm_tzo_interp1 = interp1(x_w_norm_tzo_C, y_w_norm_tzo(ia(:)), newer_x_w_norm_tzo, 'linear');  
y_w_norm_tzo_interp2 = interp1(x_w_norm_tzo_C, y_w_norm_tzo(ia(:)), newer_x_w_norm_tzo, 'pchip');    
%% plot the figure
figure;loglog(x_w_norm_tzo,y_w_norm_tzo,'LineWidth',0.9);hold on;
loglog(newer_x_w_norm_tzo,y_w_norm_tzo_interp,'LineWidth',0.9);hold on;
loglog(newer_x_w_norm_tzo,y_w_norm_tzo_interp1,'LineWidth',0.9);hold on;
loglog(newer_x_w_norm_tzo,y_w_norm_tzo_interp2,'LineWidth',0.9);hold on;
set(gca,'FontSize',17,'LineWidth',0.9);
legend('Original', 'Nearest', 'Linear', 'Pchip', 'Spline');
for i=1:length(folderPath_list)
    
end