clc;clear all;
load('C:\Users\andy8\Desktop\HHYDAT\EUV_mask_TaTe2_100w_Dv500_500_200_PSF.mat')
global data;
data=[x_w_norm_tzo,y_w_norm_tzo];x_w_norm_tzo = x_w_norm_tzo(2:end);y_w_norm_tzo = y_w_norm_tzo(2:end);
X=x_w_norm_tzo;
%% using GA
 options = optimoptions( ...
     'ga', ...                                    % 最佳化算法
     'PopulationSize', 3000, ...                    % 染色體數量
     'MaxGenerations', 100000, ...                   % 最大繁衍代數 
     'PlotFcn', {@gaplotbestf}, ...     % 繪圖函數%'PlotFcn', {@gaplotbestf}, ... 
     'CrossoverFraction', 0.99, ...                % 交配率
     'Display', 'iter');                          % 結果展示方式
 
%options=gaoptimset('Display','iter','TolFun',1e-20,'TolCon',1e-20);
[x, fval] = ga(@fun_Casino_in_2E1G_GA, 5, [], [], [], [], ...
    [0,0,0,0,0], [500,500,500,5,5], [], [], options);
%% Plot
estimated_y(:,:) = (1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(4)/(x(2)^2))*exp(-(X/x(2)))+(x(5)/(x(3)^2))*exp(-(X/x(3))));
LOGNSSE_MF=sum(((log(y_w_norm_tzo)-log(estimated_y(:,:)))./log(y_w_norm_tzo)).^2)

fs=12;
figure;semilogy(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y(:,:));
figure;loglog(x_w_norm_tzo,y_w_norm_tzo, 'k-', x_w_norm_tzo, estimated_y(:,:));
legend('MC data','Curve fitting (GA)');
set(legend,'FontName','Times New Roman','FontSize',fs)
xlabel('Radius (nm)','fontsize',fs,'FontName','Times New Roman');
ylabel('Norm. absorbed energy distribution (1/nm  ^2/e)','fontsize',fs,'FontName','Times New Roman');

function E = fun_Casino_in_2E1G_GA(x)
x = [x(1) x(2) x(3) x(4) x(5)];
global data;
X = data(:,1);
y = data(:,2);

model_y = (1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(4)/(x(2)^2))*exp(-(X/x(2)))+(x(5)/(x(3)^2))*exp(-(X/x(3))));
E = sum(((log(y)-log(model_y))./log(y)).^2);
end
