clear all;clc;close all
% Generate a point spreat function (PSF) from casino dat file.
% Created by Chun-Hung Liu 
% NTTU Prof. Liu
% Date: 1st April 2020 
% Email: chliuzzh@nttu.edu.tw

%% parameters setting (The mark " %% " is what you can adjust to satisfy the conditions you desired. )
%folderPath = 'D:\andy856996_FTP\PSF\SB_PSF_100w\DAT2\';
folderPath = 'C:\Users\tating\Desktop\DAT\';
%savePath_dir ='D:\andy856996_FTP\PSF\SB_PSF_100w\save_mat_new\';
savePath_dir ='C:\Users\tating\Desktop\DAT\';
depthOfPMMA = 80;%nm
num_of_y_axis_points=500;%% y divition number of *.dat file
a = 0; %% Starting calculation layer
for i=1:1:6
    NumOfDat = i; %whitch dat you select
    folderPath_list = dir(strcat(folderPath,'*.dat'));
    data_path=[folderPath folderPath_list(NumOfDat).name];
    savepath = [savePath_dir erase(folderPath_list(NumOfDat).name,"dat") 'mat'];
    num_of_XY_planes = returnNum_of_XY_planes(data_path,depthOfPMMA);%% Stopping calculation of "XY plane" layer
    b = num_of_XY_planes; % Stopping calculation layer
    GetAndSaveXy_plane_intensity(a,b,num_of_y_axis_points,data_path,savepath,num_of_XY_planes);
    %%前置作業把資料讀取到變數 包刮X軸刻度 和電子能量
end
%% (EUV ARF 多張圖整理成一張圖)只適用同一種材料 方法->> 資料需要在同一個資料夾，ArF mask 檔案名稱需要有ArF EUV 也一樣
% ARF_line_num = [];
% EUV_line_num = [];
% %把每一個EUV ArF mask的X軸取出放在同一個陣列
% for i=1:1:6
%     NumOfDat = i; %whitch dat you select
%     folderPath_list = dir(strcat(folderPath,'*.mat'));
%     data_path=[folderPath folderPath_list(NumOfDat).name];
%     load(data_path);
%     if contains(data_path,'ArF')
%         ARF_line_num = [ARF_line_num;x_w_norm_tzo];
%     else
%         EUV_line_num = [EUV_line_num;x_w_norm_tzo];
%     end
% end
% %ARF陣列作排序，zero 為等等要放能量的地方
% ARF_line_num_TOTAL = [sort(unique(ARF_line_num)) zeros(size(sort(unique(ARF_line_num)),1),1)];
% %EUV陣列作排序，zero 為等等要放能量的地方
% EUV_line_num_TOTAL = [sort(unique(EUV_line_num)) zeros(size(sort(unique(EUV_line_num)),1),1)];
% for i=1:1:6
%     NumOfDat = i;
%     folderPath_list = dir(strcat(folderPath,'*.mat'));
%     data_path=[folderPath folderPath_list(NumOfDat).name];
%     load(data_path);
%     if contains(data_path,'ArF')
%         for j=1:size(y_w_norm_tzo,1)
%             row = find(ARF_line_num_TOTAL == x_w_norm_tzo(j));
%             if ARF_line_num_TOTAL(row,2) == 0
%                 ARF_line_num_TOTAL(row,2) = y_w_norm_tzo(j);
%             else
%                 ARF_line_num_TOTAL(row,2) = (ARF_line_num_TOTAL(row,2) + y_w_norm_tzo(j))/2;
%             end
%         end
%     else
%         for j=1:size(y_w_norm_tzo,1)
%             row = find(EUV_line_num_TOTAL == x_w_norm_tzo(j));
%             if EUV_line_num_TOTAL(row,2) == 0
%                 EUV_line_num_TOTAL(row,2) = y_w_norm_tzo(j);
%             else
%                 EUV_line_num_TOTAL(row,2) = (EUV_line_num_TOTAL(row,2) + y_w_norm_tzo(j))/2;
%             end
%         end
%     end
% end
% figure;loglog(ARF_line_num_TOTAL(:,1),ARF_line_num_TOTAL(:,2));hold on;
% loglog(EUV_line_num_TOTAL(:,1),EUV_line_num_TOTAL(:,2));
% legend({'Arf Cr','EUV Cr'},'FontSize',24,'location','eastoutside');xlim([1 450]);
% 
% figure;semilogy(ARF_line_num_TOTAL(:,1),ARF_line_num_TOTAL(:,2));hold on;
% semilogy(EUV_line_num_TOTAL(:,1),EUV_line_num_TOTAL(:,2));
% legend({'Arf Cr','EUV Cr'},'FontSize',24,'location','eastoutside');xlim([1 450]);

