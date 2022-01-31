clc;clear all;
load('C:\Users\tating\Desktop\HYY_DAT\EUV_mask_TaTe2_100w_Dv500_500_200_PSF.mat')
global data;
data=[x_w_norm_tzo,y_w_norm_tzo];
X=x_w_norm_tzo;
%% using GA
 options = optimoptions( ...
     'ga', ...                                    % 最佳化算法
     'PopulationSize', 1000, ...                    % 染色體數量
     'MaxGenerations', 10^10, ...                   % 最大繁衍代數 
     'PlotFcn', {@gaplotbestf}, ...     % 繪圖函數%'PlotFcn', {@gaplotbestf}, ... 
     'CrossoverFraction', 0.99, ...                % 交配率
     'Display', 'iter');                          % 結果展示方式
 
%options=gaoptimset('Display','iter','TolFun',1e-20,'TolCon',1e-20);
[x, fval] = ga(@fun_Casino_in_2E1G_GA, 17, [], [], [], [], [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], [100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100], [], [], options);
%% Plot

estimated_y(:,:) = (1/(pi*(1+x(10)+x(11)+x(12)+x(13)+x(14)+x(15)+x(16)+x(17))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(10)/(x(2)^2))*exp(-(X/x(2)).^2)+(x(11)/(x(3)^2))*exp(-(X/x(3)).^2)+(x(12)/(x(4)^2))*exp(-(X/x(4)).^2)+(x(13)/(x(5)^2))*exp(-(X/x(5)).^2)+(x(14)/(x(6)^2))*exp(-(X/x(6)).^2)+(x(15)/(x(7)^2))*exp(-(X/x(7)).^2)+(x(16)/(x(8)^2))*exp(-(X/x(8)))+(x(17)/(x(9)^2))*exp(-(X/x(9))));


LOGNSSE_MF=sum(((log(y_w_norm_tzo)-log(estimated_y(:,:)))./log(y_w_norm_tzo)).^2)

fs=12;
figure;semilogy(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y(:,:));
figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y(:,:));
legend('MC data','Curve fitting (fminsearch)');
set(legend,'FontName','Times New Roman','FontSize',fs)
xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');

function E = fun_Casino_in_2E1G_GA(x)
theta = [x(1) x(2) x(3) x(4) x(5) x(6) x(7) x(8) x(9) x(10) x(11) x(12) x(13) x(14) x(15) x(16) x(17)];
global data;
x = data(:,1);
y = data(:,2);

model_y = (1/(pi*(1+theta(10)+theta(11)+theta(12)+theta(13)+theta(14)+theta(15)+theta(16)+theta(17))))*...
((1/(theta(1)^2))*exp(-(x/theta(1)).^2)+...
	(theta(10)/(theta(2)^2))*exp(-(x/theta(2)).^2)+...
	(theta(11)/(theta(3)^2))*exp(-(x/theta(3)).^2)+...
	(theta(12)/(theta(4)^2))*exp(-(x/theta(4)).^2)+...
	(theta(13)/(theta(5)^2))*exp(-(x/theta(5)).^2)+...
	(theta(14)/(theta(6)^2))*exp(-(x/theta(6)).^2)+...
	(theta(15)/(theta(7)^2))*exp(-(x/theta(7)).^2)+...
	(theta(16)/(theta(8)^2))*exp(-(x/theta(8)))+...
	(theta(17)/(theta(9)^2))*exp(-(x/theta(9))));
E = sum(((log(y)-log(model_y))./log(y)).^2);
end
