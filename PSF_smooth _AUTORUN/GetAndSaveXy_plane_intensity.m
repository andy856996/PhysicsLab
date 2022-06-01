function   GetAndSaveXy_plane_intensity(a,b,num_of_y_axis_points,data_path,savepath,num_of_XY_planes)
fid=fopen(data_path);
j=0;
while 1
    tline=fgetl(fid);%读取文件中的行，并删除换行符   一次讀取一行  讀取不到回傳-1 
    tf=strncmp('XY plane 0',tline,9);%% 比較 XY plane 及 tline
    if tf
        x(1,:)=strread(fgetl(fid),'%s');%丟字串到x
        x(1,:)=strrep(x(1,:),'nm','');%搜尋'nm' 取代成 -> ''
        points_of_x_axis(1,:)=str2num(char(x(1,:)));%先轉成char 再轉num
        %這邊的fgetl(fid)是上面的下一行
        for i=1:num_of_y_axis_points
            data(1,:)=strread(fgetl(fid),'%s');%這邊的fgetl(fid)是抓上面的下一行
            data(1,:)=strrep(data(1,:),'nm','');
            points_of_y_axis(1,i)=str2num(char(data(1,1)));
            eval(['data_mat_',num2str(j),'(i,:)=str2num(char(data(1,2:end)));']);  %中括號合併字串
            %data_mat_ 加上數字 j ->data_mat_<j>(i,:)=str2num(char(data(1,2:end)));
        end
        j=j+1;
    end
    if j>num_of_XY_planes
        break;
    end
end
%% Generate x-y plane matrix data 生成 x-y 平面矩陣數據
xy_plane_intensity=0;
for j=a:b  % Culculating layer between "XY plane a" and "XY plane b"
    eval(['xy_plane_intensity=xy_plane_intensity+data_mat_',num2str(j),';']); %###??????????等於0為啥會執行
end
for m=1:length(points_of_y_axis)
    for n=1:length(points_of_x_axis)
        sqrt_of_radius_matrix(m,n)=(points_of_y_axis(1,m))^2+(points_of_x_axis(1,n))^2; % x^2 + y^2
    end
end
sqrt_of_radius=sort(unique(sqrt_of_radius_matrix));%返回的是一樣的值，但是沒有重複元素。產生的結果向量按升序排序。
%% Pick out duplicate data to average 挑出重複數據取平均值 <這邊都搞不懂>
for k=1:length(sqrt_of_radius)
    [r,c]=find(sqrt_of_radius_matrix==sqrt_of_radius(k));% pick out duplicate data 
    sum=0;
    for p=1:length(r)
        sum=sum+xy_plane_intensity(r(p),c(p));%把全部的能量加總起來
    end
    mean_of_intensity(k,1)=sum/length(r);%mean_of_intensity平均同一個半徑之能量 (因為casino輸出之資料為不對稱，所以要平均同一個半徑之能量)
end
%% Output without normalization 未歸一化的輸出
y_test_non_norm=mean_of_intensity;
x_non_norm=sqrt(sqrt_of_radius);% r (not r^2) sqrt開根號
%% Output with normalization 標準化輸出
sizes=size(sqrt_of_radius);
sum_all=mean_of_intensity(1)*2*pi*(sqrt(sqrt_of_radius(1)))*(sqrt(sqrt_of_radius(1)));% sum_all initail value setting 初值設定
for i=2:sizes(1,1)
    sum_all= sum_all + mean_of_intensity(i)*2*pi*(sqrt(sqrt_of_radius(i)))*(sqrt(sqrt_of_radius(i))-sqrt(sqrt_of_radius(i-1)));
end

y_test=mean_of_intensity/sum_all;% normalized original mean_of_intensity 標準化原件
% sizes=size(sqrt_of_radius);
% sum_all=y_test(1)*2*pi*(sqrt(sqrt_of_radius(1)))*(sqrt(sqrt_of_radius(1)));% sum_all initail value setting 初值設定
% for i=2:sizes(1,1)
%     sum_all= sum_all + y_test(i)*2*pi*(sqrt(sqrt_of_radius(i)))*(sqrt(sqrt_of_radius(i))-sqrt(sqrt_of_radius(i-1)));
% end
% 
% y_test=mean_of_intensity/sum_all;% normalized original mean_of_intensity 標準化原件
x=sqrt(sqrt_of_radius);% r (not r^2)
[Normorlize_xy_plane_intensity Line] = Normorlize_XY_intensity_fun_1DTo2D(sqrt_of_radius,y_test,sqrt_of_radius_matrix);
[Wo_Norm_xy_plane_intensity Line] = Normorlize_XY_intensity_fun_1DTo2D(sqrt_of_radius,y_test_non_norm,sqrt_of_radius_matrix);
[energy_return LINE] = Normorlize_XY_intensity_fun_2DTo1D(y_test,Normorlize_xy_plane_intensity);
data_x_y_test=[x ,y_test];
% figure;semilogy(x,y_test)
%%  Output with normalization and taking zero value from (x,y)
% [x_tzo y_tzo]=take_zero_out(x,y_test);
% figure;semilogy(x_tzo, y_tzo);
x_wo_norm=x_non_norm; y_wo_norm=y_test_non_norm;% (x,y) of PSF without normalization
x_w_norm=x; y_w_norm=y_test;% (x,y) of PSF with normalization
[x_wo_norm_tzo y_wo_norm_tzo]=take_zero_out(x_wo_norm, y_wo_norm);% (x,y) of PSF without normalization, and then take out zero values of y.
[x_w_norm_tzo y_w_norm_tzo]=take_zero_out(x_w_norm, y_w_norm);% (x,y) of PSF with normalization, and then take out zero values of y.

%% Plot figure
% % % % % fs=12;
% % % % % figure;semilogy(x_wo_norm_tzo,y_wo_norm_tzo);%intial 
% % % % % %semilogy為顯示對數刻度，如果用PLOT(線性刻度)的話會顯示得很糟， y 軸為對數刻度
% % % % % title('PMMA+Ir3Te8  5keV','fontsize',fs,'FontName','Times New Roman');
% % % % % xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
% % % % % ylabel('Wo Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');
% % % % % 
% % % % % % Smoothing start
% % % % % x=sort(x_wo_norm_tzo);%排序
% % % % % xi=x(1):0.01:x(end);%x_range
% % % % % interp_x_wo_norm_tzo=interp1(smooth(x),smooth(x_wo_norm_tzo),xi,'PCHIP');% smooth 一維內插法
% % % % % interp_y_wo_norm_tzo=interp1(smooth(x),smooth(y_wo_norm_tzo),xi,'PCHIP');
% % % % % for i=1:5000%you can edit smoothing times
% % % % %     interp_y_wo_norm_tzo=smooth(interp_y_wo_norm_tzo);
% % % % % end
% % % % % figure;semilogy(interp_x_wo_norm_tzo,interp_y_wo_norm_tzo);%Smoothing
% % % % % % smoothing end
% % % % % title('PMMA+Ir3Te8  5keV','fontsize',fs,'FontName','Times New Roman');
% % % % % xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
% % % % % ylabel('Wo Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');

%% Save file
save (savepath,'x_w_norm_tzo','y_w_norm_tzo','x_wo_norm_tzo','y_wo_norm_tzo','points_of_y_axis','points_of_x_axis',...
    'xy_plane_intensity','Normorlize_xy_plane_intensity');
end