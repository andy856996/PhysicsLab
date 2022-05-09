clear;clc;close all;
path = 'C:\Users\andy8\Desktop\HYY_DAT2\';
figSavePath = 'C:\Users\andy8\Desktop\saveFigure\';
folderPath_list = dir(strcat(path,'*.mat'));

formula_arr{1} = '(1/(pi*(1+x(3))))*((1/(x(1)^2))*exp(-(X/x(1)))+(x(3)/(x(2)^2))*exp(-(X/x(2))));';%EE
formula_arr{2} = '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)))+(x(4)/(x(2)^2))*exp(-(X/x(2)))+(x(5)/(x(3)^2))*exp(-(X/x(3))));';%EEE
formula_arr{3} = '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)))+(x(4)/(x(2)^2))*exp(-(X/x(2)))+(x(5)/(x(3)^2))*exp(-(X/x(3)).^2));';%EEG
formula_arr{4} = '(1/(pi*(1+x(3))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(3)/(x(2)^2))*exp(-(X/x(2))));';%GE
formula_arr{5} = '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(4)/(x(2)^2))*exp(-(X/x(2)))+(x(5)/(x(3)^2))*exp(-(X/x(3)).^2));';%GEG
formula_arr{6} = '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(4)/(x(2)^2))*exp(-(X/x(2)).^2)+(x(5)/(x(3)^2))*exp(-(X/x(3))));';%GGE
formula_arr{7} = '(1/(pi*(1+x(3))))*((1/(x(1)^2))*exp(-(X/x(1)))+(x(3)/(x(2)^2))*exp(-(X/x(2)).^2));';%EG
formula_arr{8} = '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)))+(x(4)/(x(2)^2))*exp(-(X/x(2)).^2)+(x(5)/(x(3)^2))*exp(-(X/x(3)).^2));';%EGG
formula_arr{9} = '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)))+(x(4)/(x(2)^2))*exp(-(X/x(2)).^2)+(x(5)/(x(3)^2))*exp(-(X/x(3))));';%EGE
formula_arr{10} = '(1/(pi*(1+x(3))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(3)/(x(2)^2))*exp(-(X/x(2)).^2));';%GG
formula_arr{11} = '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(4)/(x(2)^2))*exp(-(X/x(2)))+(x(5)/(x(3)^2))*exp(-(X/x(3))));';%GEE
formula_arr{12} = '(1/(pi*(1+x(4)+x(5))))*((1/(x(1)^2))*exp(-(X/x(1)).^2)+(x(4)/(x(2)^2))*exp(-(X/x(2)).^2)+(x(5)/(x(3)^2))*exp(-(X/x(3)).^2));';%GGG
formula_GE = {'EE' 'EEE' 'EEG' 'GE' 'GEG' 'GGE' 'EG' 'EGG' 'EGE' 'GG' 'GEE' 'GGG'};


for i =1:length(folderPath_list)
    psf_name = [path folderPath_list(i).name];
    martial = erase(erase(psf_name,'C:\Users\andy8\Desktop\HYY_DAT2\EUV_mask_'),'_100w_Dv500_500_200_PSF.mat');
    writematrix(['----------' martial '-----------'],'dat.dat', "WriteMode" , "append" )
    for j = 1:length(formula_arr)
        [save_min,save_error] = fminsearchEnergyLognsseLog(psf_name,figSavePath,formula_arr{j},formula_GE{j});
        writematrix(formula_GE{j},'dat.dat', "WriteMode" , "append" )
        writematrix([save_min save_error],'dat.dat', "WriteMode" , "append" )
    end
end






