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
%%
x  = x_w_norm_tzo;
y = y_w_norm_tzo;

%% GEE
alpha = PPSF(3,1); % forward cattering range parameter, unit: nm
beta = PPSF(3,2); % backward scattering range parameter, unit: nm
gamma = PPSF(3,3);% third term parameter, unit: nm
eta = PPSF(3,4); % ratio of backward scattering to forward-scattering
eta1 = PPSF(3,5);% ratio of the third term to the forward-scattering
gamma2=[]; gamma3=[];  gamma4=[]; gamma5=[]; eta2=[];eta3=[];eta4=[];eta5=[];
GEE_Y = (1/(pi*(1+eta+eta1)))*((1/(alpha^2))*exp(-(x/alpha).^2)+(eta/(beta^2))*exp(-(x/beta))+(eta1/(gamma^2))*exp(-(x/gamma)));
%% GGG
alpha = PPSF(2,1); % forward cattering range parameter, unit: nm
beta = PPSF(2,2); % backward scattering range parameter, unit: nm
gamma = PPSF(2,3);% third term parameter, unit: nm
eta = PPSF(2,4); % ratio of backward scattering to forward-scattering
eta1 = PPSF(2,5);% ratio of the third term to the forward-scattering
gamma2=[]; gamma3=[];  gamma4=[]; gamma5=[]; eta2=[];eta3=[];eta4=[];eta5=[];
GGG_Y = (1/(pi*(1+eta+eta1)))*((1/(alpha^2))*exp(-(x/alpha).^2)+(eta/(beta^2))*exp(-(x/beta).^2)+(eta1/(gamma^2))*exp(-(x/gamma).^2));
%% GG
alpha = PPSF(1,1); % forward cattering range parameter, unit: nm
beta = PPSF(1,2); % backward scattering range parameter, unit: nm
gamma = PPSF(1,3);% third term parameter, unit: nm
eta = PPSF(1,4); % ratio of backward scattering to forward-scattering
eta1 = PPSF(1,5);% ratio of the third term to the forward-scattering
gamma2=[]; gamma3=[];  gamma4=[]; gamma5=[]; eta2=[];eta3=[];eta4=[];eta5=[];
GG_Y = (1/(pi*(1+eta)))*((1/(alpha^2))*exp(-(x/alpha).^2)+(eta/(beta^2))*exp(-(x/beta).^2));
%% EEE
alpha = PPSF(4,1); % forward cattering range parameter, unit: nm
beta = PPSF(4,2); % backward scattering range parameter, unit: nm
gamma = PPSF(4,3);% third term parameter, unit: nm
eta = PPSF(4,4); % ratio of backward scattering to forward-scattering
eta1 = PPSF(4,5);% ratio of the third term to the forward-scattering
gamma2=[]; gamma3=[];  gamma4=[]; gamma5=[]; eta2=[];eta3=[];eta4=[];eta5=[];
EEE_Y = (1/(pi*(1+eta+eta1)))*((1/(alpha^2))*exp(-(x/alpha))+(eta/(beta^2))*exp(-(x/beta))+(eta1/(gamma^2))*exp(-(x/gamma)));
%% 7G
a1 =        2059;
b1 =      -3.717;
c1 =       1.222 ;
a2 =   4.243e-06;
b2 =       44.17;
c2 =       80.98;
a3 =   8.072e-05 ;
b3 =       10.74;
c3 =        19.5 ;
a4 =       98.12 ;
b4 =      -33.22;
c4 =       11.12;
a5 =  -2.593e-05 ;
b5 =       29.79 ;
c5 =        2.11;
a6 =   0.0002444  ;
b6 =       69.23  ;
c6 =     0.00152  ;
a7 =   3.421e-06  ;
b7 =       52.64 ;
c7 =     0.02789 ;
a8 =   0.0001661 ;
b8 =      -267.3;
c8 =       179.7;
sevenG_y1 = ...
a1*exp(-((x-b1)/c1).^2) + a2*exp(-((x-b2)/c2).^2) + ...
a3*exp(-((x-b3)/c3).^2) + a4*exp(-((x-b4)/c4).^2) + ...
a5*exp(-((x-b5)/c5).^2) + a6*exp(-((x-b6)/c6).^2) + ...
a7*exp(-((x-b7)/c7).^2) + a8*exp(-((x-b8)/c8).^2);
%% 3E3G
X = [348.308345864905 585.810796121355 67.2344592187802 731.296674226377 15.7027438051050 96.0964893692088 489.859273178152 853.178924393372 493.831196939466 999.394819623255 997.389938985519 0.881604703802533 33.4433778309855 44.5673177070836 16.2481463805340 458.865877550379 36.0040763637305 584.471217057199];
ThreeG_ThreeE_y1 = (X(18)/(pi*(1+X(7)+X(8)+X(9)+X(10)+X(11))))*...
((1/(X(1)^2))*exp(-(X(12)*x/X(1)).^2)+ ...
(X(7)/(X(2)^2))*exp(-(X(13)*x/X(2)).^2)+ ...
(X(8)/(X(3)^2))*exp(-(X(14)*x/X(3)).^2)+ ...
(X(9)/(X(4)^2))*exp(-(X(15)*x/X(4)))+ ...
(X(10)/(X(5)^2))*exp(-(X(16)*x/X(5)))+ ...
(X(11)/(X(6)^2))*exp(-(X(17)*x/X(6))));
%% 1G2E mod
X = [0.967809735435438	51.5793503305325	3.99749227006584	0.584732462507830	0.278776633629476];
oneGtwoE_mody1 = (1/(pi*(1+X(4)+X(5))))*...
((1/(X(1)^2))*exp(-(2.35*x/X(1)).^2)+ ...
(X(4)/(X(2)^2))*exp(-(x/X(2)))+ ...
(X(5)/(X(3)^2))*exp(-(x/X(3))));
%% plot
figure;
fs= 1.5;
loglog(x,y,'k','LineWidth',1);hold on;%semilogy
loglog(x,GEE_Y,'LineWidth',fs);hold on;
loglog(x,GGG_Y,'--','LineWidth',fs);hold on;
loglog(x,GG_Y,'--','LineWidth',fs);hold on;
loglog(x,EEE_Y,'--','LineWidth',fs);hold on;
loglog(x,sevenG_y1,'--','LineWidth',fs);hold on;
loglog(x,ThreeG_ThreeE_y1,'--','LineWidth',fs);hold on;
loglog(x,oneGtwoE_mody1,'LineWidth',fs);hold on;
legend('MC','GEE','GGG','GG','EEE','7G','3E3G','1G2GMod');%xlim([1 500]);
set(gca,'FontSize',17);
title('TaTe2')