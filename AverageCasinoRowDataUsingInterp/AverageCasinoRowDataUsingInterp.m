clc;clear all;close all;
%% Average casino row data input path
CasinoRowDataPath = './casinoRowData/';interp_x=[];interp_y=[];
folderPath_list = dir(strcat(CasinoRowDataPath,'*.mat'));
for i=1:length(folderPath_list)
    load([CasinoRowDataPath folderPath_list(i).name]);
    interp_x = [interp_x;x_w_norm_tzo];
    interp_y = [interp_y;y_w_norm_tzo];
end
[interp_x_uni, ia_uni, ~] = unique(interp_x);
interp_y_uni = interp_y(ia_uni);
%% caculate newer data using interp
newer_x_w_norm_tzo = interp_x_uni(2):0.001:max(interp_x_uni);
y_w_norm_tzo_interp1 = interp1(interp_x_uni, interp_y_uni, newer_x_w_norm_tzo, 'linear');  
y_w_norm_tzo_interp2 = interp1(interp_x_uni, interp_y_uni, newer_x_w_norm_tzo, 'pchip');    
%% plot the figure
figure;loglog(interp_x_uni,interp_y_uni,'LineWidth',0.9);hold on;
loglog(newer_x_w_norm_tzo,y_w_norm_tzo_interp1,'LineWidth',0.9);hold on;
loglog(newer_x_w_norm_tzo,y_w_norm_tzo_interp2,'LineWidth',0.9);hold on;
set(gca,'FontSize',17,'LineWidth',0.9);
legend('Original','Linear', 'Pchip');


