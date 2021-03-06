clc;clear all;
%% Cr
PPSF_init(1).PPSF_ = [10.7417	126.9749 0 0.7532 0;...
    5.3506	162.602	63.9782	0.0942	0.0992;...
    1.4427	60.0146	17.5299	0.3609	0.1452;...
    1.4643	62.7863	21.6338	0.3344	0.163];
%% Ni3Al
PPSF_init(2).PPSF_ = [9.2152	114.8603	0	0.9245	0;...
    4.9941	156.272	62.1087	0.1019	0.0948;...
    1.0045	53.7733	4.558	0.4986	0.2517;...
    0.8441	54.2695	6.1488	0.4597	0.1713];
%% NiTe2
PPSF_init(3).PPSF_ = [13.9287	142.3961	0	0.9836	0;...
    5.422	164.739	67.784	0.104	0.1002;...
    1.196	56.2734	4.8726	0.526	0.2273;...
    0.9047	56.6732	6.6159	0.4895	0.1579];
%% TaBN
PPSF_init(4).PPSF_ = [49.9191	175.6004	0	0.4887	0;...
    5.8642	185.168	77.055	0.0845	0.1156;...
    1.6359	60.2003	15.8257	0.4143	0.1227;...
    1.3893	60.1921	15.9425	0.4615	0.1272];
%% TaTe2
PPSF_init(5).PPSF_ = [8.9385	116.9546	0	1.1511	0;...
    4.227	138.304	50.689	0.1282	0.0861;...
    1	51.7892	4.4558	0.567	0.2457;...
    1.3656	51.8469	6.1586	0.5427	0.1874];
%% Te
PPSF_init(6).PPSF_ = [8.9311	123.1238	0	1.1697	0;...
    4.5624	143.1624	50.3583	1.1856	0.7865;...
    1.9357	54.5007	4.2242	0.5758	0.2523;...
    0.7538	54.8051	5.1856	0.5427	0.1874];
%%
load('C:\Users\tating\Desktop\HYY_DAT\EUV_mask_TaTe2_100w_Dv500_500_200_PSF.mat');
PPSF = PPSF_init(5).PPSF_;
x  = x_w_norm_tzo;
y = y_w_norm_tzo;
%% 3E3G
X = [348.308345864905 585.810796121355 67.2344592187802 731.296674226377 15.7027438051050 96.0964893692088 489.859273178152 853.178924393372 493.831196939466 999.394819623255 997.389938985519 0.881604703802533 33.4433778309855 44.5673177070836 16.2481463805340 458.865877550379 36.0040763637305 584.471217057199];
ThreeG_ThreeE_y1 = (X(18)/(pi*(1+X(7)+X(8)+X(9)+X(10)+X(11))))*...
((1/(X(1)^2))*exp(-(X(12)*x/X(1)).^2)+ ...
(X(7)/(X(2)^2))*exp(-(X(13)*x/X(2)).^2)+ ...
(X(8)/(X(3)^2))*exp(-(X(14)*x/X(3)).^2)+ ...
(X(9)/(X(4)^2))*exp(-(X(15)*x/X(4)))+ ...
(X(10)/(X(5)^2))*exp(-(X(16)*x/X(5)))+ ...
(X(11)/(X(6)^2))*exp(-(X(17)*x/X(6))));
LOGNSSE_MF=sum(((log(y_w_norm_tzo)-log(ThreeG_ThreeE_y1))./log(y_w_norm_tzo)).^2)
%% 3E3G
X_org = X;
X = [800.308345864905 500.810796121355 800.2344592187802 731.296674226377 15.7027438051050 96.0964893692088 489.859273178152 853.178924393372 493.831196939466 999.394819623255 997.389938985519 0.881604703802533 33.4433778309855 44.5673177070836 16.2481463805340 458.865877550379 36.0040763637305 584.471217057199];
ThreeG_ThreeE_y1_mod = (X(18)/(pi*(1+X(7)+X(8)+X(9)+X(10)+X(11))))*...
((1/(X(1)^2))*exp(-(X(12)*x/X(1)).^2)+ ...
(X(7)/(X(2)^2))*exp(-(X(13)*x/X(2)).^2)+ ...
(X(8)/(X(3)^2))*exp(-(X(14)*x/X(3)).^2)+ ...
(X(9)/(X(4)^2))*exp(-(X(15)*x/X(4)))+ ...
(X(10)/(X(5)^2))*exp(-(X(16)*x/X(5)))+ ...
(X(11)/(X(6)^2))*exp(-(X(17)*x/X(6))));
LOGNSSE_MF_mod=sum(((log(y_w_norm_tzo)-log(ThreeG_ThreeE_y1_mod))./log(y_w_norm_tzo)).^2)

%% plot
figure;
fs= 1;
loglog(x,y,'k','LineWidth',1);hold on;%semilogy
loglog(x,ThreeG_ThreeE_y1,'LineWidth',fs);
loglog(x,ThreeG_ThreeE_y1_mod,'LineWidth',fs);
legend('MC','cureFittingPSF','modPSF');%xlim([1 500]);
set(gca,'FontSize',17);
title('TaTe2')